package com.springboot.groceryStore.Services;

import com.springboot.groceryStore.Dao.UserDao;
import com.springboot.groceryStore.Schemas.Login;
import com.springboot.groceryStore.Schemas.LoginResponse;
import com.springboot.groceryStore.Schemas.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class UserServiceImp implements UserService{
    @Autowired
    private UserDao userDao;
    @Override
    public String addUser(List<User> user) {
        userDao.saveAll(user);
        return "User added successfully";
    }

    @Override
    public List<User> getUser() {
        return userDao.findAll();
    }


    public LoginResponse loginuser(Login login) {
        String msg = "";
        User employee1 = userDao.findByEmail(login.getEmail());
        if (employee1 != null) {
            String password = login.getPassword();
            String dbpass = employee1.getPassword();
            if (password.equals(dbpass)) {
                Optional<User> employee = userDao.findOneByEmailAndPassword(login.getEmail(), dbpass);
                if (employee.isPresent()) {
                    return new LoginResponse("Login Success", employee1.getUserType());
                } else {
                    return new LoginResponse("Login Failed", "");
                }
            } else {

                return new LoginResponse("password Not Match", "");
            }
        }else {
            return new LoginResponse("Email not exits", "");
        }


    }
}
