package com.melon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.melon.mapper.UserMapper;
import com.melon.po.Address;
import com.melon.po.Favourite;
import com.melon.po.Product;
import com.melon.po.User;
import com.melon.service.UserService;

@Transactional
@Service("userService")
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public void register(User user) {
		userMapper.register(user);
	}
	
	@Override
	public User login(User user) {
		return userMapper.login(user);
	}

	@Override
	public String usernameIsExist(String username) {
		return userMapper.usernameIsExist(username);
	}

	@Override
	public boolean collect(Favourite favourite) {
		Favourite existFavourite = userMapper.favouriteIsExist(favourite);
		if(existFavourite == null) {
			userMapper.collect(favourite);
			return true;
		}else{
			return false;
		}
	}

	@Override
	public boolean checkPassword(User user) {
		User user1 = userMapper.checkPassword(user);
		if(user1 == null) {
			return false;
		}else
		return true;
	}

	@Override
	public List<Product> getMyFavourite(User user) {
		return userMapper.getMyFavourite(user);
	}

	@Override
	public List<Address> getMyAddress(User user) {
		return userMapper.getMyAddress(user);
	}

	@Override
	public void modifyPassword(User user) {
		userMapper.modifyPassword(user);
	}

	@Override
	public void addAddress(Address address) {
		userMapper.addAddress(address);
	}

	@Override
	public void deleteAddress(int addressId) {
		userMapper.deleteAddress(addressId);
	}

	@Override
	public List<Product> searchProducts(Product product) {
		return userMapper.searchProducts(product);
	}

	@Override
	public int getProductCount(Product product) {
		return userMapper.getProductCount(product);
	}

	@Override
	public List<Product> getTopSells() {
		return userMapper.getTopSells();
	}

}
