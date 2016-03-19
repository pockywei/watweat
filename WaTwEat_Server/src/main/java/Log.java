import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by liubingfeng on 19/03/2016.
 */
public class Log
{
    public final static int DEBUG=1;
    public final static int NONE=0;
    public static int LOG_LEVEL=NONE;
    static Calendar cal = Calendar.getInstance();
    static SimpleDateFormat  sdf = new SimpleDateFormat("YYYY:MM:dd:HH:mm:ss");
    //System.out.println( sdf.format(cal.getTime()) );
    public static void logInfo(Class classnames,String msg)
    {
        if(LOG_LEVEL==1)
        {
            System.out.println(""+sdf.format(cal.getTime())+" "+
                    "[ Class:"+classnames.getName()+" ]"+
                    "[ Method:"+ Thread.currentThread().getStackTrace()[2].getMethodName()+" ]"+
                    msg);
        }
    }

    public static void setLogLevel(int logLevel)
    {
        LOG_LEVEL=logLevel;
    }
}
