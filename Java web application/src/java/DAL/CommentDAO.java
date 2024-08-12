/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Comment;
import Model.Post;
import Model.Reply;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author cuanl
 */
public class CommentDAO extends DBContext {

    public void insertComment(String accountId, String postId, String text) {

        String sql = "INSERT INTO comment (comment_id, post_id, account_id, text, date, status)\n"
                + "VALUES ("
                + "(SELECT ISNULL(MAX(comment_id) + 1, 1) FROM comment WHERE comment_id > 0),"
                + "?," //post_id
                + "?," //account_id
                + "?," //text
                + "CURRENT_TIMESTAMP,"
                + "1)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, postId);
            st.setString(2, accountId);
            st.setString(3, text);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public List<Comment> getCommentsByPostID(String postId) {
        List<Comment> comments = new ArrayList<>();

        try {

            String sql = "SELECT comment.*\n"
                    + "FROM comment\n"
                    + "JOIN post ON comment.post_id = post.post_id\n"
                    + "WHERE post.post_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, postId);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int commentId = rs.getInt("comment_id");
                int accountId = rs.getInt("account_id");
                String text = rs.getString("text");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                int status = rs.getInt("status");

                List<Reply> replies = getRepliesByCommentID(commentId);

                Comment comment = new Comment(commentId, Integer.parseInt(postId), accountId, text, date, status, replies);
                comment.setReactAccounts(getReactAccounts(commentId));

                comments.add(comment);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        Collections.reverse(comments);

        return comments;
    }

    public Comment getNewestComment() {
        Comment comment = null;

        try {

            String sql = "SELECT TOP 1 *\n"
                    + "FROM comment\n"
                    + "ORDER BY date DESC;";

            PreparedStatement st = connection.prepareStatement(sql);

            

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int commentId = rs.getInt("comment_id");
                int accountId = rs.getInt("account_id");
                int postId = rs.getInt("post_id");
                String text = rs.getString("text");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                int status = rs.getInt("status");

                List<Reply> replies = getRepliesByCommentID(commentId);

                comment = new Comment(commentId, postId, accountId, text, date, status, replies);
                comment.setReactAccounts(getReactAccounts(commentId));

                return comment;

            }
        } catch (SQLException e) {
            System.out.println(e);
        }

       

        return null;
    }

    public List<Reply> getRepliesByCommentID(int commentId) {
        List<Reply> replies = new ArrayList<>();

        try {

            String sql = "SELECT reply.*\n"
                    + "FROM reply\n"
                    + "JOIN comment ON reply.comment_id = comment.comment_id\n"
                    + "WHERE comment.comment_id = ?";

            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, String.valueOf(commentId));

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int replyId = rs.getInt("reply_id");
                int accountId = rs.getInt("account_id");
                String text = rs.getString("text");
                LocalDateTime date = rs.getTimestamp("date").toLocalDateTime();
                int status = rs.getInt("status");

                Reply reply = new Reply(replyId, commentId, accountId, text, date, status);

                replies.add(reply);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return replies;
    }

    public List<Integer> getReactAccounts(int commentId) {
        List<Integer> reactAccounts = new ArrayList<>();

        String sql = "Select * from comment_react where comment_id =" + commentId;
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet resultSet = st.executeQuery()) {
            while (resultSet.next()) {
                int accountId = resultSet.getInt("account_id");
                reactAccounts.add(accountId);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return reactAccounts;
    }

    public void insertCommentReact(String commentId, String accountId) {
        String sql = "INSERT INTO comment_react (comment_id, account_id)\n"
                + "VALUES (?, ?);";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, commentId);
            st.setString(2, accountId);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public void deleteCommentReact(String commentId, String accountId) {
        String sql = "DELETE FROM comment_react\n"
                + "WHERE comment_id = ? AND account_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, commentId);
            st.setString(2, accountId);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public void hideComment(String commentId) {
        String sql = "UPDATE comment\n"
                + "SET status = 0\n"
                + "WHERE comment_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, commentId);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public static void main(String[] args) {
        CommentDAO cd = new CommentDAO();

       

        System.out.println(cd.getNewestComment().getCommentId());

    }

}
