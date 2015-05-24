package cz.muni.fi.xsmeral.faban;

import com.sun.faban.driver.*;
import cz.muni.fi.xsmeral.echoapp.ws.EchoService;
import cz.muni.fi.xsmeral.echoapp.ws.WsEchoEndpoint;

import javax.xml.xpath.XPathExpressionException;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Simple web driver example.
 */
@BenchmarkDefinition(
        name = "Fixed WS Invoke",
        version = "0.1"
)
@BenchmarkDriver(
        name = "WSInvokeDriver",
        threadPerScale = 1
)
@FixedSequence(
        value = "WSInvokeOperation"
)
@FixedTime(
        cycleTime = 0,
        cycleType = CycleType.THINKTIME,
        cycleDeviation = 0
)
public class WSInvokeDriver {

    /**
     * The driver context for this instance.
     */
    private DriverContext ctx;
    private Logger logger;
    private WsEchoEndpoint echo;

    /**
     * Constructs the web driver.
     *
     * @throws XPathExpressionException An XPath error occurred
     */
    public WSInvokeDriver() throws XPathExpressionException {
        ctx = DriverContext.getContext();
        logger = ctx.getLogger();
        HttpTransport.newInstance();
        echo = new EchoService().getEcho();
    }

    @BenchmarkOperation(
            name = "WSInvokeOperation",
            timing = Timing.AUTO
    )
    public void wsInvokeOperation() throws IOException {
//        ctx.recordTime();
        echo.sayHello();
//        ctx.recordTime();
    }
}
