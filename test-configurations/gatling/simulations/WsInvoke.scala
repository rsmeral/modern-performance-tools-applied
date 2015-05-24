import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class WsInvoke extends Simulation {

  val totalDuration = (600 seconds)

  val httpConf = http
    //.shareConnections
    .warmUp("http://server:8080")
    .baseURL("http://server:8080/echoapp")

  val scn = scenario("WS SOAP Invoke")
    .repeat(200000) {exec(http("soap_request")
      .post("/EchoService")
      .body(RawFileBody("WsInvokeBody.xml"))
      .asXML
    )}

  setUp(
    scn.inject(
      atOnceUsers(200)
    ).protocols(httpConf)
  ).pauses(disabledPauses)
   .maxDuration(totalDuration)

}