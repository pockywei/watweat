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

    public static String SQL_GET_USERS_IN_SAME_GROUP_CHAT = "SELECT User_idUser FROM UserGroupChat WHERE GroupChat_idGroupChat = %d ;";

    public static String SQL_GET_ONE_USER_IN_ONE_CHAT_ROOM_MESSAGE_ID = "SELECT Message_idMessage FROM UserMessage WHERE UserGroupChat_idUserGroupChat = %d and read = %s ;";

    public static String SQL_GET_ONE_USER_IN_ONE_CHART_ROOM_MSG ="SELECT content FROM Message WHERE idMessage = %d ORDER BY time_sent;";

    public static String SQL_SET_ONE_USER_MSG_AS_ALREADY_READ ="UPDATE UserMessage SET read=TRUE WHERE UserGroupChat_idUserGroupChat =%d "

}
