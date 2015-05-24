import io.gatling.core.Predef._
import io.gatling.jms.Predef._
import javax.jms._
import scala.concurrent.duration._

class JmsRequestResponse extends Simulation {

  val totalDuration = (600 seconds)

  val jmsConf = jms
    .connectionFactoryName("jms/RemoteConnectionFactory")
    .url("remote://server:4447")
    .credentials("test", "testtest1!")
    .contextFactory("org.jboss.naming.remote.client.InitialContextFactory")
    .listenerCount(1)
    .useNonPersistentDeliveryMode

  val scn = scenario("JMS Request Response").repeat(500000) {
    exec(jms("req response testing").reqreply
      .queue("EchoRequestQueue")
      .replyQueue("EchoResponseQueue")
      .textMessage("Hello")
    )
  }

  setUp(
    scn.inject(
      atOnceUsers(50)
    ).protocols(jmsConf)
  ).pauses(disabledPauses)
   .maxDuration(totalDuration)

}