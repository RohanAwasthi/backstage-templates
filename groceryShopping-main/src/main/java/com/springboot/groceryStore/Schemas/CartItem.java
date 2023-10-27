package com.springboot.groceryStore.Schemas;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class CartItem {
    @Id
    @GeneratedValue
    int itemId;

    @ManyToOne
    Product product;

  int qty;
  @ManyToOne
          @JoinColumn(name="orderId")
    OrderCart orderCart;

}
