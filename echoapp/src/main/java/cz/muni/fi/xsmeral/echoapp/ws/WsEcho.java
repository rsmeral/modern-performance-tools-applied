package cz.muni.fi.xsmeral.echoapp.ws;

import javax.jws.WebService;

@WebService(serviceName = "EchoService", 
        portName = "Echo", 
        endpointInterface = "cz.muni.fi.xsmeral.echoapp.ws.WsEchoEndpoint", 
        targetNamespace = "http://xsmeral.fi.muni.cz/echoapp/ws")
public class WsEcho implements WsEchoEndpoint {

    @Override
    public String sayHello() {
        return "Hello WS";
    }

}
