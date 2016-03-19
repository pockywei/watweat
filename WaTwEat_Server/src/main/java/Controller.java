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
        startRegisterMsg();
    }

    public void startRegisterMsg()
    {
        get("/restaurant_chat_send/:user_id/:restaurant_id/:message", (request, response) ->
        {
            String completeSQL;
            int last_id;
            int idUser = Integer.parseInt(request.params("user_id"));
            int idRestaurant = Integer.parseInt(request.params("restaurant_id"));
            int idGroupChat;
            String content = request.params("message");
            ResultSet rs;
            Log.logInfo(Controller.class, "start get message, id => "+idUser+", rest id =>"+idRestaurant+" ,content => "+content);

            try
            {
                completeSQL = String.format(SqlQuery.SQL_GET_GROUP_ID,idRestaurant);
                Log.logInfo(Controller.class, "idGroupChat query => "+completeSQL);
                rs = st.executeQuery(completeSQL);
                rs.next();
                idGroupChat = rs.getInt("idGroupChat");


                completeSQL = String.format(SqlQuery.SQL_INSERT_MESSAGE, idRestaurant, content, (int) (System.currentTimeMillis() / 1000), idUser);
                Log.logInfo(Controller.class, "insert into Message query => " + completeSQL);
                st.executeUpdate(completeSQL);
                //con.commit();

                completeSQL = SqlQuery.SQL_LAST_ID;
                Log.logInfo(Controller.class, "get last id => " + completeSQL);
                rs = st.executeQuery(completeSQL);
                rs.next();
                last_id = rs.getInt("last_id");

                //result set get closed after last id 
                st=con.createStatement();

                Log.logInfo(Controller.class, "last idMessage => "+last_id);

                completeSQL = String.format(SqlQuery.SQL_GROUP_USERS_MSG_REGISTER,idGroupChat);
                Log.logInfo(Controller.class, "idUserGroupChat query => "+completeSQL);
                st.executeQuery(completeSQL);
                while(rs.next())
                {
                    completeSQL = String.format(SqlQuery.SQL_INSERT_USER_MESSAGE,last_id,rs.getInt("idUserGroupChat"),"FALSE");
                    Log.logInfo(Controller.class, "inserting UserMessage  => "+completeSQL);
                    st.executeQuery(completeSQL);
                }
                //con.commit();
            }
            catch(Exception e)
            {
                Log.logInfo(Controller.class, "processing messge registration query failed "+e.getMessage());
                return null;
            }


            return new TestInfor();
        },gson::toJson);
    }

    public void startRestaurantChatMessage() {
        get("/restaurant_chat/:user_id/:restaurant_id", (request, response) ->
        {
            //Log.logInfo(Controller.class, "Get restauant name query => " + completeSQL);
            int restaurantId = Integer.parseInt(request.params("restaurant_id"));
            int userId = Integer.parseInt(request.params("user_id"));
            int idGroupChat ;
            int idUserGroupChat;
            String completeSQL;
            ResultSet rs;
            Log.logInfo(Controller.class, "start get message, id => "+userId+", rest id =>"+restaurantId);
            try
            {
                JsonData jsonData = new JsonData();
                completeSQL = String.format(SqlQuery.SQL_GET_GROUP_ID,restaurantId);
                rs = st.executeQuery(completeSQL);
                rs.next();
                idGroupChat = rs.getInt("idGroupChat");
                Log.logInfo(Controller.class, "idGroupChat query => "+completeSQL);


                completeSQL = String.format(SqlQuery.SQL_GET_USERS_IN_SAME_GROUP_CHAT, idGroupChat,userId);
                rs = st.executeQuery(completeSQL);
                rs.next();
                idUserGroupChat = rs.getInt("idUserGroupChat");

                Log.logInfo(Controller.class, "idUserGroupChat query => "+completeSQL);

                completeSQL = String.format(SqlQuery.SQL_GET_ONE_USER_IN_ONE_CHART_ROOM_MSG, idUserGroupChat,"FALSE",idUserGroupChat,"FALSE");
                rs = st.executeQuery(completeSQL);

                Log.logInfo(Controller.class, "messges query => "+completeSQL);

                while(rs.next())
                {
                    jsonData.array.add(new Message(rs.getInt("idSender"), rs.getString("content"), rs.getInt("time_sent")));
                };

                completeSQL = String.format(SqlQuery.SQL_SET_ONE_USER_MSG_AS_ALREADY_READ, idUserGroupChat);
                Log.logInfo(Controller.class, "messges update has_read query => " + completeSQL);
                st.executeUpdate(completeSQL);

                //con.commit();
                return jsonData;
            }
            catch (Exception e)
            {
                Log.logInfo(Controller.class, "processing message query failed ");
                return null;
            }

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
            return new TestInfor();
        },gson::toJson);
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
