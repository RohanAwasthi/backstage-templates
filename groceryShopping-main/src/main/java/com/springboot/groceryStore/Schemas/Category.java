package com.springboot.groceryStore.Schemas;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Category {
    @Id
    @GeneratedValue
    int catId;
    String catName;
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "category")
      @JsonIgnore
    private List<Product> products;
}
