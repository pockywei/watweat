/**
 * Created by liubingfeng on 18/03/2016.
 */
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.google.gson.Gson;


import static spark.Spark.*;
public class Main
{
    public static void main(String[] args)
    {
        Gson gson = new Gson();
        Log.setLogLevel(Log.DEBUG);
        Log.logInfo(Main.class,"Test Debugging Log");

        post("/client_json", "application/json", (request, response) ->
        {
            System.out.println("in here => " + request.body());
            return request.body();
        });



        get("/hello", (request, response) -> new TestInfor(),gson::toJson);




        //testing pushing
        String url = "https://maps.googleapis.com/maps/api/geocode/json";
        HttpResponse<JsonNode> jsonResponse;
        try {
            jsonResponse = Unirest.get(url)
                    .header("accept", "application/json")
                    .queryString("address", "1600")
                    .asJson();
            System.out.println(jsonResponse.getBody().getObject().getJSONArray("results"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
