package com.warehouse.model;

public class User {

    private int user_id;
    private String user_name;
    private String user_email;
    private String user_password;
    private String user_fullname;
    private String user_phone_number;
    private String user_address;
    private String user_payment;
    private boolean is_admin;
    
    public boolean isAdmin() {
        return is_admin;
    }
    public void setIs_admin(boolean is_admin) {
        this.is_admin = is_admin;
    }
    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public String getUser_name() { return user_name; }
    public void setUser_name(String user_name) { this.user_name = user_name; }

    public String getUser_email() { return user_email; }
    public void setUser_email(String user_email) { this.user_email = user_email; }

    public String getUser_password() { return user_password; }
    public void setUser_password(String user_password) { this.user_password = user_password; }

    public String getUser_fullname() { return user_fullname; }
    public void setUser_fullname(String user_fullname) { this.user_fullname = user_fullname; }

    public String getUser_phone_number() { return user_phone_number; }
    public void setUser_phone_number(String user_phone_number) { this.user_phone_number = user_phone_number; }

    public String getUser_address() { return user_address; }
    public void setUser_address(String user_address) { this.user_address = user_address; }

    public String getUser_payment() { return user_payment; }
    public void setUser_payment(String user_payment) { this.user_payment = user_payment; }

    public boolean getIs_admin() { return is_admin; }
   

	
}
