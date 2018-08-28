package com.melon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.melon.mapper.AdminMapper;
import com.melon.po.Product;
import com.melon.po.User;
import com.melon.service.AdminService;

@Transactional
@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminMapper adminMapper;

	@Override
	public void addProduct(Product product) {
		adminMapper.addProduct(product);
	}

	@Override
	public int getOrderCount() {
		return adminMapper.getOrderCount();
	}

	@Override
	public List<Product> getProducts(int index) {
		return adminMapper.getProducts(index);
	}

	@Override
	public int getProductCount() {
		return adminMapper.getProductCount();
	}

	@Override
	public List<User> getUsers(int index) {
		return adminMapper.getUsers(index);
	}

	@Override
	public int getUserCount() {
		return adminMapper.getUserCount();
	}

	@Override
	public void deleteUser(int userId) {
		adminMapper.deleteUser(userId);
	}

	@Override
	public void editProduct(Product product) {
		adminMapper.editProduct(product);
	}

	@Override
	public void deleteProduct(int productId) {
		adminMapper.deleteProduct(productId);
	}
}
