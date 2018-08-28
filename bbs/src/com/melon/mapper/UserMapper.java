package com.melon.mapper;

import java.util.List;

import com.melon.po.User;

public interface UserMapper {
	public void register(User user) throws Exception;
	
	public void modify(User user) throws Exception;
	
	public User login(User user) throws Exception;
	
	public List<User> searchUser() throws Exception;
	
	public void deleteUser(Integer id) throws Exception;
}
