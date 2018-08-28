package com.melon.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.melon.po.Item;
import com.melon.po.Order;
import com.melon.po.Product;
import com.melon.po.User;
import com.melon.service.AdminService;
import com.melon.service.OrderService;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private OrderService orderService;
	
	@RequestMapping("/addProduct")
	public String addProduct(Product product, MultipartFile productPic1) throws IllegalStateException, IOException {
		if(productPic1 != null) {
			String picPath = "D:\\workspace\\onlineshop\\src\\main\\webapp\\WEB-INF\\img\\";
			File file = new File(picPath + productPic1.getOriginalFilename());
			productPic1.transferTo(file);
			product.setProductPic(productPic1.getOriginalFilename());
		}
		adminService.addProduct(product);
		return "getProducts";
	}
	
	@RequestMapping("deleteProduct")
	public String deleteProduct(HttpServletRequest request) {
		int productId = Integer.parseInt(request.getParameter("id"));
		adminService.deleteProduct(productId);
		return "getProducts";
	}
	
	@RequestMapping("/editProduct")
	public String editProduct(Product product, MultipartFile productPic1,HttpServletRequest request) throws IllegalStateException, IOException {
		int editProductId = Integer.parseInt(request.getParameter("editProductId"));
		product.setId(editProductId);
		if(productPic1 != null) {
			String picPath = "D:\\workspace\\onlineshop\\src\\main\\webapp\\WEB-INF\\img\\";
			File file = new File(picPath + productPic1.getOriginalFilename());
			productPic1.transferTo(file);
			product.setProductPic(productPic1.getOriginalFilename());
		}
		adminService.editProduct(product);
		return "getProducts";
	}
	
	@RequestMapping("/getOrders")
	public String getOrders(@RequestBody String json,HttpServletRequest request) {
		JSONObject data = JSONObject.parseObject(json);
		User user = new User();
		int index;
		if(data != null) {
			index = Integer.parseInt(data.getString("index"));
			user.setIndex((index-1)*2);
		}else {
			index = 1;
			user.setIndex(index-1);
		}
		List<Order> orderList = orderService.getMyOrders(user);
		for(Order order : orderList) {
			List<Item> orderItems = orderService.getOrderItems(order.getOrderNum());
			order.setItems(orderItems);
		}
		int orderCount = adminService.getOrderCount();
		HttpSession session = request.getSession();
		session.removeAttribute("userList");
		session.removeAttribute("userCount");
		session.removeAttribute("productList");
		session.removeAttribute("productCount");
		session.setAttribute("orderList", orderList);
		session.setAttribute("orderCount", orderCount);
		session.setAttribute("nowPageNum", index);
		return "/WEB-INF/jsp/admin.jsp";
	}
	
	
	@RequestMapping("/getProducts")
	public String getProducts(@RequestBody String json,HttpServletRequest request) {
		JSONObject data = JSONObject.parseObject(json);
		int index;
		if(data != null) {
			index = Integer.parseInt(data.getString("index"));
		}else {
			index = 1;
		}
		List<Product> productList = adminService.getProducts((index-1)*5);
		int productCount = adminService.getProductCount();
		HttpSession session = request.getSession();
		session.removeAttribute("userList");
		session.removeAttribute("userCount");
		session.removeAttribute("orderList");
		session.removeAttribute("orderCount");
		session.setAttribute("productList", productList);
		session.setAttribute("productCount", productCount);
		session.setAttribute("nowPageNum", index);
		return "/WEB-INF/jsp/admin.jsp";
	}
	
	@RequestMapping("/getUsers")
	public String getUsers(@RequestBody String json,HttpServletRequest request) {
		JSONObject data = JSONObject.parseObject(json);
		int index;
		if(data != null) {
			index = Integer.parseInt(data.getString("index"));
		}else {
			index = 1;
		}
		List<User> userList = adminService.getUsers((index-1)*5);
		int userCount = adminService.getUserCount();
		HttpSession session = request.getSession();
		session.removeAttribute("orderList");
		session.removeAttribute("orderCount");
		session.removeAttribute("productList");
		session.removeAttribute("productCount");
		session.setAttribute("userList", userList);
		session.setAttribute("userCount", userCount);
		session.setAttribute("nowPageNum", index);
		return "/WEB-INF/jsp/admin.jsp";
	}
	
	@RequestMapping("/deleteUser")
	public String deleteUser(HttpServletRequest request) {
		int userId = Integer.parseInt(request.getParameter("userId"));
		adminService.deleteUser(userId);
		return "getUsers";
	}
}
