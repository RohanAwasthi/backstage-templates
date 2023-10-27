package com.springboot.groceryStore.Controllers;

import com.springboot.groceryStore.Dao.CartDao;
import com.springboot.groceryStore.Schemas.OrderCart;
import com.springboot.groceryStore.Schemas.Product;
import com.springboot.groceryStore.Services.CartServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("http://localhost:3000")
public class CartController {
    @Autowired
    CartServiceImp cartServiceImp;
    @GetMapping("/getCart")
    public List<OrderCart> getCart(){
        return cartServiceImp.getCarts();
    }

    @PostMapping("/addToCart")
    public String addToCart(@RequestBody Product product){
        cartServiceImp.addProduct(product);
        return "Product Added";
    }

    @GetMapping("/getCartProducts")
    public List<Product> getProducts(){
        return cartServiceImp.getCartProducts();
    }

}
