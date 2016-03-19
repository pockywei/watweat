/**
 * Created by liubingfeng on 19/03/2016.
 */
public class Message
{
    int idSender;
    String content;
    int time_sent;

    public Message(int idSender, String content,int time_sent) {
        this.idSender = idSender;
        this.content = content;
        this.time_sent = time_sent;
    }
}
