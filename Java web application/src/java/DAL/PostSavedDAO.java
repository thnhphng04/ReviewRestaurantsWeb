/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
public class PostSavedDAO {
    
    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = new DBContext().connection;
    
    public boolean insertSave(int postId, int accountId) {
        
        String sql = "INSERT INTO [dbo].[post_saved]\n"
                + "     VALUES (?,?)";
        boolean inserted = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, postId);
            ps.setInt(2, accountId);
            ps.executeUpdate();
            inserted = true;
        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return inserted;
    }
    public boolean isSavedByUser(int post_id, int account_id) {
        String sql = "SELECT * FROM post_saved WHERE post_id = ? AND account_id = ?" ;
        boolean isSaved = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, post_id);
            ps.setInt(2, account_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isSaved = true;
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);

        }
        return isSaved;
    }

    public boolean deleteSaved(int post_id, int account_id) {
        String sql = "DELETE FROM post_saved WHERE post_id = ? AND account_id = ?";
        boolean isDeleted = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, post_id);
            ps.setInt(2, account_id);
            int rowsAffected = ps.executeUpdate();

            // If one or more rows were affected, the delete was successful
            isDeleted = rowsAffected > 0;
        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);

        }
        return isDeleted;
    }
    public static void main(String[] args) {
        PostSavedDAO psd = new PostSavedDAO();
        psd.deleteSaved(8, 1);
    }
}
