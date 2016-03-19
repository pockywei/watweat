import com.google.gson.Gson;

import static spark.Spark.get;
import static spark.Spark.post;

/**
 * Created by liubingfeng on 19/03/2016.
 */
public class Controller
{
    Gson gson = new Gson();

    public void startServer()
    {
        startTestGet();
        startTestPost();
        startTestGetParams();
    }

    public void startTestPost()
    {
        post("/test_post", "application/json", (request, response) ->
        {
            //System.out.println("in here => " + request.body());
            Log.logInfo(Controller.class, "Test post");
            return "request body => " + request.body() + " received ";
        });
    }

    public void startTestGet()
    {
        get("/test_get", (request, response) ->
        {
            Log.logInfo(Controller.class, "Test get");
            return new TestInfor();
        }, gson::toJson);
    }

    public void startTestGetParams()
    {
        get("/test_get/:name", (request, response) ->
        {
            Log.logInfo(Controller.class, "Test get param 'name'");
            return "Param name => "+request.params("name");
        });
    }
}
