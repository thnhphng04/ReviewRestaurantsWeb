/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class Post {
    private int postId;
    private int accountId;
    private int restaurantId;
    private String title;
    private LocalDateTime date;
    private String text;
    private float rating;
    private int status;
    private List<String> imagePaths;
    private List<String> proofPaths;
    private float serviceRating;
    private float priceRating;
    private float spaceRating;
    private float tasteRating;
    private float hygieneRating;
    
    private List<Integer> mealList;
    private List<Integer> foodList;
    
    private String reasonDeny;

    
    private int editOf;

    
    
    
    

    public Post(int postId, int accountId, int restaurantId, String title, LocalDateTime date, String text, float rating, int status) {
        this.postId = postId;
        this.accountId = accountId;
        this.restaurantId = restaurantId;
        this.title = title;
        this.date = date;
        this.text = text;
        this.rating = rating;
        this.status = status;
        this.imagePaths = new ArrayList<>();
    }

    public Post(int postId, int accountId, int restaurantId, String title, LocalDateTime date, String text, float rating, int status, float serviceRating, float priceRating, float spaceRating, float tasteRating, float hygieneRating, String reasonDeny) {
        this.postId = postId;
        this.accountId = accountId;
        this.restaurantId = restaurantId;
        this.title = title;
        this.date = date;
        this.text = text;
        this.rating = rating;
        this.status = status;
        this.imagePaths = new ArrayList<>();
        this.proofPaths = new ArrayList<>();
        this.serviceRating = serviceRating;
        this.priceRating = priceRating;
        this.spaceRating = spaceRating;
        this.tasteRating = tasteRating;
        this.hygieneRating = hygieneRating;
        this.reasonDeny = reasonDeny;
    }

    public int getEditOf() {
        return editOf;
    }

    public void setEditOf(int editOf) {
        this.editOf = editOf;
    }
    
    
    
    public String getReasonDeny() {
        return reasonDeny;
    }

    public void setReasonDeny(String reasonDeny) {
        this.reasonDeny = reasonDeny;
    }
    
    public List<Integer> getMealList() {
        return mealList;
    }

    public void setMealList(List<Integer> mealList) {
        this.mealList = mealList;
    }

    public List<Integer> getFoodList() {
        return foodList;
    }

    public void setFoodList(List<Integer> foodList) {
        this.foodList = foodList;
    }
    
    public List<String> getProofPaths() {
        return proofPaths;
    }

    public void setProofPaths(List<String> proofPaths) {
        this.proofPaths = proofPaths;
    }

    public float getServiceRating() {
        return serviceRating;
    }

    public void setServiceRating(float serviceRating) {
        this.serviceRating = serviceRating;
    }

    public float getPriceRating() {
        return priceRating;
    }

    public void setPriceRating(float priceRating) {
        this.priceRating = priceRating;
    }

    public float getSpaceRating() {
        return spaceRating;
    }

    public void setSpaceRating(float spaceRating) {
        this.spaceRating = spaceRating;
    }

    public float getTasteRating() {
        return tasteRating;
    }

    public void setTasteRating(float tasteRating) {
        this.tasteRating = tasteRating;
    }

    public float getHygieneRating() {
        return hygieneRating;
    }

    public void setHygieneRating(float hygieneRating) {
        this.hygieneRating = hygieneRating;
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

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<String> getImagePaths() {
        return imagePaths;
    }

    public void setImagePaths(List<String> imagePaths) {
        this.imagePaths = imagePaths;
    }
    
    public void addImagePath(String imagePath) {
        this.imagePaths.add(imagePath);
    }
    
    public String getFormattedDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        return date.format(formatter);
    }
    
}
