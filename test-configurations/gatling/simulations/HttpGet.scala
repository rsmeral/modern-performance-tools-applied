import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class HttpGet extends Simulation {

  val totalDuration = (600 seconds)

  val httpConf = http
    //.shareConnections
    .warmUp("http://server:8080")
    .baseURL("http://server:8080/echoapp")

  val scn = scenario("HTTP GET")
    .repeat(120000) {exec(http("request_1").get("/http/echo")) }
  

  setUp(
    scn.inject(
      atOnceUsers(200)
    ).protocols(httpConf)
  ).pauses(disabledPauses)
   .maxDuration(totalDuration)

}