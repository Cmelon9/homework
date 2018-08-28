package com.melon.service;

import java.util.List;

import com.melon.po.Item;

public interface CartService {

	void addToCart(Item item);
	
	void updateCartItem(Item existItem);

	Item searchExistItem(Item item);

	List<Item> myCart(Item itemForQuery);

	void reduceCount(Item item);

	void addCount(Item item);

	void modifyProductCount(Item item);
	
}
