package com.springboot.groceryStore.Dao;

import com.springboot.groceryStore.Schemas.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductDao extends JpaRepository<Product,Integer> {
}
