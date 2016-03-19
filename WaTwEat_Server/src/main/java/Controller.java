import com.google.gson.Gson;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Objects;

import static spark.Spark.get;
import static spark.Spark.post;

/**
 * Created by liubingfeng on 19/03/2016.
 */
public class Controller
{
    Gson gson = new Gson();
    String dbSchema="mydb";
    String dbPORT="3306";
    String dbAddr="localhost";
    String dbURL ="jdbc:mysql://"+dbAddr+":"+dbPORT+"/"+dbSchema+"?autoReconnect=true&useSSL=false";
    String dbUserName="root";
    String dbPassword="root";
    Connection con ;
    Statement st;

    public Object processingData(String sql,DataProcessor dataProcessor)
    {

        try
        {
            //st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            return dataProcessor.start(rs);
        }
        catch (Exception e)
        {
            Log.logInfo(Controller.class, " sql query failed => "+sql+ e.getMessage());
            return false;
        }

    }

    public void startServer()
    {
        while(!startConnectionDB(dbURL,dbUserName,dbPassword))
        {
            try
            {
                Thread.sleep(50);
            }
            catch (Exception e)
            {
                Log.logInfo(Controller.class,"Connection To DB failed, Thread is sleeping");
            }
        }
        startTestGet();
        startTestPost();
        startTestGetParams();
        startRestaurantDetailGetByName();
        startRestaurantChatMessage();
        public void startGetUserChatRoomMsg();
    }

    public void startRestaurantChatMessage() {
        post("/restaurant_chat", (request, response) ->
        {
            System.out.println("post received => " + request.queryParams("alias"));
            return new TestInfor();
            //return new TestInfor();
        }, gson::toJson);
    }

    public void startGetUserChatRoomMsg()
    {
        get("/restaurant/:r_name", (request, response) ->
        {
            //String completeSQL=SqlQuery.SQL_GET_RESTAUANT_DETAIL_BY_NAME  + "'" + request.params("r_name")+"'"+";";
            String completeSQL = String.format(SqlQuery.SQL_GET_RESTARUANT_DETAIL_BY_NAME, request.params("r_name"));
            Log.logInfo(Controller.class, "Get restauant name query => " + completeSQL);
            return processingData(completeSQL,
                    (rs) ->
                    {
                        JsonData jsonData = new JsonData();
                        try {
                            while (rs.next()) {
                                jsonData.array.add(new Restaurant(rs.getInt("idRestaurant"),
                                        rs.getString("name"),
                                        rs.getInt("phoneNo"),
                                        rs.getString("street"),
                                        rs.getString("suburb"),
                                        rs.getString("city"),
                                        rs.getInt("owner_user_idUser")));
                            }
                            return jsonData;
                        } catch (Exception e) {
                            Log.logInfo(Controller.class, "Processing Restaurant Sql Failed => " + e.getMessage());
                        }
                        return null;
                    });
            //return new TestInfor();
        }, gson::toJson);
    }

    public void startRestaurantDetailGetByName()
    {
        get("/restaurant/:r_name", (request, response) ->
        {
            //String completeSQL=SqlQuery.SQL_GET_RESTAUANT_DETAIL_BY_NAME  + "'" + request.params("r_name")+"'"+";";
            String completeSQL = String.format(SqlQuery.SQL_GET_RESTARUANT_DETAIL_BY_NAME, request.params("r_name"));
            Log.logInfo(Controller.class, "Get restauant name query => " + completeSQL);
            return processingData(completeSQL,
                    (rs) ->
                    {
                        JsonData jsonData = new JsonData();
                        try {
                            while(rs.next())
                            {
                                jsonData.array.add(new Restaurant(rs.getInt("idRestaurant"),
                                        rs.getString("name"),
                                        rs.getInt("phoneNo"),
                                        rs.getString("street"),
                                        rs.getString("suburb"),
                                        rs.getString("city"),
                                        rs.getInt("owner_user_idUser")));
                            }
                            return jsonData;
                        } catch (Exception e) {
                            Log.logInfo(Controller.class, "Processing Restaurant Sql Failed => " +e.getMessage());
                        }
                        return null;
                    });
            //return new TestInfor();
        }, gson::toJson);
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

    public void startTestGet() {
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

    public boolean startConnectionDB(String dbURL,String userName,String password)
    {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(dbURL, userName, password);
            //need this to send query
            //concurrent ...
            st = con.createStatement();
            String sql = "SHOW TABLES;";
            ResultSet rs = st.executeQuery(sql);
            Log.logInfo(Controller.class, " db Connection Successful=> " + dbURL);
            while(rs.next())
            {
                System.out.println("" + rs.getString("Tables_in_mydb"));
            }

            return true;
        }
        catch (Exception e)
        {
            Log.logInfo(Controller.class, " db Connection failed => "+dbURL+ e.getMessage());
            return false;
        }
    }
}
