package com.melon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.melon.mapper.OrderMapper;
import com.melon.po.Item;
import com.melon.po.Order;
import com.melon.po.User;
import com.melon.service.OrderService;

@Transactional
@Service("orderService")
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderMapper orderMapper;
	
	@Override
	public List<Item> getItems(int userId) {
		return orderMapper.getItems(userId);
	}

	@Override
	public void balance(Order order) {
		orderMapper.balance(order);
	}

	@Override
	public void updateItem(Item item) {
		orderMapper.updateItem(item);
	}

	@Override
	public void updateProfit(Item item) {
		orderMapper.updateProfit(item);
	}

	@Override
	public List<Order> getMyOrders(User user) {
		return orderMapper.getMyOrders(user);
	}

	@Override
	public List<Item> getOrderItems(String orderNum) {
		return orderMapper.getOrderItems(orderNum);
	}

	@Override
	public void confirmReceive(int orderId) {
		orderMapper.confirmReceive(orderId);
	}

	@Override
	public void deliver(int orderId) {
		orderMapper.deliver(orderId);
	}

}
