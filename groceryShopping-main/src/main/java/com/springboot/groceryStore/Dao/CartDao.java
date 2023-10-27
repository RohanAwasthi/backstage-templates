package com.springboot.groceryStore.Dao;

import com.springboot.groceryStore.Schemas.OrderCart;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartDao extends JpaRepository<OrderCart, Integer> {

}
