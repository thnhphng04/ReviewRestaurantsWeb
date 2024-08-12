/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Post;
import Model.PostReport;
import Model.RestaurantReport;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author DELL
 */
public class ReportDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection connection = new DBContext().connection;

    public void insertPostReport(String postId, String accountId, String reportType, String text) {
        String sql = "INSERT INTO post_report (post_report_id, post_id, account_id, type_of_report, text, date, status)\n"
                + "VALUES ("
                + "(SELECT ISNULL(MAX(post_report_id) + 1, 1) FROM post_report WHERE post_report_id > 0), "
                + "?, "
                + "?, "
                + "?, "
                + "?, "
                + "CURRENT_TIMESTAMP, "
                + "1);";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, postId);
            st.setString(2, accountId);
            st.setString(3, reportType);
            st.setString(4, text);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }

    }

    public String insertRestaurantReport(String restaurantId, String accountId, String reportType, String text) {
        String sql = "INSERT INTO restaurant_report (restaurant_report_id, restaurant_id, account_id, type_of_report, text, date, status)\n"
                + "VALUES ("
                + "(SELECT ISNULL(MAX(restaurant_report_id) + 1, 1) FROM restaurant_report WHERE restaurant_report_id > 0), "
                + "?, "
                + "?, "
                + "?, "
                + "?, "
                + "CURRENT_TIMESTAMP, "
                + "1);";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, restaurantId);
            st.setString(2, accountId);
            st.setString(3, reportType);
            st.setString(4, text);

            st.executeUpdate();
            return "success";

        } catch (SQLException e) {
            System.out.println(e);
            return "fail";

        }

    }

    public static void main(String[] args) {
        ReportDAO prd = new ReportDAO();

        prd.insertRestaurantReport("1", "1", "1", "abcxyz");

    }

    public int getTotalReportPost() {
        int count = 0;
        String sql = "SELECT [post_report_id]\n"
                + "      ,[post_id]\n"
                + "      ,[account_id]\n"
                + "      ,[type_of_report]\n"
                + "      ,[text]\n"
                + "      ,[date]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[post_report]"
                + " WHERE [status]=1";
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

    public int getTotalReportRestaurant() {
        int count = 0;
        String sql = "SELECT [restaurant_report_id]\n"
                + "      ,[restaurant_id]\n"
                + "      ,[account_id]\n"
                + "      ,[type_of_report]\n"
                + "      ,[text]\n"
                + "      ,[date]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[restaurant_report]"
                + " WHERE [status]=1";
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

    public List<PostReport> getPostReport() {
        List<PostReport> list = new Vector<PostReport>();
        String sql = "SELECT [post_report_id]\n"
                + "      ,[post_id]\n"
                + "      ,[account_id]\n"
                + "      ,[type_of_report]\n"
                + "      ,[text]\n"
                + "      ,[date]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[post_report]"
                + " WHERE [status]=1";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PostReport(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getString(5),
                        rs.getTimestamp(6).toLocalDateTime(), rs.getInt(7)));

            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<RestaurantReport> getRestaurantReport() {
        List<RestaurantReport> list = new Vector<RestaurantReport>();
        String sql = "SELECT [restaurant_report_id]\n"
                + "      ,[restaurant_id]\n"
                + "      ,[account_id]\n"
                + "      ,[type_of_report]\n"
                + "      ,[text]\n"
                + "      ,[date]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[restaurant_report]"
                + " WHERE [status]=1";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new RestaurantReport(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getString(5),
                        rs.getTimestamp(6).toLocalDateTime(), rs.getInt(7)));

            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void updateRestaurantReport(int restaurantReportId, int restaurantId, boolean aprove, String msg) {
        String sql = "UPDATE [dbo].[restaurant_report]\n"
                + "   SET [status] = 0\n"
                + " WHERE [restaurant_report_id]=?";
        String sql2 = "UPDATE [dbo].[restaurant]\n"
                + "   SET [status] = ?\n"
                + "      ,[reason_deny] = ?\n"
                + " WHERE [restaurant_id]=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, restaurantReportId);
            st.executeUpdate();

            if (aprove) {
                PreparedStatement ps = connection.prepareStatement(sql2);

                ps.setInt(1, 6);
                ps.setString(2, msg);
                ps.setInt(3, restaurantId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public void updatePostReport(int postReportId, int postId, boolean approve, String msg) {
        String sql = "UPDATE [dbo].[post_report]\n"
                + "   SET [status] = 0\n"
                + " WHERE [post_report_id] = ?";
        String sql2 = "UPDATE [dbo].[post]\n"
                + "   SET [status] = ?,\n"
                + "       [reason_deny] = ?\n"
                + " WHERE [post_id] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, postReportId);
            st.executeUpdate(); // Use executeUpdate for UPDATE queries

            if (approve) {
                PreparedStatement ps = connection.prepareStatement(sql2);
                ps.setInt(1, 6);
                ps.setString(2, msg);
                ps.setInt(3, postId);
                ps.executeUpdate(); // Use executeUpdate for UPDATE queries
            }
        } catch (Exception e) {
            System.out.println(e);
        }

    }

}
