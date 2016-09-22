package ru.kurau.server;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import ru.kurau.server.CalcParser;

import static java.lang.String.format;

/**
 * Created by kurau.
 */
@Path("calc")
public class RootResource {

    @POST
    @Path("/qlate")
    @Produces(MediaType.APPLICATION_JSON)
    public String calculateItToo(String expression) {
        return format("{\"result\": \"%s\"}", evaluate(expression));
    }

    private String evaluate(String expression) {
        ru.kurau.server.CalcLexer calc = new ru.kurau.server.CalcLexer(
                new ANTLRInputStream(expression));
        CommonTokenStream tokens = new CommonTokenStream(calc);
        CalcParser parser = new CalcParser(tokens);
        return String.valueOf(parser.eval().value);
    }
}
