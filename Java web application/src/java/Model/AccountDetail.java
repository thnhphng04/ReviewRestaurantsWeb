/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author truon
 */
public class AccountDetail {

    private int accountId;
    private String password;
    private boolean gender;
    private String phoneNumber;
    private Date dob;
    private String name, email;
    private int verifyCode;
    private String avatarPath;
    private int role, status;

   

    @Override
    public String toString() {
        return "AccountDetail{" + "accountId=" + accountId + ", password=" + password + ", gender=" + gender + ", phoneNumber=" + phoneNumber + ", dob=" + dob + ", name=" + name + ", email=" + email + ", role=" + role + ", status=" + status + '}';
    }

    public int getVerifyCode() {
        return verifyCode;
    }

    public void setVerifyCode(int verifyCode) {
        this.verifyCode = verifyCode;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public AccountDetail() {

    }

    public AccountDetail(int accountId, String password, boolean gender, String phoneNumber, Date dob, String name, String email, int role, int status) {
        this.accountId = accountId;
        this.password = password;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.name = name;
        this.email = email;
        this.role = role;
        this.status = status;
        if(avatarPath==null){
            this.avatarPath = "images/profile-1.jpg";
        }
        
    }

    public AccountDetail(int accountId, String password, boolean gender, String phoneNumber, Date dob, String name, String email, int role, int status, int verifyCode) {
        this.accountId = accountId;
        this.password = password;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.name = name;
        this.email = email;
        this.role = role;
        this.status = status;
        this.verifyCode = verifyCode;
    }

    public AccountDetail(String password, boolean gender, String phoneNumber, Date dob, String name, String email, int role, int status, int verifyCode) {

        this.password = password;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.name = name;
        this.email = email;
        this.role = role;
        this.status = status;
        this.verifyCode = verifyCode;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }
public AccountDetail(int accountId, String password, boolean gender, String phoneNumber, Date dob, String name, String email, int verifyCode, String avatarPath, int role, int status) {
        this.accountId = accountId;
        this.password = password;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.name = name;
        this.email = email;
        this.verifyCode = verifyCode;
        this.avatarPath = avatarPath;
        this.role = role;
        this.status = status;
    }

    private int numberOfPost;
    private int numberOfHiddenPost;

    public int getNumberOfPost() {
        return numberOfPost;
    }

    public void setNumberOfPost(int numberOfPost) {
        this.numberOfPost = numberOfPost;
    }

    public int getNumberOfHiddenPost() {
        return numberOfHiddenPost;
    }

    public void setNumberOfHiddenPost(int numberOfHiddenPost) {
        this.numberOfHiddenPost = numberOfHiddenPost;
    }

    public AccountDetail(int accountId, String password, boolean gender, String phoneNumber, Date dob, String name, String email, int role, int status, int numberOfPost, int numberOfHiddenPost) {
        this.accountId = accountId;
        this.password = password;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.name = name;
        this.email = email;
        this.role = role;
        this.status = status;
        this.numberOfPost = numberOfPost;
        this.numberOfHiddenPost = numberOfHiddenPost;
    }
}
