/**
 * Created by liubingfeng on 19/03/2016.
 */
public class Message
{
    String sender_alias;
    String message;
    int time_sent;

    public Message(String sender_alias, String message,int time_sent) {

        this.sender_alias = sender_alias;
        this.message = message;
        this.time_sent = time_sent;
    }
}
