package com.melon.mapper;

import java.util.List;

import com.melon.po.Product;
import com.melon.po.User;

public interface AdminMapper {

	void addProduct(Product product);

	int getOrderCount();

	List<Product> getProducts(int index);

	int getProductCount();

	List<User> getUsers(int index);

	int getUserCount();

	void deleteUser(int userId);

	void editProduct(Product product);

	void deleteProduct(int productId);
	
}
