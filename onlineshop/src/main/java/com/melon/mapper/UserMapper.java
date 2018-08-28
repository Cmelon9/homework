package com.melon.mapper;

import java.util.List;

import com.melon.po.Address;
import com.melon.po.Favourite;
import com.melon.po.Product;
import com.melon.po.User;

public interface UserMapper {
	public User login(User user);

	public void register(User user);

	public String usernameIsExist(String username);

	public Favourite favouriteIsExist(Favourite favourite);

	public void collect(Favourite favourite);

	public User checkPassword(User user);

	public List<Product> getMyFavourite(User user);

	public List<Address> getMyAddress(User user);

	public void modifyPassword(User user);

	public void addAddress(Address address);

	public void deleteAddress(int addressId);

	public List<Product> searchProducts(Product product);

	public int getProductCount(Product product);

	public List<Product> getTopSells();
}
