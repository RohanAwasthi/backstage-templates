package com.springboot.groceryStore.Schemas;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Product {
    @Id
    @GeneratedValue
    int prodId;
    String ProdName;
    int stock;
    double price;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="catId")
    private Category category;


}
