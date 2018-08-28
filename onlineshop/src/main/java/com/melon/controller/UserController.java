package com.melon.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.melon.po.Address;
import com.melon.po.Comment;
import com.melon.po.Favourite;
import com.melon.po.Product;
import com.melon.po.User;
import com.melon.service.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@RequestMapping("/forward")
	public String forward(HttpServletRequest request) {
		String link = request.getParameter("link");
		User user = (User) request.getSession().getAttribute("user");
		if(link.equalsIgnoreCase("server")) {
			return "/WEB-INF/jsp/server.jsp";
		}else if(link.equalsIgnoreCase("introduction")) {
			return "/WEB-INF/jsp/introduction.jsp";
		}else if(link.equalsIgnoreCase("orderconfirm")) {
			return "/WEB-INF/jsp/orderconfirm.jsp";
		}else if(link.equalsIgnoreCase("personal")) {
			if(user != null) {
				request.getSession().removeAttribute("addressList");
				return "/WEB-INF/jsp/personal.jsp";
			}else {
				return "/WEB-INF/jsp/server.jsp";
			}
		}else if(link.equalsIgnoreCase("modifyPassword")) {
			request.setAttribute("modify", 1);
			return "/WEB-INF/jsp/personal.jsp";
		}else if(link.equalsIgnoreCase("admin")) {
			return "/WEB-INF/jsp/admin.jsp";
		}else if(link.equalsIgnoreCase("shopmap")) {
			return "/WEB-INF/jsp/shopmap.jsp";
		}
		return null;
	}
	
	@RequestMapping("/goindex")
	public String goindex(HttpServletRequest request) {
		List<Product> topSells =  userService.getTopSells();
		request.setAttribute("topSells", topSells);
		return "/WEB-INF/jsp/index.jsp";
	}
	
	@RequestMapping("/register")
	public String register(User user) {
		userService.register(user);
		return "/WEB-INF/jsp/server.jsp";
	}
	
	@RequestMapping("/login")
	public String login(User user, HttpServletRequest request) {
		User userIsExist = userService.login(user);
		if(userIsExist == null) {
			request.setAttribute("loginerror", "账号或密码错误，请重试");
			return "/WEB-INF/jsp/server.jsp";
		}else {
			request.getSession().setAttribute("user", userIsExist);
			if(userIsExist.getLevel() == 0) {
				return "/WEB-INF/jsp/admin.jsp";
			}else {
				return "goindex";
			}
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "goindex";
	}
	
	@RequestMapping("/usernameIsExist")
	public @ResponseBody Map<String,Object> usernameIsExist(@RequestBody String json,HttpServletRequest request) {
		JSONObject username = JSONObject.parseObject(json);
		String str = username.getString("username");
		String existUsername =  userService.usernameIsExist(str);
		Map<String,Object> map = new HashMap<>();
		if(existUsername == null) {
			map.put("result", 1);
		}else {
			map.put("result", 0);
		}
		return map;
	}
	
	@RequestMapping("/searchProducts")
	public String searchProducts(@RequestBody String json,HttpServletRequest request) {
		Product product = new Product();
		HttpSession session = request.getSession();
		JSONObject data = JSONObject.parseObject(json);
		int index;
		if(data != null) {
			index = Integer.parseInt(data.getString("index"));
			product.setIndex((index-1)*10);
		}else {
			index = 1;
			product.setIndex(index-1);
		}
		/*根据商品种类查找商品*/
		String category = request.getParameter("category");
		int productCategory;
		if(category != null) {
			productCategory = Integer.parseInt(category);
			if(productCategory != 0) {
				product.setProductCategory(productCategory);
			}
			session.setAttribute("productCategory", productCategory);
			session.removeAttribute("productName");
		}else {
			if(session.getAttribute("productCategory") != null) {
				productCategory = (int) session.getAttribute("productCategory");
				if(productCategory != 0) {
					product.setProductCategory(productCategory);
				}
			}
			session.removeAttribute("productName");
		}
		/*根据商品种类查找商品*/
		
		/*根据商品名搜索*/
		String productName = request.getParameter("productName");
		if(productName != null) {
			product.setProductName(productName);
			product.setProductCategory(null);
			session.setAttribute("productName", productName);
			session.removeAttribute("productCategory");
		}else {
			if(session.getAttribute("productName") != null) {
				productName = (String) session.getAttribute("productName");
				product.setProductName(productName);
			}
		}
		/*根据商品名搜索*/
		List<Product> productList = userService.searchProducts(product);
		int productCount = userService.getProductCount(product);
		session.setAttribute("productList", productList);
		session.setAttribute("productCount", productCount);
		session.setAttribute("nowPageNum", index);
		return "/WEB-INF/jsp/shopmap.jsp";
	}
	
	//收藏商品
	@RequestMapping("/collect")
	public @ResponseBody Map<String,Object> collect(@RequestBody String json,HttpServletRequest request) {
		JSONObject data = JSONObject.parseObject(json);
		int productId = data.getInteger("productId");
		User user = (User)(request.getSession().getAttribute("user"));
		int userId = user.getId();
		Favourite favourite = new Favourite();
		favourite.setProductId(productId);
		favourite.setUserId(userId);
		boolean isSuccess = userService.collect(favourite);
		Map<String,Object> map = new HashMap<>();
		if(isSuccess) {
			map.put("result", 1);
		}else {
			map.put("result", 0);
		}
		return map;
	}
	
	@RequestMapping("/myFavourite")
	public String myFavourite(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		List<Product> favourites =  userService.getMyFavourite(user);
		request.setAttribute("favourites", favourites);
		return "/WEB-INF/jsp/personal.jsp";
	}
	
	@RequestMapping("modifyPassword")
	public String modifyPassword(HttpServletRequest request) {
		String password = request.getParameter("password");
		User user = (User) request.getSession().getAttribute("user");
		user.setPassword(password);
		userService.modifyPassword(user);
		request.getSession().invalidate();
		return "/WEB-INF/jsp/server.jsp";
	}
	
	@RequestMapping("/addressManage")
	public String addressManage(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		List<Address> addressList = userService.getMyAddress(user);
		request.setAttribute("addressList", addressList);
		return "/WEB-INF/jsp/personal.jsp";
	}
	
	@RequestMapping("/addAddress")
	public String addAddress(@RequestBody String json,HttpServletRequest request) {
		JSONObject newAddress = JSONObject.parseObject(json);
		String receiveAddress = newAddress.getString("address");
		String receiver = newAddress.getString("receiver");
		String telphone = newAddress.getString("telphone");
		Address address = new Address();
		address.setAddress(receiveAddress);
		address.setReceiver(receiver);
		address.setTelphone(telphone);
		User user = (User) request.getSession().getAttribute("user");
		address.setUserId(user.getId());
		userService.addAddress(address);
		return "/WEB-INF/jsp/personal.jsp";
	}
	
	@RequestMapping("/deleteAddress")
	public String deleteAddress(@RequestBody String json) {
		JSONObject addressid = JSONObject.parseObject(json);
		int addressId = addressid.getIntValue("addressId");
		userService.deleteAddress(addressId);
		return "/WEB-INF/jsp/personal.jsp";
	}
	
}
