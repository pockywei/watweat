import com.google.gson.Gson;
import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by liubingfeng on 19/03/2016.
 */
public class unitTest
{

    @Test
    public void sqlTest()
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
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
            //need this to send query
            //concurrent ...
            st = con.createStatement();

            String sql = "SELECT * FROM Restaurant WHERE name = 'testtest';";
            ResultSet rs = st.executeQuery(sql);
            rs.next();
            System.out.println("=========" + rs.getString("name"));

        }
        catch (Exception e)
        {
            System.out.println("===error==="+e.getMessage());
        }
    }
}
