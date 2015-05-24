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
        name = "Fixed REST GET",
        version = "0.1"
)
@BenchmarkDriver(
        name = "RESTGetDriver",
        threadPerScale = 1
)
@FixedSequence(
        value = "RESTGetOperation"
)
@FixedTime(
        cycleTime = 0,
        cycleType = CycleType.THINKTIME,
        cycleDeviation = 100
)
public class RESTGetDriver {

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
    public RESTGetDriver() throws XPathExpressionException {
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
            name = "RESTGetOperation",
            timing = Timing.AUTO
    )
    public void simpleRestOperation() throws IOException {
        http.fetchURL(url);
//        if (ctx.isTxSteadyState()) {
//            contentStats.sumContentSize[ctx.getOperationId()] += http.getContentSize();
//        }
    }
}
