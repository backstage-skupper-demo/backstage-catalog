package org.redhat.janus;

import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/")
@RegisterRestClient(configKey="vm")
public interface VmRestClient {

    @GET
    @Path("{name}")
    String sayHello(@PathParam("name") String name);
}