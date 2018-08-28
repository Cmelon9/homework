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
	
	//ע��
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
	
	//���ݵ����ť����ҳ������ tx=1�����޸���Ϣ��tx=2����鿴��������
	@RequestMapping("/person")
	public String person(HttpServletRequest request)throws Exception{
		Integer tx = Integer.parseInt(request.getParameter("tx"));
		request.setAttribute("tx", tx);
		return "person";
	}
	
	//�޸ĸ�����Ϣ
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
	
	//��¼�������û��ȼ��ж��ǹ���Ա������ͨ�û���level=1Ϊ��ͨ�û���level=0Ϊ����Ա
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
	
	//ע��
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "index";
	}
	
	//����Ա�鿴�����û���Ϣ
	@RequestMapping("/searchUser")
	public String searchUser(HttpServletRequest request) throws Exception {
		List<User> userList = userService.searchUser();
		request.setAttribute("userList", userList);
		return "admin";
	}
	
	//ɾ���û�
	@RequestMapping("/deleteUser")
	public String deleteUser(Integer id, HttpServletRequest request) throws Exception {
		userService.deleteUser(id);
		List<User> userList = userService.searchUser();
		request.setAttribute("userList", userList);
		return "admin";
	}
	
}
