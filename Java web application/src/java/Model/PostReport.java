/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Lenono
 */
public class PostReport {
    private int postReportId,postId,accountId,typeOfReport;
    private String reason;
    private LocalDateTime date;
    private int status;

    public PostReport() {
    }

    public PostReport(int postReportId, int postId, int accountId, int typeOfReport, String reason, LocalDateTime date, int status) {
        this.postReportId = postReportId;
        this.postId = postId;
        this.accountId = accountId;
        this.typeOfReport = typeOfReport;
        this.reason = reason;
        this.date = date;
        this.status = status;
    }

    public int getPostReportId() {
        return postReportId;
    }

    public void setPostReportId(int postReportId) {
        this.postReportId = postReportId;
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

    public int getTypeOfReport() {
        return typeOfReport;
    }

    public void setTypeOfReport(int typeOfReport) {
        this.typeOfReport = typeOfReport;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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
public String getFormattedDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        return date.format(formatter);
    }
    
    

    
    
    
    
    
}
