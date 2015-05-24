package cz.muni.fi.xsmeral.echoapp.rest;

import javax.ws.rs.*;

@Path("/echo")
public class RestEcho {

    @GET
    @Produces("text/plain")
    public String echoGet() {
        return "Hello REST GET";
    }
    
    @POST
    @Produces("text/plain")
    @Consumes("text/plain")
    public String echoPost() {
        return "Hello REST POST";
    }
    
    @PUT
    @Produces("text/plain")
    @Consumes("text/plain")
    public String echoPut() {
        return "Hello REST PUT";
    }
    
}
