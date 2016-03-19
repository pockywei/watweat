/**
 * Created by liubingfeng on 19/03/2016.
 */
public class SqlQuery
{
    public static String SQL_GET_ALL_RESTARUANT_DETAILS = "SELECT * FROM Restaurant;";

    public static String SQL_GET_RESTARUANT_DETAIL_BY_NAME = "SELECT * FROM Restaurant WHERE name = '%s';";

    public static String SQL_GET_USER_ID ="SELECT idUser FROM User WHERE alias = '%s' ";

    public static String SQL_GET_RESTAURANT_ID="SELECT idRestaurant FROM Restaurant WHERE name = '%s';";

    public static String SQL_GET_GROUP_ID = "SELECT idGroupChat FROM GroupChat WHERE restaurant_idRestaurant = %d ;";

    public static String SQL_GET_USERS_IN_SAME_GROUP_CHAT = "SELECT idUserGroupChat FROM UserGroupChat WHERE GroupChat_idGroupChat = %d and User_idUser = %d;";

    //public static String SQL_GET_ONE_USER_IN_ONE_CHAT_ROOM_MESSAGE_ID = "SELECT Message_idMessage FROM UserMessage WHERE UserGroupChat_idUserGroupChat = %d and has_read = %s ;";

    public static String SQL_GET_ONE_USER_IN_ONE_CHART_ROOM_MSG ="SELECT content,idSender,time_sent FROM Message WHERE idMessage IN " +
            "(SELECT Message_idMessage FROM UserMessage WHERE UserGroupChat_idUserGroupChat = %d and has_read = %s)  " +
            "ORDER BY time_sent;";

    public static String SQL_SET_ONE_USER_MSG_AS_ALREADY_READ ="UPDATE UserMessage SET has_read = TRUE WHERE UserGroupChat_idUserGroupChat =%d ";

    // store message

    //public static String SQL_GROUP_USERS_MSG_REGISTER = "SELECT User_idUser FROM UserGroupChat WHERE GroupChat_idGroupChat IN (SELECT idGroupChat FROM GroupChat WHERE restaurant_idRestaurant = %d);";
    public static String SQL_GROUP_USERS_MSG_REGISTER = "SELECT idUserGroupChat FROM UserGroupChat WHERE GroupChat_idGroupChat = %d;";

    public static String SQL_INSERT_MESSAGE = "INSERT INTO Message (GroupChat_idGroupChat , content , time_sent , idSender) VALUES(%d , '%s' , %d , %d) ;";

    public static String SQL_INSERT_USER_MESSAGE = "INSERT INTO UserMessage (Message_idMessage , UserGroupChat_idUserGroupChat , has_read) " +
            "VALUES(%d , %d , %s) ;";
    public static String SQL_LAST_ID = "SELECT LAST_INSERT_ID() as last_id;";

    public static String SQL_GET_ALIAS = "SELECT alias FROM User WHERE idUser = %d;";
}
