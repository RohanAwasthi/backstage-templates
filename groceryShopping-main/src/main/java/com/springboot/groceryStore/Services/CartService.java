package com.springboot.groceryStore.Services;

import com.springboot.groceryStore.Dao.UserDao;
import com.springboot.groceryStore.Schemas.OrderCart;
import com.springboot.groceryStore.Schemas.Product;

import java.util.List;

public interface CartService {

    public List<OrderCart> getCarts();

    public List<Product> getCartProducts();

    public String addProduct(Product product);
}
