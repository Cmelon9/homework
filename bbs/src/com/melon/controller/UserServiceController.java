package com.melon.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.melon.po.User;
import com.melon.service.UserService;

@Controller
@RequestMapping("/user")
public class UserServiceController {
	
	@Autowired
	private UserService userService;
	
	//注册
	@RequestMapping("/register")
	public String register(User user,MultipartFile headPic) throws Exception {
		if(headPic != null) {
			String picPath = "D:\\bbs\\pic\\";
			File file = new File(picPath + headPic.getOriginalFilename());
			headPic.transferTo(file);
			user.setHead(headPic.getOriginalFilename());
		}
		user.setLevel(0);
		userService.register(user);
		return "index";
	}
	
	//根据点击按钮返回页面内容 tx=1代表修改信息，tx=2代表查看个人帖子
	@RequestMapping("/person")
	public String person(HttpServletRequest request)throws Exception{
		Integer tx = Integer.parseInt(request.getParameter("tx"));
		request.setAttribute("tx", tx);
		return "person";
	}
	
	//修改个人信息
	@RequestMapping("/modify")
	public String modify(HttpServletRequest request,User user,MultipartFile headPic) throws Exception {
		Integer id = Integer.parseInt(request.getParameter("id"));
		user.setId(id);
		if(headPic != null) {
			String picPath = "D:\\bbs\\pic\\";
			File file = new File(picPath + headPic.getOriginalFilename());
			headPic.transferTo(file);
			user.setHead(headPic.getOriginalFilename());
		}
		userService.modify(user);
		User user1 = userService.login(user);
		HttpSession session = request.getSession();
		session.setAttribute("user", user1);
		return "person";
	}
	
	//登录，根据用户等级判断是管理员还是普通用户，level=1为普通用户，level=0为管理员
	@RequestMapping("/login")
	public String login(User user,HttpServletRequest request) throws Exception{
		User user1 = userService.login(user);
		HttpSession session = null;
		
		if(user1 == null) {
			return "loginerror";
		}else {
			if(user1.getLevel() == 0) {
				session = request.getSession();
				session.setAttribute("user", user1);
				return "index";
			}
			if(user1.getLevel() == 1) {
				session = request.getSession();
				session.setAttribute("user", user1);
				return "admin";
			}
		}
		return null;
	}
	
	//注销
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "index";
	}
	
	//管理员查看所有用户信息
	@RequestMapping("/searchUser")
	public String searchUser(HttpServletRequest request) throws Exception {
		List<User> userList = userService.searchUser();
		request.setAttribute("userList", userList);
		return "admin";
	}
	
	//删除用户
	@RequestMapping("/deleteUser")
	public String deleteUser(Integer id, HttpServletRequest request) throws Exception {
		userService.deleteUser(id);
		List<User> userList = userService.searchUser();
		request.setAttribute("userList", userList);
		return "admin";
	}
	
}
