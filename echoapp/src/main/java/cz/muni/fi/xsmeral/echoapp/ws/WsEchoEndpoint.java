package cz.muni.fi.xsmeral.echoapp.ws;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService(targetNamespace = "http://xsmeral.fi.muni.cz/echoapp/ws")
public interface WsEchoEndpoint {

    @WebMethod
    public String sayHello();
    
}
