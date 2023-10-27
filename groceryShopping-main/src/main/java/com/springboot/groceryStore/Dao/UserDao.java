package com.springboot.groceryStore.Dao;

import com.springboot.groceryStore.Schemas.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserDao extends JpaRepository<User,Integer> {

    Optional<User> findOneByEmailAndPassword(String email, String password);

    User findByEmail(String email);
}
