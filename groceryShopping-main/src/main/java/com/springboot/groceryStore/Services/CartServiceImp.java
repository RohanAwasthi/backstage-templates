package com.springboot.groceryStore.Services;

import com.springboot.groceryStore.Dao.CartDao;
import com.springboot.groceryStore.Dao.ProductDao;
import com.springboot.groceryStore.Schemas.OrderCart;
import com.springboot.groceryStore.Schemas.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
@Component
public class CartServiceImp implements CartService{
    @Autowired
    CartDao cartDao;
    @Autowired
    ProductDao productDao;
    @Override
    public List<OrderCart> getCarts() {
        return cartDao.findAll();
    }

    @Override
    public List<Product> getCartProducts() {
        return productDao.findAll();
    }

    @Override
    public String addProduct(Product product) {
        productDao.save(product);
        return "Product Added";
    }
}
