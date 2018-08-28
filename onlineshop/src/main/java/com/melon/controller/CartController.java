package com.melon.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.melon.po.Item;
import com.melon.po.Product;
import com.melon.po.User;
import com.melon.service.CartService;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
	@RequestMapping("/mycart")
	public String myCart(HttpServletRequest request) {
		User user = (User)request.getSession().getAttribute("user");
		Item itemForQuery = new Item();
		itemForQuery.setUserId(user.getId());
		List<Item> items = cartService.myCart(itemForQuery);
		request.setAttribute("items", items);
		return "/WEB-INF/jsp/cart.jsp";
	}
	
	@RequestMapping("/addtocart")
	public String addToCart(Product product,Item item, HttpServletRequest request) {
		User user = (User)(request.getSession().getAttribute("user"));
		int userId = user.getId();
		item.setUserId(userId);
		item.setProduct(product);
		Item existItem = cartService.searchExistItem(item);
		if(existItem == null) {
			item.setSubtotal(product.getProductPrice() * item.getProductCount());
			cartService.addToCart(item);
		}else {
			int newProductCount = existItem.getProductCount() + item.getProductCount();
			existItem.setProductCount(newProductCount);
			existItem.setSubtotal(product.getProductPrice() * newProductCount);
			cartService.updateCartItem(existItem);
		}
		return "mycart";
	}
	
	@RequestMapping("/modifyProductCount")
	public String modifyProductCount(@RequestBody String json, HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		int userId = user.getId();
		JSONObject data = JSONObject.parseObject(json);
		int productId = Integer.parseInt(data.getString("productId"));
		int productCount = Integer.parseInt(data.getString("productCount"));
		Item item = new Item();
		item.setUserId(userId);
		item.setProductId(productId);
		item.setProductCount(productCount);
		cartService.modifyProductCount(item);
		return "mycart";
	}
	
	@RequestMapping("/reduceCount")
	public String reduceCount(@RequestBody String json, HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		int userId = user.getId();
		JSONObject data = JSONObject.parseObject(json);
		int productId = Integer.parseInt(data.getString("productId"));
		Item item = new Item();
		item.setUserId(userId);
		item.setProductId(productId);
		cartService.reduceCount(item);
		return "mycart";
	}
	
	@RequestMapping("/addCount")
	public String addCount(@RequestBody String json, HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		int userId = user.getId();
		JSONObject data = JSONObject.parseObject(json);
		int productId = Integer.parseInt(data.getString("productId"));
		Item item = new Item();
		item.setUserId(userId);
		item.setProductId(productId);
		cartService.addCount(item);
		return "mycart";
	}
}
