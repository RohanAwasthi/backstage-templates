package com.springboot.groceryStore.Dao;

import com.springboot.groceryStore.Schemas.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryDao extends JpaRepository<Category,Integer> {
}
