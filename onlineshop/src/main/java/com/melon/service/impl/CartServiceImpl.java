package com.melon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.melon.mapper.CartMapper;
import com.melon.po.Item;
import com.melon.service.CartService;

@Transactional
@Service("cartService")
public class CartServiceImpl implements CartService {
	@Autowired
	private CartMapper cartMapper;

	@Override
	public void addToCart(Item item) {
		cartMapper.addToCart(item);
	}
	
	@Override
	public void updateCartItem(Item existItem) {
		cartMapper.updateCartItem(existItem);
	}

	@Override
	public Item searchExistItem(Item item) {
		return cartMapper.searchExistItem(item);
	}

	@Override
	public List<Item> myCart(Item itemForQuery) {
		return cartMapper.myCart(itemForQuery);
	}

	@Override
	public void reduceCount(Item item) {
		cartMapper.reduceCount(item);
	}

	@Override
	public void addCount(Item item) {
		cartMapper.addCount(item);
	}

	@Override
	public void modifyProductCount(Item item) {
		cartMapper.modifyProductCount(item);
	}
}
