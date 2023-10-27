package com.springboot.groceryStore.Schemas;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter

public class User {
    @Id
    @GeneratedValue
    int user_id;
    String userName;
    String password;
    String email;
    String fullName;

     String userType;
//    @OneToOne(fetch = FetchType.LAZY,optional = true,cascade = CascadeType.ALL,mappedBy = "user")
//    private OrderCart orderCart;
//    @OneToMany(fetch = FetchType.LAZY,mappedBy = "user")  //address id one to many
//    private Set<Address> address;

}
