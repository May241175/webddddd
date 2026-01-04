package com.warehouse.model;

public class Customer {

    private int userId;
    private String userName;
    private String userEmail;
    private String userPassword;
    private String userFullname;
    private int isAdmin;
    private String userPhoneNumber;
    private String userAddress;
    private String userPayment;

    // Getters
    public int getUserId() { return userId; }
    public String getUserName() { return userName; }
    public String getUserEmail() { return userEmail; }
    public String getUserPassword() { return userPassword; }
    public String getUserFullname() { return userFullname; }
    public int getIsAdmin() { return isAdmin; }
    public String getUserPhoneNumber() { return userPhoneNumber; }
    public String getUserAddress() { return userAddress; }
    public String getUserPayment() { return userPayment; }

    // Setters
    public void setUserId(int userId) { this.userId = userId; }
    public void setUserName(String userName) { this.userName = userName; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    public void setUserPassword(String userPassword) { this.userPassword = userPassword; }
    public void setUserFullname(String userFullname) { this.userFullname = userFullname; }
    public void setIsAdmin(int isAdmin) { this.isAdmin = isAdmin; }
    public void setUserPhoneNumber(String userPhoneNumber) { this.userPhoneNumber = userPhoneNumber; }
    public void setUserAddress(String userAddress) { this.userAddress = userAddress; }
    public void setUserPayment(String userPayment) { this.userPayment = userPayment; }
}
