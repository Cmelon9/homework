package com.melon.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.melon.po.Address;
import com.melon.po.Item;
import com.melon.po.Order;
import com.melon.po.User;
import com.melon.service.CartService;
import com.melon.service.OrderService;
import com.melon.service.UserService;

@Controller
public class OrderController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private CartService cartService;
	@Autowired
	private UserService userService;
	
	@RequestMapping("/creatOrder")
	public String creatOrder(@RequestBody String json, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		List<Address> addressList = userService.getMyAddress(user);
		session.setAttribute("addressList", addressList);
		JSONObject itemlist = JSONObject.parseObject(json);
		List<Integer> productIdList = JSONObject.parseArray(itemlist.getString("productIdList"), int.class);
		List<Item> orderItems = new ArrayList<>();
		for(int productId : productIdList) {
			Item itemForQuery = new Item();
			itemForQuery.setUserId(user.getId());
			itemForQuery.setProductId(productId);
			List<Item> items = cartService.myCart(itemForQuery);
			for(Item item : items) {
				orderItems.add(item);
			}
		}
		String total = itemlist.getString("total");
		session.setAttribute("orderItems", orderItems);
		session.setAttribute("total", total);
		return "/WEB-INF/jsp/cart.jsp";
	}
	
	@RequestMapping("/balance")
	public String balance(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int userId = ((User)session.getAttribute("user")).getId();
		List<Item> items = (List<Item>) session.getAttribute("orderItems");
		double total = Double.parseDouble(session.getAttribute("total").toString());
		String password = request.getParameter("password");
		User user = new User();
		user.setId(userId);
		user.setPassword(password);
		if(!userService.checkPassword(user)) {
			request.setAttribute("passworderror", "密码错误，请重试");
			return "/WEB-INF/jsp/orderconfirm.jsp";
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmm");
		Date createTime = new Date();
		String orderNum = format.format(createTime) + (int)(Math.random() * 1000000);
		for(Item item : items) {
			orderService.updateProfit(item);
			item.setUserId(userId);
			item.setOrderNum(orderNum);
			orderService.updateItem(item);
		}
		Order order = new Order();
		int addressId = Integer.parseInt(request.getParameter("orderAddressId"));
		order.setAddressId(addressId);
		order.setCreateTime(createTime);
		order.setOrderNum(orderNum);
		order.setTotal(total);
		order.setUserId(userId);
		order.setItems(items);
		orderService.balance(order);
		session.removeAttribute("addressList");
		return "goindex";
	}
	
	@RequestMapping("myOrder")
	public String myOrder(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		List<Order> orderList = orderService.getMyOrders(user);
		for(Order order : orderList) {
			List<Item> orderItems = orderService.getOrderItems(order.getOrderNum());
			order.setItems(orderItems);
		}
		request.setAttribute("orderList", orderList);
		request.setAttribute("orderCount", orderList.size());
		return "/WEB-INF/jsp/personal.jsp";
	}
	
	@RequestMapping("confirmReceive")
	public String confirmReceive(HttpServletRequest request) {
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		orderService.confirmReceive(orderId);
		return "myOrder";
	}
	
	@RequestMapping("deliver")
	public String deliver(HttpServletRequest request) {
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		orderService.deliver(orderId);
		return "getOrders";
	}
}
