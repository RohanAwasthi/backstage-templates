package com.springboot.groceryStore;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)

public class GroceryStoreApplication {
//	@Autowired
//	private UserTypeDao userTypeDao;
//	@PostConstruct
//	public void addUserType(){
//		List<UserType>userTypes= Stream.of(
//				new UserType(1,"Admin"),
//				new UserType(2,"Vendor"),
//				new UserType(3,"Customer")
//		).collect(Collectors.toList());
//		userTypeDao.saveAll(userTypes);
//	}


	public static void main(String[] args) {
		SpringApplication.run(GroceryStoreApplication.class, args);
	}

}
