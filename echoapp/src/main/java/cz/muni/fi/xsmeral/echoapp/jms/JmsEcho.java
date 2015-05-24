package cz.muni.fi.xsmeral.echoapp.jms;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.ActivationConfigProperty;
import javax.ejb.MessageDriven;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.TextMessage;

@MessageDriven(name = "JmsEcho", activationConfig = {
    @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "javax.jms.Queue"),
    @ActivationConfigProperty(propertyName = "destination", propertyValue = "queue/EchoRequestQueue"),
    @ActivationConfigProperty(propertyName = "acknowledgeMode", propertyValue = "Dups-OK-Acknowledge")})
@TransactionManagement(TransactionManagementType.BEAN)
@TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
public class JmsEcho implements MessageListener {

    @Resource(mappedName = "java:/queue/EchoResponseQueue")
    private Queue responseQueue;

    @Resource(mappedName = "java:/ConnectionFactory")
    private ConnectionFactory connectionFactory;

    private final static Logger LOGGER = Logger.getLogger(JmsEcho.class.toString());
    private Session session;
    private MessageProducer messageProducer;
    private Connection connection;

    @PostConstruct
    public void initializeBean() {
        try {
            connection = connectionFactory.createConnection();
            session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            messageProducer = session.createProducer(responseQueue);
            messageProducer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
            connection.start();
        } catch (JMSException ex) {
            Logger.getLogger(JmsEcho.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void onMessage(Message rcvMessage) {
        TextMessage msg = null;
        try {
            if (rcvMessage instanceof TextMessage) {
                TextMessage message = session.createTextMessage();
                if (rcvMessage.getJMSCorrelationID() == null || rcvMessage.getJMSCorrelationID().isEmpty()) {
                    message.setJMSCorrelationID(rcvMessage.getJMSMessageID());
                } else {
                    message.setJMSCorrelationID(rcvMessage.getJMSCorrelationID());
                }
                message.setText("Hello JMS");
                messageProducer.send(message);
            } else {
                LOGGER.log(Level.WARNING, "Message of wrong type: {0}", rcvMessage.getClass().getName());
            }
        } catch (JMSException e) {
            if (connection != null) {
                try {
                    connection.close();
                } catch (JMSException ex) {
                    e.printStackTrace();
                }
            }
            throw new RuntimeException(e);
        }
    }

}
