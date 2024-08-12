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
public class ReactDAO {

    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = new DBContext().connection;

    public boolean insertLike(int post_id, int account_id) {
        
        String sql = "INSERT INTO [dbo].[react]\n"
                + "     VALUES (?,?)";
        boolean inserted = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, post_id);
            ps.setInt(2, account_id);
            ps.executeUpdate();
            inserted = true;
        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return inserted;
    }

    public int countLikeOnPost(int post_id) {
        String sql = "select count(*) from react where post_id = ?";
        int count = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, post_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public boolean isLikeByUser(int post_id, int account_id) {
        String sql = "SELECT * FROM react WHERE post_id = ? AND account_id = ?";
        boolean isLiked = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, post_id);
            ps.setInt(2, account_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isLiked = true;
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);

        }
        return isLiked;
    }

    public boolean deleteLike(int post_id, int account_id) {
        String sql = "DELETE FROM react WHERE post_id = ? AND account_id = ?";
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
//    public static void main(String[] args) {
//        ReactDAO r = new ReactDAO();
//        r.deleteLike(1, 1);
//    }
}
