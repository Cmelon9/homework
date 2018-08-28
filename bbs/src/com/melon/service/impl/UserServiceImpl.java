package com.melon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.melon.mapper.UserMapper;
import com.melon.po.User;
import com.melon.service.UserService;

@Transactional
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public void register(User user) throws Exception {
		userMapper.register(user);
	}

	@Override
	public User login(User user) throws Exception {
		return userMapper.login(user);
	}

	@Override
	public void modify(User user) throws Exception {
		userMapper.modify(user);
	}

	@Override
	public List<User> searchUser() throws Exception {
		return userMapper.searchUser();
	}

	@Override
	public void deleteUser(Integer id) throws Exception {
		userMapper.deleteUser(id);
	}
}
