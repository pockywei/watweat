/**
 * Created by liubingfeng on 18/03/2016.
 */
import static spark.Spark.*;
public class Main
{
    public static void main(String[] args)
    {
        get("/", (req, res) -> "Hello, World!");
        //testing pushing
    }
}
