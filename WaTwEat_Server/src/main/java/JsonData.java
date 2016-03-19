import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Created by liubingfeng on 19/03/2016.
 */
public class JsonData
{
    String status = Controller.SUCCESS;
    ArrayList<Object> array = new ArrayList<Object>();

    JsonData()
    {
    }

    JsonData(String status)
    {
        this.status = status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }


}
