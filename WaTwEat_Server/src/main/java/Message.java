/**
 * Created by liubingfeng on 19/03/2016.
 */
public class Message
{
    String sender_alias;
    String content;
    int time_sent;

    public Message(String sender_alias, String content,int time_sent) {

        this.sender_alias = sender_alias;
        this.content = content;
        this.time_sent = time_sent;
    }
}
