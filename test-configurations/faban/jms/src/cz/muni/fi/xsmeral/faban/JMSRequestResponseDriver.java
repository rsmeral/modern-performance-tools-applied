package cz.muni.fi.xsmeral.faban;

import com.sun.faban.driver.BenchmarkDefinition;
import com.sun.faban.driver.BenchmarkDriver;
import com.sun.faban.driver.BenchmarkOperation;
import com.sun.faban.driver.CycleType;
import com.sun.faban.driver.DriverContext;
import com.sun.faban.driver.FixedSequence;
import com.sun.faban.driver.FixedTime;
import com.sun.faban.driver.OnceBefore;
import com.sun.faban.driver.Timing;
import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.xml.xpath.XPathExpressionException;

/**
 * Simple web driver example.
 */
@BenchmarkDefinition(
        name = "Fixed JMS Request Response",
        version = "0.1"
)
@BenchmarkDriver(
        name = "JMSRequestResponseDriver",
        threadPerScale = 1
)
@FixedSequence(
        value = "JMSRequestResponseOperation"
)
@FixedTime(
        cycleTime = 0,
        cycleType = CycleType.THINKTIME,
        cycleDeviation = 100
)
public class JMSRequestResponseDriver {

    private static final AtomicInteger DRIVER_ID = new AtomicInteger();
    private static final String INITIAL_CONTEXT_FACTORY = "org.jboss.naming.remote.client.InitialContextFactory";

    private static MessageCoordinator coordinator;

    private DriverContext ctx;
    private Logger logger;
    private ConnectionFactory connectionFactory = null;
    private Connection connection = null;
    private Session session = null;
    private MessageProducer producer = null;
    private Destination requestQueue = null;
    private Context context = null;
    private int driverId;

    public static class MessageCoordinator implements MessageListener {

        private final ConcurrentHashMap<String, CountDownLatch> latches = new ConcurrentHashMap<>();
        private final ConcurrentHashMap<String, Message> messages = new ConcurrentHashMap<>();

        public MessageCoordinator() throws NamingException, JMSException, XPathExpressionException {
            DriverContext ctx = DriverContext.getContext();

            String host = ctx.getXPathValue("/webBenchmark/jmsConfig/host");
            String jndiPort = ctx.getXPathValue("/webBenchmark/jmsConfig/jndiPort");
            String user = ctx.getXPathValue("/webBenchmark/jmsConfig/user");
            String password = ctx.getXPathValue("/webBenchmark/jmsConfig/password");
            String connectionFactoryName = ctx.getXPathValue("/webBenchmark/jmsConfig/connectionFactory");
            String responseQueueName = ctx.getXPathValue("/webBenchmark/jmsConfig/responseQueue");
            String providerUrl = "remote://" + host + ":" + jndiPort;

            Properties env = new Properties();
            env.put(Context.INITIAL_CONTEXT_FACTORY, INITIAL_CONTEXT_FACTORY);
            env.put(Context.PROVIDER_URL, providerUrl);
            env.put(Context.SECURITY_PRINCIPAL, user);
            env.put(Context.SECURITY_CREDENTIALS, password);

            Context rcvCtx = new InitialContext(env);
            ConnectionFactory rcvConnectionFactory = (ConnectionFactory) rcvCtx.lookup(connectionFactoryName);
            Destination responseQueue = (Destination) rcvCtx.lookup(responseQueueName);

            Connection rcvConnection = rcvConnectionFactory.createConnection(user, password);
            Session rcvSession = rcvConnection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            MessageConsumer consumer = rcvSession.createConsumer(responseQueue);
            consumer.setMessageListener(this);
            rcvConnection.start();
        }

        public Message sendAndReceive(MessageProducer producer, Message msg, String id) throws InterruptedException, JMSException {
            CountDownLatch latch = new CountDownLatch(1);
            msg.setJMSCorrelationID(id);
            latches.put(id, latch);
            producer.send(msg);
            latch.await();
            return messages.get(id);
        }

        @Override
        public void onMessage(Message msg) {
            try {
                String id = msg.getJMSCorrelationID();
                messages.put(id, msg);
                latches.get(id).countDown();
            } catch (JMSException ex) {
                Logger.getLogger(JMSRequestResponseDriver.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @OnceBefore
    public void initializeOnceBefore() throws XPathExpressionException, NamingException, JMSException {
        coordinator = new MessageCoordinator();
    }

    /**
     * Constructs the web driver.
     *
     * @throws javax.naming.NamingException
     * @throws javax.jms.JMSException
     */
    public JMSRequestResponseDriver() throws NamingException, JMSException, XPathExpressionException {
        ctx = DriverContext.getContext();
        logger = ctx.getLogger();

        String host = ctx.getXPathValue("/webBenchmark/jmsConfig/host");
        String jndiPort = ctx.getXPathValue("/webBenchmark/jmsConfig/jndiPort");
        String user = ctx.getXPathValue("/webBenchmark/jmsConfig/user");
        String password = ctx.getXPathValue("/webBenchmark/jmsConfig/password");
        String connectionFactoryName = ctx.getXPathValue("/webBenchmark/jmsConfig/connectionFactory");
        String requestQueueName = ctx.getXPathValue("/webBenchmark/jmsConfig/requestQueue");
        String providerUrl = "remote://" + host + ":" + jndiPort;

        Properties env = new Properties();
        env.put(Context.INITIAL_CONTEXT_FACTORY, INITIAL_CONTEXT_FACTORY);
        env.put(Context.PROVIDER_URL, providerUrl);
        env.put(Context.SECURITY_PRINCIPAL, user);
        env.put(Context.SECURITY_CREDENTIALS, password);

        driverId = DRIVER_ID.getAndIncrement();

        try {
            context = new InitialContext(env);
            connectionFactory = (ConnectionFactory) context.lookup(connectionFactoryName);
            requestQueue = (Destination) context.lookup(requestQueueName);

            // Create the JMS connection, session, producer, and consumer
            connection = connectionFactory.createConnection(user, password);
            session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            producer = session.createProducer(requestQueue);
            producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
            connection.start();
        } catch (NamingException | JMSException e) {
            logger.severe(e.getMessage());
            throw e;
        }
    }

    @BenchmarkOperation(
            name = "JMSRequestResponseOperation",
            timing = Timing.MANUAL
    )
    public void jmsRequestResponseOperation() throws IOException, JMSException, InterruptedException {
        Message toSend = session.createTextMessage("Hello");
        ctx.recordTime();
        Message received = coordinator.sendAndReceive(producer, toSend, String.valueOf(driverId));
        ctx.recordTime();
    }
}
