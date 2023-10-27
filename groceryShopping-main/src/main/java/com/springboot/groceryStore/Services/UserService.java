package com.springboot.groceryStore.Services;

import com.springboot.groceryStore.Schemas.User;

import java.util.List;

public interface UserService {
    public String addUser(List<User>user);

    public List<User> getUser();
}
