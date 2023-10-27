package com.springboot.groceryStore.Schemas;

public class LoginResponse {

    private  String message;
    private String userType;

    public LoginResponse(String message, String userType) {
        this.message = message;
        this.userType = userType;
    }

    public LoginResponse() {
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }
}
