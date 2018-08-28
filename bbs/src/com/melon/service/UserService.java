package com.melon.service;

import java.util.List;

import com.melon.po.User;

public interface UserService {
	public void register(User user) throws Exception;
	
	public void modify(User user) throws Exception;
	
	public User login(User user) throws Exception;
	
	public List<User> searchUser() throws Exception;
	
	public void deleteUser(Integer id) throws Exception;
}	
