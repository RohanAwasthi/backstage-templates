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
public class Address {
    @Id
    @GeneratedValue
    int addressId;
    String street;
    String city;
    String state;
    int pinCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="userId",nullable = false)
    private User user;
}
