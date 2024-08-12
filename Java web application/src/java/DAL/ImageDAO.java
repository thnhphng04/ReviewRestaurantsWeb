/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class ImageDAO extends DBContext{
    
    public void insertPostProofImage(String postId ,String restaurantId, String filePath) throws FileNotFoundException, IOException{
        
        //sql
        String sql = "INSERT INTO post_proof_media (media_id, post_id, restaurant_id, media_data) VALUES ("
                + "(SELECT ISNULL(MAX(media_id) + 1, 1) FROM post_proof_media WHERE media_id > 0),"
                + " ?, ?, ?)";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            
            st.setString(1, postId);
            st.setString(2, restaurantId);
            
            // Read the image file in binary mode
            FileInputStream inputStream = new FileInputStream(filePath);
            st.setBinaryStream(3, inputStream, (int) inputStream.available());

            
            st.executeUpdate();
            
            System.out.println("Success");
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        
    }
    
    public void insertImage(String postId ,String restaurantId, String filePath) throws FileNotFoundException, IOException{
        
        //sql
        String sql = "INSERT INTO media (media_id, post_id, restaurant_id, media_data) VALUES ("
                + "(SELECT ISNULL(MAX(media_id) + 1, 1) FROM media WHERE media_id > 0),"
                + " ?, ?, ?)";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            
            st.setString(1, postId);
            st.setString(2, restaurantId);
            
            // Read the image file in binary mode
            FileInputStream inputStream = new FileInputStream(filePath);
            st.setBinaryStream(3, inputStream, (int) inputStream.available());

            
            st.executeUpdate();
            
            System.out.println("Success");
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        
    }
    
    public void insertRestaurantProofImage(String restaurantId, String filePath) throws FileNotFoundException, IOException{
        
        //sql
        String sql = "INSERT INTO restaurant_proof_media (media_id, restaurant_id, media_data) VALUES ("
                + "(SELECT ISNULL(MAX(media_id) + 1, 1) FROM restaurant_proof_media WHERE media_id > 0),"
                + " ?, ?)";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            
            st.setString(1, restaurantId);
            
            // Read the image file in binary mode
            FileInputStream inputStream = new FileInputStream(filePath);
            st.setBinaryStream(2, inputStream, (int) inputStream.available());

            
            st.executeUpdate();
            
            System.out.println("Success");
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        
    }
    
    public static void main(String[] args) {
        ImageDAO imd = new ImageDAO();
        
        String filePath = "D:\\Ki 5\\SWP391\\Upload_file_web\\build\\web\\images\\wukong-black-myth-thumb.jpg";
        
        try {
            imd.insertPostProofImage("16", "1", filePath);
            System.out.println("success");
        } catch (IOException ex) {
            Logger.getLogger(ImageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }
    
}
