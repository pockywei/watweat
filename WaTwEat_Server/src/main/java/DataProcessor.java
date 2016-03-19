import java.sql.ResultSet;
import java.util.Objects;

/**
 * Created by liubingfeng on 19/03/2016.
 */
public interface DataProcessor
{
    JsonData start(ResultSet rs);
}
