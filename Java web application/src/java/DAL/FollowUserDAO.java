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
public class FollowUserDAO {
    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = new DBContext().connection;
    
    public boolean insertFollow(int account_id, int follower_id) {
        
        String sql = "INSERT INTO [dbo].[account_follower]\n"
                + "     VALUES (?,?)";
        boolean inserted = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, account_id);
            ps.setInt(2, follower_id);
            ps.executeUpdate();
            inserted = true;
        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return inserted;
    }
    public int countPost(int account_id) {
        String sql = "select count(*) from [dbo].[post] where account_id = ? and status = 1";
        int count = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, account_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
    
    public int countFollowing(int follower_id) {
        String sql = "select count(*) from [dbo].[account_follower] where follower_id = ?";
        int count = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, follower_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
    
    public int countFollower(int account_id) {
        String sql = "select count(*) from [dbo].[account_follower] where account_id = ?";
        int count = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, account_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
    
    public boolean isFollow(int account_id, int follower_id) {
        String sql = "SELECT * FROM [dbo].[account_follower] WHERE account_id = ? AND follower_id = ?";
        boolean isFollow = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, account_id);
            ps.setInt(2, follower_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isFollow = true;
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);

        }
        return isFollow;
    }

    public boolean deleteFollow(int account_id, int follower_id) {
        String sql = "DELETE FROM [dbo].[account_follower] WHERE account_id = ? AND follower_id = ?";
        boolean isDeleted = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, account_id);
            ps.setInt(2, follower_id);
            int rowsAffected = ps.executeUpdate();

            // If one or more rows were affected, the delete was successful
            isDeleted = rowsAffected > 0;
        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);

        }
        return isDeleted;
    }
    public static void main(String[] args) {
        FollowUserDAO fud = new FollowUserDAO();
        System.out.println(fud.countFollower(1));
    }
}
