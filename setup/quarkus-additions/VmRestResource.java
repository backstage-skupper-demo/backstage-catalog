package org.redhat.janus;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.eclipse.microprofile.rest.client.inject.RestClient;

@Path("/external")
public class VmRestResource {
    @RestClient
    VmRestClient vmRestClient;

    @RestClient
    LaptopRestClient laptopRestClient;

    @GET
    @Path("/vm/{name}")
    @Produces(MediaType.TEXT_PLAIN)
    public String helloFromVm(@PathParam("name") String name) {
        try {
            return vmRestClient.sayHello(name);
        } catch(Exception ex) {
            return ex.toString();
        }
    }

    @GET
    @Path("/laptop/{name}")
    @Produces(MediaType.TEXT_PLAIN)
    public String helloFromLaptop(@PathParam("name") String name) {
        try {
            return laptopRestClient.sayHello(name);
        } catch(Exception ex) {
            return ex.toString();
        }
    }
}