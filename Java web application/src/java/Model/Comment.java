/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Lenono
 */
public class Comment {

    /*INSERT INTO [dbo].[comment]
           ([comment_id]
           ,[post_id]
           ,[account_id]
           ,[text]
           ,[status])
     VALUES
           (<comment_id, int,>
           ,<post_id, int,>
           ,<account_id, int,>
           ,<text, nvarchar(max),>
           ,<status, int,>)
GO*/

    private int commentId;
    private int postId;
    private int accountId;
    private String text;
    private LocalDateTime date;
    private int status;
    private List<Reply> replies;
    private List<Integer> reactAccounts;

    public Comment() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Integer> getReactAccounts() {
        return reactAccounts;
    }

    public void setReactAccounts(List<Integer> reactAccounts) {
        this.reactAccounts = reactAccounts;
    }

    

    

    public Comment(int commentId, int postId, int accountId, String text, LocalDateTime date, int status, List<Reply> replies) {
        this.commentId = commentId;
        this.postId = postId;
        this.accountId = accountId;
        this.text = text;
        this.date = date;
        this.status = status;
        this.replies = replies;
    }

    

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<Reply> getReplies() {
        return replies;
    }

    public void setReplies(List<Reply> replies) {
        this.replies = replies;
    }


    public String getFormattedDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        return date.format(formatter);
    }
    
    
    
}
