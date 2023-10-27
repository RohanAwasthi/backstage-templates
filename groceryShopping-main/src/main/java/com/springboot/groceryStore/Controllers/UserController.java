package com.springboot.groceryStore.Controllers;

import com.springboot.groceryStore.Schemas.Login;
import com.springboot.groceryStore.Schemas.LoginResponse;
import com.springboot.groceryStore.Schemas.User;
import com.springboot.groceryStore.Services.UserServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("http://localhost:3000")
public class UserController {
    @Autowired
    private UserServiceImp userServiceImp;

    @PostMapping("/addUser")
    public String addUser(@RequestBody List<User> user) {
        return userServiceImp.addUser(user);
    }

    @GetMapping("/getUser")
    public List<User> getUser(){
        return userServiceImp.getUser();
    }

    @PostMapping ("/login")
    public ResponseEntity login(@RequestBody Login login){
        LoginResponse loginResonse=userServiceImp.loginuser(login);
        return ResponseEntity.ok(loginResonse);
    }

}
