package com.melon.mapper;

import java.util.List;

import com.melon.po.Item;
import com.melon.po.Order;
import com.melon.po.User;

public interface OrderMapper {

	List<Item> getItems(int userId);

	void balance(Order order);

	void updateItem(Item item);

	void updateProfit(Item item);

	List<Order> getMyOrders(User user);

	List<Item> getOrderItems(String orderNum);

	void confirmReceive(int orderId);

	void deliver(int orderId);
	
}
