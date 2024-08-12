/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalTime;
import java.util.List;

/**
 *
 * @author DELL
 */
public class Restaurant {

    private int restaurantId;
    String name;
    private String address;
    private String phoneNumber;
    private int lowestPrice;
    private int highestPrice;
    private LocalTime openTime;
    private LocalTime closeTime;
    private String avatarPath;
    private int status;
    private int accountId;
    private List<String> proofPaths;
    private int editOf;
    private String reasonDeny;

    public Restaurant(int aInt, String string, String string0, String string1, int aInt0, int aInt1, LocalTime toLocalTime, LocalTime toLocalTime0, int aInt2, int aInt3) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean isOpenNow() {
        LocalTime now = LocalTime.now();

        if (openTime.isAfter(closeTime)) {
            return !now.isBefore(openTime) || !now.isAfter(closeTime);
        } else {
            return !now.isBefore(openTime) && !now.isAfter(closeTime);
        }
    }

    public Restaurant(int restaurantId, String name, String address, String phoneNumber, int lowestPrice, int highestPrice, LocalTime openTime, LocalTime closeTime, int status, int accountId, String reasonDeny) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.lowestPrice = lowestPrice;
        this.highestPrice = highestPrice;
        this.openTime = openTime;
        this.closeTime = closeTime;
        this.avatarPath = "images/restaurant.png";
        this.status = status;
        this.accountId = accountId;
        this.reasonDeny = reasonDeny;
    }

    public String getReasonDeny() {
        return reasonDeny;
    }

    public void setReasonDeny(String reasonDeny) {
        this.reasonDeny = reasonDeny;
    }

    

    public int getEditOf() {
        return editOf;
    }

    public void setEditOf(int editOf) {
        this.editOf = editOf;
    }

    public List<String> getProofPaths() {
        return proofPaths;
    }

    public void setProofPaths(List<String> proofPaths) {
        this.proofPaths = proofPaths;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Default constructor
    public Restaurant() {
    }

    // Getters and Setters
    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getLowestPrice() {
        return lowestPrice;
    }

    public void setLowestPrice(int lowestPrice) {
        this.lowestPrice = lowestPrice;
    }

    public int getHighestPrice() {
        return highestPrice;
    }

    public void setHighestPrice(int highestPrice) {
        this.highestPrice = highestPrice;
    }

    public LocalTime getOpenTime() {
        return openTime;
    }

    public void setOpenTime(LocalTime openTime) {
        this.openTime = openTime;
    }

    public LocalTime getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(LocalTime closeTime) {
        this.closeTime = closeTime;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }
}
