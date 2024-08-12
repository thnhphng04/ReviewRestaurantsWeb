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
public class RestaurantReport {
    private int restaurantReportId,restaurantId,accountId,typeOfReport;
    private String reason;
    private LocalDateTime date;
    private int status;

    public RestaurantReport() {
    }

    public RestaurantReport(int restaurantReportId, int restaurantId, int accountId, int typeOfReport, String reason, LocalDateTime date, int status) {
        this.restaurantReportId = restaurantReportId;
        this.restaurantId = restaurantId;
        this.accountId = accountId;
        this.typeOfReport = typeOfReport;
        this.reason = reason;
        this.date = date;
        this.status = status;
    }

    public int getRestaurantReportId() {
        return restaurantReportId;
    }

    public void setRestaurantReportId(int restaurantReportId) {
        this.restaurantReportId = restaurantReportId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
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
