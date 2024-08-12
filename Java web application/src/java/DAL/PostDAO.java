/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Comment;
import Model.Post;
import jakarta.servlet.ServletContext;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import static java.nio.file.Files.list;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author DELL
 */
public class PostDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = new DBContext().connection;

    public void insertPort(String accountId, String title, String text, String rating, String restaurantId, String serviceRating, String priceRating, String spaceRating, String tasteRating, String hygieneRating) {
        //sql
        String sql = "INSERT INTO POST (post_id, account_id, restaurant_id, title, date, text, rating, status, service_rate, price_rate, space_rate, taste_rate, hygiene_rate)\n"
                + "VALUES (\n"
                + "    (SELECT ISNULL(MAX(post_id) + 1, 1) FROM post WHERE post_id > 0),\n"
                + "    ?," //1-accountId
                + "    ?,"
                + "    ?,"
                + "    CURRENT_TIMESTAMP,"
                + "    ?,"
                + "    ?,"
                + "    2,"
                + "    ?,"
                + "    ?,"
                + "    ?,"
                + "    ?,"
                + "    ?"
                + ");";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, accountId);
            st.setString(2, restaurantId);
            st.setString(3, title);
            st.setString(4, text);
            st.setString(5, rating);

            st.setString(6, serviceRating);
            st.setString(7, priceRating);
            st.setString(8, spaceRating);
            st.setString(9, tasteRating);
            st.setString(10, hygieneRating);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public void insertEditPort(String accountId, String title, String text, String rating, String restaurantId, String serviceRating, String priceRating, String spaceRating, String tasteRating, String hygieneRating, String editOf) {
        //sql
        String sql = "INSERT INTO POST (post_id, account_id, restaurant_id, title, date, text, rating, status, service_rate, price_rate, space_rate, taste_rate, hygiene_rate, edit_of)\n"
                + "VALUES (\n"
                + "    (SELECT ISNULL(MAX(post_id) + 1, 1) FROM post WHERE post_id > 0),\n"
                + "    ?," //1-accountId
                + "    ?,"
                + "    ?,"
                + "    CURRENT_TIMESTAMP,"
                + "    ?,"
                + "    ?,"
                + "    4,"
                + "    ?,"
                + "    ?,"
                + "    ?,"
                + "    ?,"
                + "    ?,"
                + "    ?"
                + ");";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, accountId);
            st.setString(2, restaurantId);
            st.setString(3, title);
            st.setString(4, text);
            st.setString(5, rating);

            st.setString(6, serviceRating);
            st.setString(7, priceRating);
            st.setString(8, spaceRating);
            st.setString(9, tasteRating);
            st.setString(10, hygieneRating);

            st.setString(11, editOf);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public int getPostId() { //get largest postID
        String sql = "SELECT MAX(post_id) AS max_post_id FROM post";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet resultSet = st.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt("max_post_id");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public void insertMealType(String mealType, String postId) {
        String sql = "INSERT INTO type_of_meal (type_of_meal_id, post_id) VALUES("
                + "?,"
                + "?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, mealType);
            st.setString(2, postId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void insertFoodType(String foodType, String postId) {
        String sql = "INSERT INTO type_of_food (type_of_food_id, post_id) VALUES("
                + "?,"
                + "?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, foodType);
            st.setString(2, postId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public Post getPostById(String postId, ServletContext context) {
        try {

            String sql = "SELECT post_id, account_id, restaurant_id, title, date, text, rating, status, service_rate, price_rate, space_rate, taste_rate, hygiene_rate, reason_deny FROM post where post_id = " + postId;

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(Integer.parseInt(postId), accountId, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, Integer.parseInt(postId)));
                post.setProofPaths(getProofMediaPathsForPost(context, Integer.parseInt(postId)));
                post.setMealList(GetTypeOfMealByPostID(postId));
                post.setFoodList(GetTypeOfFoodByPostID(postId));

                return post;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }

    public List<Post> getAllPosts(ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT post.post_id, post.account_id, post.restaurant_id, post.title, post.date, post.text, post.rating, post.status, service_rate, price_rate, space_rate, taste_rate, hygiene_rate, reason_deny FROM post";

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        Collections.reverse(posts);

        return posts;
    }

    public List<Post> getSavedPosts(String mainAccountId, ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT p.* FROM post p JOIN post_saved ps ON p.post_id = ps.post_id WHERE ps.account_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, mainAccountId);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        Collections.reverse(posts);

        return posts;
    }

    private List<String> getMediaPathsForPost(ServletContext context, int postId) {
        List<String> mediaPaths = new ArrayList<>();

        try {

            String sql = "SELECT media_id, media_data FROM media WHERE post_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, postId);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int mediaId = rs.getInt("media_id");
                    byte[] mediaData = rs.getBytes("media_data");
                    mediaPaths.add(saveImageToFile(context, postId, mediaId, mediaData));
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return mediaPaths;
    }

    private static String saveImageToFile(ServletContext context, int postId, int mediaId, byte[] image) {
        String directoryPath = context.getRealPath("/images/");
        String imagePath = directoryPath + "post_" + postId + "_media_" + mediaId + ".jpg";

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

    public List<Post> searchPostsByTitle(String txtSearch, ServletContext context) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM post WHERE title LIKE ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + txtSearch + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return posts;
    }

    public List<Post> searchPostsByText(String txtSearch, ServletContext context) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM post WHERE text LIKE ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + txtSearch + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return posts;
    }

    public List<Post> searchPosts(String txtSearch, String searchColumn, ServletContext context) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM post WHERE " + searchColumn + " LIKE ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + txtSearch + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return posts;
    }

    public List<Post> searchPostsByTitleAndText(String txtSearch, ServletContext context) {
        Map<Integer, Post> postMap = new LinkedHashMap<>();

        List<Post> postsByTitle = searchPosts(txtSearch, "title", context);
        for (Post post : postsByTitle) {
            postMap.put(post.getPostId(), post);
        }

        List<Post> postsByText = searchPosts(txtSearch, "text", context);
        for (Post post : postsByText) {
            postMap.put(post.getPostId(), post);
        }

        return new ArrayList<>(postMap.values());
    }

    public List<Post> getPostsByAccountId(String accountId, ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT post.post_id, post.account_id, post.restaurant_id, post.title, post.date, post.text, post.rating, post.status, service_rate, price_rate, space_rate, taste_rate, hygiene_rate, reason_deny FROM post where account_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, accountId);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, Integer.parseInt(accountId), restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));
                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        Collections.reverse(posts);

        return posts;
    }

    public List<Post> getPostsByRestaurantId(String restaurantId, ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT post.post_id, post.account_id, post.restaurant_id, post.title, post.date, post.text, post.rating, post.status, service_rate, price_rate, space_rate, taste_rate, hygiene_rate, reason_deny FROM post where restaurant_id = ? and post.status=1";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, restaurantId);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId, Integer.parseInt(restaurantId), title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        Collections.reverse(posts);

        return posts;
    }

    private List<String> getProofMediaPathsForPost(ServletContext context, int postId) {
        List<String> mediaPaths = new ArrayList<>();

        try {

            String sql = "SELECT media_id, media_data FROM post_proof_media WHERE post_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, postId);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int mediaId = rs.getInt("media_id");
                    byte[] mediaData = rs.getBytes("media_data");
                    mediaPaths.add(saveProofImageToFile(context, postId, mediaId, mediaData));
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return mediaPaths;
    }

    private static String saveProofImageToFile(ServletContext context, int postId, int mediaId, byte[] image) {
        String directoryPath = context.getRealPath("/images/");
        String imagePath = directoryPath + "post_" + postId + "_proof_media_" + mediaId + ".jpg";

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

    //test connection
    public static void main(String[] args) {
        PostDAO pd = new PostDAO();

        pd.acceptEditPost("7", "6");

    }

    public List<Post> getPostsByTypeOfMeal(ServletContext context, String typeOfMeal) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT p.*\n"
                    + "FROM post p\n"
                    + "JOIN type_of_meal tm ON p.post_id = tm.post_id\n"
                    + "WHERE tm.type_of_meal_id = ?;";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(typeOfMeal));

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        Collections.reverse(posts);

        return posts;
    }

    public List<Post> getPostsByTypeOfFood(ServletContext context, String typeOfFood) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT p.*\n"
                    + "FROM post p\n"
                    + "JOIN type_of_food tf ON p.post_id = tf.post_id\n"
                    + "WHERE tf.type_of_food_id = ?;";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(typeOfFood));

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        Collections.reverse(posts);

        return posts;
    }

    public void DeletePost(String postId) {

        String sql = "UPDATE post\n"
                + "SET status = 0\n"
                + "WHERE post_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, postId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public void ShowPost(String postId) {

        String sql = "UPDATE post\n"
                + "SET status = 1\n"
                + "WHERE post_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, postId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public List<Integer> GetTypeOfMealByPostID(String postId) {

        List<Integer> meals = new ArrayList<>();

        try {

            String sql = "select * from type_of_meal where post_id = " + postId;

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                meals.add(rs.getInt("type_of_meal_id"));

            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return meals;
    }

    public List<Integer> GetTypeOfFoodByPostID(String postId) {

        List<Integer> meals = new ArrayList<>();

        try {

            String sql = "select * from type_of_food where post_id = " + postId;

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                meals.add(rs.getInt("type_of_food_id"));

            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return meals;
    }

    public int getTotalPostRequest() {
        int count = 0;
        String sql = "SELECT TOP (1000) [post_id]\n"
                + "      ,[account_id]\n"
                + "      ,[restaurant_id]\n"
                + "      ,[title]\n"
                + "      ,[date]\n"
                + "      ,[text]\n"
                + "      ,[rating]\n"
                + "      ,[status]\n"
                + "      ,[service_rate]\n"
                + "      ,[price_rate]\n"
                + "      ,[space_rate]\n"
                + "      ,[taste_rate]\n"
                + "      ,[hygiene_rate]\n"
                + "  FROM [SWP_Project].[dbo].[post]\n"
                + "  where [status]=2";

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

    public List<Post> getPostRequest() {
        List<Post> listPost = new ArrayList<>();
        String sql = "SELECT [post_id]\n"
                + "      ,[account_id]\n"
                + "      ,[restaurant_id]\n"
                + "      ,[title]\n"
                + "      ,[date]\n"
                + "      ,[text]\n"
                + "      ,[rating]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[post]"
                + "where status = 2 ";

        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                listPost.add(new Post(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5).toLocalDateTime(), rs.getString(6), rs.getFloat(7), rs.getInt(8)));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return listPost;
    }

    public List<Post> getEditPosts() {
        List<Post> listPost = new ArrayList<>();
        String sql = "SELECT [post_id]\n"
                + "      ,[account_id]\n"
                + "      ,[restaurant_id]\n"
                + "      ,[title]\n"
                + "      ,[date]\n"
                + "      ,[text]\n"
                + "      ,[rating]\n"
                + "      ,[status]\n"
                + "      ,[edit_of]\n"
                + "  FROM [dbo].[post]"
                + "where status = 4 ";

        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

                Post post = new Post(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5).toLocalDateTime(), rs.getString(6), rs.getFloat(7), rs.getInt(8));

                post.setEditOf(rs.getInt("edit_of"));

                listPost.add(post);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return listPost;
    }

    public void acceptPostRequest(int id) {
        String sql = "UPDATE [dbo].[post]\n"
                + "   SET [status] = 1\n"
                + " WHERE [post_id] = ?";

        try {

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public void denyPost(int id, String msg) {
        String sql = "UPDATE [dbo].[post]\n"
                + "   SET [status] = 3\n"
                + "      ,[reason_deny] = ?\n"
                + " WHERE [post_id] = ?";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, msg);
            st.setInt(2, id);
            st.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public void hidePostForEditting(String postId) {

        String sql = "UPDATE post\n"
                + "SET status = 5\n"
                + "WHERE post_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, postId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public void acceptEditPost(String edittedPostId, String editOfPostId) {
        String sql = "UPDATE g\n"
                + "SET \n"
                + "    g.title = e.title,\n"
                + "    g.text = e.text,\n"
                + "    g.rating = e.rating,\n"
                + "    g.status = 1,\n"
                + "    g.service_rate = e.service_rate,\n"
                + "    g.price_rate = e.price_rate,\n"
                + "    g.space_rate = e.space_rate,\n"
                + "    g.taste_rate = e.taste_rate,\n"
                + "    g.hygiene_rate = e.hygiene_rate,\n"
                + "    g.reason_deny = e.reason_deny\n"
                + "FROM post g\n"
                + "JOIN post e ON g.post_id = e.edit_of\n"
                + "WHERE e.post_id = " + edittedPostId + " AND e.edit_of = " + editOfPostId + ";\n"
                + "\n"
                + "DELETE FROM media\n"
                + "WHERE post_id = " + editOfPostId + ";\n"
                + "UPDATE media\n"
                + "SET post_id = " + editOfPostId + "\n"
                + "WHERE post_id = " + edittedPostId + ";\n"
                + "\n"
                + "DELETE FROM post_proof_media\n"
                + "WHERE post_id = " + editOfPostId + ";\n"
                + "UPDATE post_proof_media\n"
                + "SET post_id = " + editOfPostId + "\n"
                + "WHERE post_id = " + edittedPostId + ";\n"
                + "\n"
                + "\n"
                + "DELETE FROM type_of_meal\n"
                + "WHERE post_id = " + editOfPostId + ";\n"
                + "UPDATE type_of_meal\n"
                + "SET post_id = " + editOfPostId + "\n"
                + "WHERE post_id = " + edittedPostId + ";\n"
                + "\n"
                + "DELETE FROM type_of_food\n"
                + "WHERE post_id = " + editOfPostId + ";\n"
                + "UPDATE type_of_food\n"
                + "SET post_id = " + editOfPostId + "\n"
                + "WHERE post_id = " + edittedPostId + ";\n"
                + "UPDATE post\n"
                + "SET status = 0\n"
                + "WHERE post_id = " + edittedPostId + ";";

        try {

            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public int getTotalEditPostRequest() {
        int count = 0;
        String sql = "SELECT [post_id]\n"
                + "      ,[account_id]\n"
                + "      ,[restaurant_id]\n"
                + "      ,[title]\n"
                + "      ,[date]\n"
                + "      ,[text]\n"
                + "      ,[rating]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[post]"
                + "where status = 4 ";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count++;
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return count;
    }

    public List<Post> getAllFeedPosts(int accountId, ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT p.*\n"
                    + "FROM post p\n"
                    + "WHERE (p.account_id = " + accountId + "\n"
                    + "   OR p.account_id IN (\n"
                    + "       SELECT af.account_id\n"
                    + "       FROM account_follower af\n"
                    + "       WHERE af.follower_id = " + accountId + "\n"
                    + "   )) and p.status = 1\n"
                    + "ORDER BY p.date desc;";

            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId2 = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId2, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));
                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return posts;
    }

    public List<Post> getFeedPosts(int accountId, ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT top 10 p.*\n"
                    + "FROM post p\n"
                    + "WHERE (p.account_id = " + accountId + "\n"
                    + "   OR p.account_id IN (\n"
                    + "       SELECT af.account_id\n"
                    + "       FROM account_follower af\n"
                    + "       WHERE af.follower_id = " + accountId + "\n"
                    + "   )) and p.status = 1\n"
                    + "ORDER BY p.date desc;";

            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId2 = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId2, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));
                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return posts;
    }

    public List<Post> getNextFeedPosts(int accountId, int amount, ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT p.*\n"
                    + "FROM post p\n"
                    + "WHERE (p.account_id = ?\n"
                    + "OR p.account_id IN (\n"
                    + "SELECT af.account_id\n"
                    + "FROM account_follower af\n"
                    + "WHERE af.follower_id = ?\n"
                    + ")) and p.status = 1\n"
                    + "ORDER BY p.date desc\n"
                    + "OFFSET ? ROWS\n"
                    + "FETCH NEXT 10 ROWS ONLY";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            st.setInt(2, accountId);
            st.setInt(3, amount);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId2 = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId2, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));
                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return posts;
    }

    public List<Post> getAllExplorePosts(ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT * FROM post where status=1 order by date desc";

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return posts;
    }

    public List<Post> getTop9Posts(ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT TOP 9 * FROM post where status=1 order by date desc";

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return posts;
    }

    public List<Post> getNext9Posts(int amount, ServletContext context) {
        List<Post> posts = new ArrayList<>();

        try {

            String sql = "SELECT * FROM POST WHERE status=1 \n"
                    + "order by date desc \n"
                    + "OFFSET " + amount + " ROWS\n"
                    + "FETCH NEXT 9 ROWS ONLY";

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("post_id");
                int accountId = rs.getInt("account_id");
                int restaurantId = rs.getInt("restaurant_id");
                String title = rs.getString("title");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                String text = rs.getString("text");
                float rating = rs.getFloat("rating");
                int status = rs.getInt("status");

                float serviceRating = rs.getFloat("service_rate");
                float priceRating = rs.getFloat("price_rate");
                float spaceRating = rs.getFloat("space_rate");
                float tasteRating = rs.getFloat("taste_rate");
                float hygieneRating = rs.getFloat("hygiene_rate");

                String reasonDeny = rs.getString("reason_deny");

                Post post = new Post(postId, accountId, restaurantId, title, date, text, rating, status, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, reasonDeny);
                post.setImagePaths(getMediaPathsForPost(context, postId));
                post.setProofPaths(getProofMediaPathsForPost(context, postId));

                post.setMealList(GetTypeOfMealByPostID(String.valueOf(postId)));
                post.setFoodList(GetTypeOfFoodByPostID(String.valueOf(postId)));

                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return posts;
    }

}
