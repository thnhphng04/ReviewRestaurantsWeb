/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.AccountDetail;
import jakarta.servlet.ServletContext;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author truon
 */
public class AccountDao {

    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = new DBContext().connection;
    
    private List<AccountDetail> ListAcc;

    public AccountDao() {
    }

    public AccountDao(List<AccountDetail> ListAcc) {
        this.ListAcc = ListAcc;
    }

    public PreparedStatement getPs() {
        return ps;
    }

    public void setPs(PreparedStatement ps) {
        this.ps = ps;
    }

    public ResultSet getRs() {
        return rs;
    }

    public void setRs(ResultSet rs) {
        this.rs = rs;
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    public List<AccountDetail> getListAcc() {
        return ListAcc;
    }

    public void setListAcc(List<AccountDetail> ListAcc) {
        this.ListAcc = ListAcc;
    }

    public AccountDetail login(String email, String pass, ServletContext context) {
        String query = "select * from accountDetail\n"
                + "where [email] = ? \n"
                + "and [password] = ?";
        try {

            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, pass);
            rs = ps.executeQuery();

            while (rs.next()) {
                AccountDetail a = new AccountDetail(rs.getInt(1),
                        rs.getString(2),
                        rs.getBoolean(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(10));
                if (getAvatarPathForAccount(context, rs.getInt(1)) != null) {
                    a.setAvatarPath(getAvatarPathForAccount(context, rs.getInt(1)));
                }

                return a;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean editProfile(int account_id, boolean gender, String phone_number, Date dob, String name, String email) {
        String query = "UPDATE accountDetail SET gender = ?, phone_number = ?, dob = ?, name = ?, email = ? WHERE account_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setBoolean(1, gender);
            ps.setString(2, phone_number);
            ps.setDate(3, dob);
            ps.setString(4, name);
            ps.setString(5, email);
            ps.setInt(6, account_id);

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
        return false;
    }

    public static void main(String[] args) {
        AccountDao e = new AccountDao();
        e.editProfile(1, true, "12312123", Date.valueOf("2023-02-13"), "bhsjfhj11", "hgdfvhd11");

    }

    public boolean checkEmailExists(String email) {
        String query = "SELECT 1 FROM accountDetail WHERE email = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            return rs.next(); // Trả về true nếu email đã tồn tại
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
        return false;
    }

    public AccountDetail checkEmail(String email) {
        String sql = "SELECT [email]\n"
                + "  FROM [dbo].[accountDetail] where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AccountDetail acc = new AccountDetail();
                acc.setEmail(rs.getString("email"));
                return acc;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public String register(AccountDetail acc) {
        String mess = "Successful";
        String sql = "INSERT INTO [dbo].[accountDetail]\n"
                + "     VALUES (?,?,?,?,?,?,?,null,?,?)";

        try {

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, acc.getPassword());
            ps.setBoolean(2, acc.isGender());
            ps.setString(3, acc.getPhoneNumber());
            ps.setDate(4, acc.getDob());
            ps.setString(5, acc.getName());
            ps.setString(6, acc.getEmail());
            ps.setInt(7, acc.getRole());
            ps.setInt(8, acc.getStatus());
            ps.setInt(9, acc.getVerifyCode());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return mess;
    }

    public AccountDetail getAccountByEmail(String email) {
        String sql = "select * from [dbo].[accountDetail] where [email]=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new AccountDetail(rs.getInt("account_id"), rs.getString("password"), rs.getBoolean("gender"), rs.getString("phone_number"),
                        rs.getDate("dob"), rs.getString("name"), rs.getString("email"), rs.getInt("role"), rs.getInt("status"), rs.getInt("verifyCode"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public AccountDetail setStatus(String email) {
        String sql = "UPDATE [dbo].[accountDetail]\n"
                + "   SET [status] = 1\n"
                + " WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public int changePasswordByEmail(String newpass, String email) {
        String sql = "UPDATE [dbo].[accountDetail]\n"
                + "   SET [password] = ?\n"
                + " WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newpass);
            ps.setString(2, email);
            int checkUpdate = ps.executeUpdate();
            return checkUpdate;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public AccountDetail getAccountById(int accountId, ServletContext context) {
        String sql = "select * from [dbo].[accountDetail] where [account_id]=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                AccountDetail a = new AccountDetail(rs.getInt("account_id"), rs.getString("password"), rs.getBoolean("gender"), rs.getString("phone_number"),
                        rs.getDate("dob"), rs.getString("name"), rs.getString("email"), rs.getInt("role"), rs.getInt("status"));
                if (getAvatarPathForAccount(context, rs.getInt(1)) != null) {
                    a.setAvatarPath(getAvatarPathForAccount(context, rs.getInt(1)));
                }

                return a;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public void updateAvatar(String accountId, String filePath) {
        String sql = "UPDATE accountDetail SET avatar = ? WHERE account_id = ?";
        try (
                InputStream inputStream = new FileInputStream(filePath); 
                PreparedStatement st = connection.prepareStatement(sql)) {

            // Set the binary stream for the avatar
            st.setBinaryStream(1, inputStream);

            // Set the account_id
            st.setString(2, accountId);

            int rowsUpdated = st.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Avatar updated successfully for account ID: " + accountId);
            } else {
                System.out.println("No account found with ID: " + accountId);
            }
        } catch (FileNotFoundException e) {

            e.printStackTrace();
        } catch (SQLException e) {

            e.printStackTrace();
        } catch (IOException e) {

            e.printStackTrace();
        }
    }

    private String getAvatarPathForAccount(ServletContext context, int accountId) {
        String avatarPath = null;

        try {

            String sql = "SELECT avatar FROM accountDetail WHERE account_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, accountId);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {

                    byte[] mediaData = rs.getBytes("avatar");

                    avatarPath = saveImageToFile(context, accountId, mediaData);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return avatarPath;
    }

    private static String saveImageToFile(ServletContext context, int accountId, byte[] image) {
        if (image == null || image.length == 0) {
            return null;
        }

        String directoryPath = context.getRealPath("/images/");
        String imagePath = directoryPath + "account_" + accountId + ".jpg";

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
    
    public int getTotalAcc() {
        int count = 0;
        String sql = "SELECT [account_id]\n"
                + "      ,[password]\n"
                + "      ,[gender]\n"
                + "      ,[phone_number]\n"
                + "      ,[dob]\n"
                + "      ,[name]\n"
                + "      ,[email]\n"
                + "      ,[role]\n"
                + "      ,[avatar]\n"
                + "      ,[status]\n"
                + "      ,[verifyCode]\n"
                + "  FROM [dbo].[accountDetail]\n"
                + " Where [role]=1 ";

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
    
    public List<AccountDetail> getUser() {
        ListAcc = new Vector<AccountDetail>();
        String sql = "SELECT [account_id]\n"
                + "      ,[password]\n"
                + "      ,[gender]\n"
                + "      ,[phone_number]\n"
                + "      ,[dob]\n"
                + "      ,[name]\n"
                + "      ,[email]\n"
                + "      ,[role]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[accountDetail]"
                + "where role = 1";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ListAcc.add(new AccountDetail(rs.getInt(1), rs.getString(2), rs.getBoolean(3), rs.getString(4),
                        rs.getDate(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9),
                        numberOfPost(rs.getInt(1)), numberOfHiddenPost(rs.getInt(1))));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return ListAcc;
    }
    
    public int numberOfPost(int accountId) {
        int count = 0;
        String sql = "SELECT [post_id]\n"
                + "      ,[account_id]\n"
                + "      ,[restaurant_id]\n"
                + "      ,[title]\n"
                + "      ,[date]\n"
                + "      ,[text]\n"
                + "      ,[rating]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[post]\n"
                + "  where account_id=? and (status!=0 and status != 4)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                count++;

            }
            return count;
        } catch (Exception e) {
            System.out.println(e);
        }

        return count;
    }

    public int numberOfHiddenPost(int accountId) {
        int count = 0;
        String sql = "SELECT [post_id]\n"
                + "      ,[account_id]\n"
                + "      ,[restaurant_id]\n"
                + "      ,[title]\n"
                + "      ,[date]\n"
                + "      ,[text]\n"
                + "      ,[rating]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[post]\n"
                + "  where account_id=? and (status = 3 or status = 0)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                count++;

            }
            return count;
        } catch (Exception e) {
            System.out.println(e);
        }

        return count;
    }
    
    public void changeStatus(int id, int status) {
        String sql = "UPDATE [dbo].[accountDetail]\n"
                + "   SET [status] = ? \n"
                + " WHERE [account_id] =?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, status);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }
    
    public int countPost(int account_id) {
        String sql = "select * from [dbo].[post] where account_id = ? and status = 1";
        int count = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, account_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count ++;
            }

        } catch (Exception ex) {
            Logger.getLogger(AccountDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
    
    public List<AccountDetail> getFollowingAccount(int accountId, ServletContext context) {
        List<AccountDetail> ListAcc = new Vector<AccountDetail>();
        String sql = "SELECT ad.*\n"
                + "FROM accountDetail ad\n"
                + "JOIN account_follower af ON ad.account_id = af.account_id\n"
                + "WHERE af.follower_id =" + accountId + ";";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                AccountDetail a = new AccountDetail(rs.getInt("account_id"), rs.getString("password"), rs.getBoolean("gender"), rs.getString("phone_number"),
                        rs.getDate("dob"), rs.getString("name"), rs.getString("email"), rs.getInt("role"), rs.getInt("status"));
                if (getAvatarPathForAccount(context, rs.getInt(1)) != null) {
                    a.setAvatarPath(getAvatarPathForAccount(context, rs.getInt(1)));
                }
                
                a.setNumberOfPost(countPost(rs.getInt("account_id")));
                
                ListAcc.add(a);
                
            }
            

        } catch (Exception e) {
            System.out.println(e);
        }
        return ListAcc;
    }
    
    public List<AccountDetail> getFollowersAccount(int accountId, ServletContext context) {
        List<AccountDetail> ListAcc = new Vector<AccountDetail>();
        String sql = "SELECT ad.*\n"
                + "FROM accountDetail ad\n"
                + "JOIN account_follower af ON ad.account_id = af.follower_id\n"
                + "WHERE af.account_id =" + accountId + ";";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                AccountDetail a = new AccountDetail(rs.getInt("account_id"), rs.getString("password"), rs.getBoolean("gender"), rs.getString("phone_number"),
                        rs.getDate("dob"), rs.getString("name"), rs.getString("email"), rs.getInt("role"), rs.getInt("status"));
                if (getAvatarPathForAccount(context, rs.getInt(1)) != null) {
                    a.setAvatarPath(getAvatarPathForAccount(context, rs.getInt(1)));
                }
                
                a.setNumberOfPost(countPost(rs.getInt("account_id")));
                
                ListAcc.add(a);
                          
            }
            

        } catch (Exception e) {
            System.out.println(e);
        }
        return ListAcc;
    }
    
    public boolean checkCurrentPassword(int account_id, String encryptedCurrentPassword) {
        String sql = "SELECT * FROM [dbo].[accountDetail] WHERE account_id = ? AND password = ?";
        boolean isPassword = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, account_id);
            ps.setString(2, encryptedCurrentPassword);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isPassword = true;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return isPassword;
    }

    public void changePassword(String encryptedNewPassword, int account_id) {
        String sql = "UPDATE [dbo].[accountDetail] SET [password] = ? WHERE [account_id] = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, encryptedNewPassword);
            preparedStatement.setInt(2, account_id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}   
