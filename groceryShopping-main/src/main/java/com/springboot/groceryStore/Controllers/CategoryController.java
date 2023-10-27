package com.springboot.groceryStore.Controllers;

import com.springboot.groceryStore.Dao.CategoryDao;
import com.springboot.groceryStore.Dao.UserDao;
import com.springboot.groceryStore.Schemas.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("http://localhost:3000")
public class CategoryController {
    @Autowired
    private CategoryDao categoryDao;
    @PostMapping("/addCategory")
    public String addCategory(@RequestBody List<Category> categories){
         categoryDao.saveAll(categories);
         return "category added successfully";
    }
    @GetMapping("/getCategory")
    public List<Category> getCategory(){
        return categoryDao.findAll();
    }
}
