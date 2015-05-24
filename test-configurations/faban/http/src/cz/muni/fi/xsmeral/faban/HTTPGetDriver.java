package cz.muni.fi.xsmeral.faban;

import com.sun.faban.driver.*;
import com.sun.faban.driver.util.Random;

import javax.xml.xpath.XPathExpressionException;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Simple web driver example.
 */
@BenchmarkDefinition(
        name = "Fixed HTTP GET",
        version = "0.1"
)
@BenchmarkDriver(
        name = "HTTPGetDriver",
        threadPerScale = 1
)
@FixedSequence(
        value = "HTTPGetOperation"
)
@FixedTime(
        cycleTime = 0,
        cycleType = CycleType.THINKTIME,
        cycleDeviation = 100
)
public class HTTPGetDriver {

    /**
     * The driver context for this instance.
     */
    private DriverContext ctx;
    private HttpTransport http;
    private String url;
    Logger logger;
    Random random;

    /**
     * Constructs the web driver.
     *
     * @throws XPathExpressionException An XPath error occurred
     */
    public HTTPGetDriver() throws XPathExpressionException {
        ctx = DriverContext.getContext();
        http = HttpTransport.newInstance();
        logger = ctx.getLogger();
        random = ctx.getRandom();
        String host = ctx.getXPathValue("/webBenchmark/serverConfig/host");
        String port = ctx.getXPathValue("/webBenchmark/serverConfig/port");
        String path = ctx.getProperty("path");
        url = "http://" + host + ':' + port + '/' + path;
    }
    
    @BenchmarkOperation(
            name = "HTTPGetOperation",
            timing = Timing.AUTO
    )
    public void simpleHttpOperation() throws IOException {
        http.fetchURL(url);
//        if (ctx.isTxSteadyState()) {
//            contentStats.sumContentSize[ctx.getOperationId()] += http.getContentSize();
//        }
    }
}
