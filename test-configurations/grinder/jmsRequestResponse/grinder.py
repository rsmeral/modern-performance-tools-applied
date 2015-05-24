from net.grinder.script.Grinder import grinder
from net.grinder.script import Test
from java.util import Properties, Random
from javax.jms import Session, DeliveryMode
from javax.naming import Context, InitialContext
 
# Look up connection factory and queue in JNDI.
properties = Properties()
properties[Context.PROVIDER_URL] = "remote://server:4447"
properties[Context.SECURITY_PRINCIPAL] = "test"
properties[Context.SECURITY_CREDENTIALS] = "testtest1!"
properties[Context.INITIAL_CONTEXT_FACTORY] = "org.jboss.naming.remote.client.InitialContextFactory"

initialContext = InitialContext(properties)

connectionFactory = initialContext.lookup("jms/RemoteConnectionFactory")
requestQueue = initialContext.lookup("jms/queue/EchoRequestQueue")
responseQueue = initialContext.lookup("jms/queue/EchoResponseQueue")
 
# Create objects
connection = connectionFactory.createConnection("test", "testtest1!")
connection.start()

test1 =  Test(1, "JMS Request Response")
 
class TestRunner:
    def __call__(self):
        session = connection.createSession(0, Session.AUTO_ACKNOWLEDGE)
        producer = session.createProducer(requestQueue)
        producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT)
        consumer = session.createConsumer(responseQueue, "JMSCorrelationID='" + str(grinder.threadNumber) + "'")
        test1.record(producer)
        test1.record(consumer)
        
        for i in range(0, 1000):
            toSend = session.createTextMessage("Hello")
            toSend.setJMSCorrelationID(str(grinder.threadNumber))
            producer.send(toSend)
            consumer.receive()
        
        session.close()