/**
 * Created by liubingfeng on 18/03/2016.
 */
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.google.gson.Gson;


import java.sql.*;

import static spark.Spark.*;
public class Main
{
    public static void main(String[] args) throws SQLException, ClassNotFoundException, IllegalAccessException, InstantiationException {
        //Gson gson = new Gson();
        Log.setLogLevel(Log.DEBUG);
        Log.logInfo(Main.class, "Test Debugging Log");
        Controller controller = new Controller();

        controller.startServer();

/*
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");

        Statement st = con.createStatement();
        String sql ;//= ("USE mydb;");
        //ResultSet rs = st.executeQuery(sql);
        sql = "SELECT * FROM Restaurant;";
        ResultSet rs = st.executeQuery(sql);
        if(rs.next()) {
            int id = rs.getInt("idRestaurant");
            String str1 = rs.getString("name");
            System.out.println(" id => "+id+" str1 => "+str1);
        }


*/




        //testing pushing
        /*
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
        }*/
    }
}
