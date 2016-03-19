/**
 * Created by liubingfeng on 19/03/2016.
 */
public class Restaurant
{
    int idRestaurant;
    String name;
    int phoneNo;
    String street;
    String suburb;
    String city;
    int owner_user_idUser;

    public Restaurant(int owner_user_idUser, String name, int phoneNo, String street, String suburb, String city, int idRestaurant)
    {
        this.owner_user_idUser = owner_user_idUser;
        this.name = name;
        this.phoneNo = phoneNo;
        this.street = street;
        this.suburb = suburb;
        this.city = city;
        this.idRestaurant = idRestaurant;
    }
}
