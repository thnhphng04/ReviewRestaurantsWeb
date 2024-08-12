/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.AccountDetail;
import Model.Post;
import Model.Restaurant;
import jakarta.servlet.ServletContext;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author DELL
 */
public class RestaurantDAO extends DBContext {

    public void insertRestaurant(String name, String address, String phoneNumber, String lowestPrice, String highestPrice, Time openTime, Time closeTime, String accountId, String avatarPath) throws FileNotFoundException {
        //sql
        String sql = "INSERT INTO restaurant (restaurant_id, name, address, phone_number, lowest_price, highest_price, open_time, close_time, avatar, status, account_id) "
                + "VALUES ((SELECT ISNULL(MAX(restaurant_id) + 1, 1) FROM restaurant), ?, ?, ?, ?, ?, ?, ?, ?, 2, ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, address);
            st.setString(3, phoneNumber);
            st.setString(4, lowestPrice);
            st.setString(5, highestPrice);
            st.setTime(6, openTime);
            st.setTime(7, closeTime);

            InputStream inputStream = new FileInputStream(avatarPath);
            st.setBinaryStream(8, inputStream);

            st.setString(9, accountId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public void insertEditRestaurant(String name, String address, String phoneNumber, String lowestPrice, String highestPrice, Time openTime, Time closeTime, String accountId, String avatarPath, String edit_of) throws FileNotFoundException {
        //sql
        String sql = "INSERT INTO restaurant (restaurant_id, name, address, phone_number, lowest_price, highest_price, open_time, close_time, avatar, status, account_id, edit_of) "
                + "VALUES ((SELECT ISNULL(MAX(restaurant_id) + 1, 1) FROM restaurant), ?, ?, ?, ?, ?, ?, ?, ?, 4, ?, ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, address);
            st.setString(3, phoneNumber);
            st.setString(4, lowestPrice);
            st.setString(5, highestPrice);
            st.setTime(6, openTime);
            st.setTime(7, closeTime);

            InputStream inputStream = new FileInputStream(avatarPath);
            st.setBinaryStream(8, inputStream);

            st.setString(9, accountId);

            st.setString(10, edit_of);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public Restaurant getRestaurantById(int RestaurantId, ServletContext context) {
        String sql = "SELECT * FROM restaurant where restaurant_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, RestaurantId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int restaurantId = rs.getInt("restaurant_id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                String phoneNumber = rs.getString("phone_number");
                int lowestPrice = rs.getInt("lowest_price");
                int highestPrice = rs.getInt("highest_price");
                LocalTime openTime = rs.getTime("open_time").toLocalTime();
                LocalTime closeTime = rs.getTime("close_time").toLocalTime();
                int status = rs.getInt("status");
                int accountIdInt = rs.getInt("account_id");
                String reason_deny = rs.getString("reason_deny");

                Restaurant r = new Restaurant(
                        restaurantId,
                        name,
                        address,
                        phoneNumber,
                        lowestPrice,
                        highestPrice,
                        openTime,
                        closeTime,
                        status,
                        accountIdInt,
                        reason_deny
                );

                if (getAvatarPathForRestaurant(context, rs.getInt("restaurant_id")) != null) {
                    r.setAvatarPath(getAvatarPathForRestaurant(context, rs.getInt("restaurant_id")));
                }

                r.setProofPaths(getProofMediaPathsForRestaurant(context, restaurantId));

                return r;
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return null;

    }

    public List<Restaurant> getAllRestaurant(ServletContext context) {

        List<Restaurant> restaurants = new ArrayList<>();

        String sql = "SELECT * FROM restaurant";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int restaurantId = rs.getInt("restaurant_id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                String phoneNumber = rs.getString("phone_number");
                int lowestPrice = rs.getInt("lowest_price");
                int highestPrice = rs.getInt("highest_price");
                LocalTime openTime = rs.getTime("open_time").toLocalTime();
                LocalTime closeTime = rs.getTime("close_time").toLocalTime();
                int status = rs.getInt("status");
                int accountIdInt = rs.getInt("account_id");
                String reason_deny = rs.getString("reason_deny");

                Restaurant r = new Restaurant(
                        restaurantId,
                        name,
                        address,
                        phoneNumber,
                        lowestPrice,
                        highestPrice,
                        openTime,
                        closeTime,
                        status,
                        accountIdInt,
                        reason_deny
                );

                if (getAvatarPathForRestaurant(context, rs.getInt("restaurant_id")) != null) {
                    r.setAvatarPath(getAvatarPathForRestaurant(context, rs.getInt("restaurant_id")));
                }

                r.setProofPaths(getProofMediaPathsForRestaurant(context, restaurantId));

                restaurants.add(r);
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        Collections.reverse(restaurants);

        return restaurants;
    }

    public List<Restaurant> getRestaurantsByAccountId(String accountId, ServletContext context) {

        List<Restaurant> restaurants = new ArrayList<>();

        String sql = "SELECT * FROM restaurant\n"
                + "WHERE account_id = ?;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int restaurantId = rs.getInt("restaurant_id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                String phoneNumber = rs.getString("phone_number");
                int lowestPrice = rs.getInt("lowest_price");
                int highestPrice = rs.getInt("highest_price");
                LocalTime openTime = rs.getTime("open_time").toLocalTime();
                LocalTime closeTime = rs.getTime("close_time").toLocalTime();
                int status = rs.getInt("status");
                int accountIdInt = rs.getInt("account_id");
                String reason_deny = rs.getString("reason_deny");

                Restaurant r = new Restaurant(
                        restaurantId,
                        name,
                        address,
                        phoneNumber,
                        lowestPrice,
                        highestPrice,
                        openTime,
                        closeTime,
                        status,
                        accountIdInt,
                        reason_deny
                );

                if (getAvatarPathForRestaurant(context, rs.getInt("restaurant_id")) != null) {
                    r.setAvatarPath(getAvatarPathForRestaurant(context, rs.getInt("restaurant_id")));
                }

                r.setProofPaths(getProofMediaPathsForRestaurant(context, restaurantId));

                restaurants.add(r);
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        Collections.reverse(restaurants);

        return restaurants;
    }

    private String getAvatarPathForRestaurant(ServletContext context, int restaurantId) {
        String avatarPath = null;

        try {

            String sql = "SELECT avatar FROM Restaurant WHERE restaurant_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, restaurantId);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {

                    byte[] mediaData = rs.getBytes("avatar");

                    avatarPath = saveImageToFile(context, restaurantId, mediaData);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return avatarPath;
    }

    private static String saveImageToFile(ServletContext context, int restaurantId, byte[] image) {
        if (image == null || image.length == 0) {
            return null;
        }

        String directoryPath = context.getRealPath("/images/");
        String imagePath = directoryPath + "restaurant_" + restaurantId + ".jpg";

        try {
            // Ensure the directory exists
            Files.createDirectories(Paths.get(directoryPath));
            // Write the image to the specified file
            try (FileOutputStream fos = new FileOutputStream(imagePath)) {
                fos.write(image);
            }
        } catch (IOException e) {
            System.err.println("Error saving image to file: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

        // Return the relative path to the image for the HTML file
        return "images/" + Paths.get(imagePath).getFileName().toString();

    }

    public int getRestaurantId() { //get largest restaurantId
        String sql = "SELECT MAX(restaurant_id) AS max_restaurant_id FROM restaurant";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet resultSet = st.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt("max_restaurant_id");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    private List<String> getProofMediaPathsForRestaurant(ServletContext context, int restaurantId) {
        List<String> mediaPaths = new ArrayList<>();

        try {

            String sql = "SELECT media_id, media_data FROM restaurant_proof_media WHERE restaurant_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, restaurantId);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int mediaId = rs.getInt("media_id");
                    byte[] mediaData = rs.getBytes("media_data");
                    mediaPaths.add(saveProofImageToFile(context, restaurantId, mediaId, mediaData));
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return mediaPaths;
    }

    private static String saveProofImageToFile(ServletContext context, int restaurantId, int mediaId, byte[] image) {
        String directoryPath = context.getRealPath("/images/");
        String imagePath = directoryPath + "restaurant_" + restaurantId + "_proof_media_" + mediaId + ".jpg";

        try {
            Files.createDirectories(Paths.get(directoryPath));
            try (FileOutputStream fos = new FileOutputStream(imagePath)) {
                fos.write(image);
            }
        } catch (IOException e) {
            System.out.println(e);
        }

        // Return the relative path to the image for the HTML file
        return "images/" + Paths.get(imagePath).getFileName().toString();
    }

    public void DeleteRestaurant(String restaurantId) {

        String sql = "UPDATE restaurant\n"
                + "SET status = 0\n"
                + "WHERE restaurant_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, restaurantId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public void ShowRestaurant(String restaurantId) {

        String sql = "UPDATE restaurant\n"
                + "SET status = 1\n"
                + "WHERE restaurant_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, restaurantId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public int getTotalRetaurants() {
        int count = 0;
        String sql = "SELECT [restaurant_id]\n"
                + "      ,[name]\n"
                + "      ,[address]\n"
                + "      ,[phone_number]\n"
                + "      ,[lowest_price]\n"
                + "      ,[highest_price]\n"
                + "      ,[open_time]\n"
                + "      ,[close_time]\n"
                + "      ,[avatar]\n"
                + "      ,[status]\n"
                + "      ,[account_id]\n"
                + "  FROM [dbo].[restaurant]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                count++;

            }
            return count;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return count;

    }

    public void hideRestaurantForEditting(String restaurantId) {

        String sql = "UPDATE restaurant\n"
                + "SET status = 5\n"
                + "WHERE restaurant_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, restaurantId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public List<Restaurant> getEditRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * from restaurant where status = 4";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                int restaurantId = rs.getInt("restaurant_id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                String phoneNumber = rs.getString("phone_number");
                int lowestPrice = rs.getInt("lowest_price");
                int highestPrice = rs.getInt("highest_price");
                LocalTime openTime = rs.getTime("open_time").toLocalTime();
                LocalTime closeTime = rs.getTime("close_time").toLocalTime();
                int status = rs.getInt("status");
                int accountIdInt = rs.getInt("account_id");
                String reason_deny = rs.getString("reason_deny");

                Restaurant r = new Restaurant(
                        restaurantId,
                        name,
                        address,
                        phoneNumber,
                        lowestPrice,
                        highestPrice,
                        openTime,
                        closeTime,
                        status,
                        accountIdInt,
                        reason_deny
                );

                r.setEditOf(rs.getInt("edit_of"));

                restaurants.add(r);
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        Collections.reverse(restaurants);

        return restaurants;
    }

    public void acceptEditRestaurant(String edittedRestaurantId, String editOfRestaurantId) {
        String sql = "UPDATE g\n"
                + "SET \n"
                + "    g.name = e.name,\n"
                + "    g.address = e.address,\n"
                + "    g.phone_number = e.phone_number,\n"
                + "    g.lowest_price = e.lowest_price,\n"
                + "    g.highest_price = e.highest_price,\n"
                + "    g.open_time = e.open_time,\n"
                + "    g.close_time = e.close_time,\n"
                + "    g.avatar = e.avatar,\n"
                + "    g.account_id = e.account_id\n"
                + "FROM restaurant g\n"
                + "INNER JOIN restaurant e ON g.restaurant_id = e.edit_of\n"
                + "WHERE e.restaurant_id = " + edittedRestaurantId + " AND e.edit_of = " + editOfRestaurantId + ";\n"
                + "DELETE FROM restaurant_proof_media\n"
                + "WHERE restaurant_id = " + editOfRestaurantId + ";\n"
                + "UPDATE restaurant_proof_media\n"
                + "SET restaurant_id = " + editOfRestaurantId + "\n"
                + "WHERE restaurant_id = " + edittedRestaurantId + ";\n"
                + "UPDATE restaurant\n"
                + "SET status = 0\n"
                + "WHERE restaurant_id = " + edittedRestaurantId + ";"
                + "\n";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public int getTotalRestaurantRequests() {
        int count = 0;
        String sql = "SELECT [restaurant_id]\n"
                + "      ,[name]\n"
                + "      ,[address]\n"
                + "      ,[phone_number]\n"
                + "      ,[lowest_price]\n"
                + "      ,[highest_price]\n"
                + "      ,[open_time]\n"
                + "      ,[close_time]\n"
                + "      ,[avatar]\n"
                + "      ,[status]\n"
                + "      ,[account_id]\n"
                + "      ,[edit_of]\n"
                + "  FROM [dbo].[restaurant]\n"
                + "  Where [status] = 2 ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                count++;
            }
            return count;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return count;
    }
    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = new DBContext().connection;

    public List<Restaurant> getRestaurantRequestList() {
        List<Restaurant> list = new Vector<Restaurant>();
        String sql = "SELECT [restaurant_id]\n"
                + "      ,[name]\n"
                + "      ,[address]\n"
                + "      ,[phone_number]\n"
                + "      ,[lowest_price]\n"
                + "      ,[highest_price]\n"
                + "      ,[open_time]\n"
                + "      ,[close_time]\n"
                + "      ,[avatar]\n"
                + "      ,[status]\n"
                + "      ,[account_id]\n"
                + "      ,[edit_of]\n"
                + "      ,[reason_deny]\n"
                + "  FROM [dbo].[restaurant]\n"
                + "  where [status] = 2";
        try {

            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Restaurant(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getInt(5), rs.getInt(6), rs.getTime(7).toLocalTime(),
                        rs.getTime(8).toLocalTime(), rs.getInt(10), rs.getInt(11), rs.getString(12)));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;

    }

    public void acceptRestaurantResquest(int id) {
        String sql = "UPDATE [dbo].[restaurant]\n"
                + "   SET [status] = 1"
                + " WHERE [restaurant_id] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public void denyRestaurantResquest(int id, String msg) {
        String sql = "UPDATE [dbo].[restaurant]\n"
                + "   SET [status] = 3      \n"
                + "      ,[reason_deny] = ?\n"
                + " WHERE [restaurant_id] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, msg);
            st.setInt(2, id);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public int getTotalEditRestaurantRequest() {
        int count = 0;
        String sql = "SELECT [restaurant_id]\n"
                + "      ,[name]\n"
                + "      ,[address]\n"
                + "      ,[phone_number]\n"
                + "      ,[lowest_price]\n"
                + "      ,[highest_price]\n"
                + "      ,[open_time]\n"
                + "      ,[close_time]\n"
                + "      ,[avatar]\n"
                + "      ,[status]\n"
                + "      ,[account_id]\n"
                + "      ,[edit_of]\n"
                + "  FROM [dbo].[restaurant]\n"
                + "  Where [status] = 4 ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                count++;
            }
            return count;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return count;

    }

    public List<Restaurant> getRestaurantList() {
        List<Restaurant> list = new Vector<Restaurant>();
        String sql = "SELECT [restaurant_id]\n"
                + "      ,[name]\n"
                + "      ,[address]\n"
                + "      ,[phone_number]\n"
                + "      ,[lowest_price]\n"
                + "      ,[highest_price]\n"
                + "      ,[open_time]\n"
                + "      ,[close_time]\n"
                + "      ,[avatar]\n"
                + "      ,[status]\n"
                + "      ,[account_id]\n"
                + "      ,[edit_of]\n"
                + "      ,[reason_deny]\n"
                + "  FROM [dbo].[restaurant]\n";
               

        try {

            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Restaurant(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getInt(5), rs.getInt(6), rs.getTime(7).toLocalTime(),
                        rs.getTime(8).toLocalTime(), rs.getInt(10), rs.getInt(11), rs.getString(12)));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;

    }

    public void changeRestaurantStatus(int resId, int status) {
        String sql = "UPDATE [dbo].[restaurant]\n"
                + "   SET  [status] = ?\n"
                + " WHERE  [restaurant_id] =?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if(status==1)
            st.setInt(1, 3);
            else st.setInt(1, 1);
            st.setInt(2, resId);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

}
