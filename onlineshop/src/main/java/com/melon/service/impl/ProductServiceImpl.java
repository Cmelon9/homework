package com.melon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.melon.mapper.ProductMapper;
import com.melon.po.Comment;
import com.melon.po.Product;
import com.melon.service.ProductService;

@Transactional
@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductMapper productMapper;

	@Override
	public void productComment(Comment comment) {
		productMapper.productComment(comment);
	}

	@Override
	public void updateCommented(Comment comment) {
		productMapper.updateCommented(comment);
	}

	@Override
	public Product getProductById(int productId) {
		return productMapper.getProductById(productId);
	}

	@Override
	public List<Comment> getComments(int productId) {
		return productMapper.getComments(productId);
	}
}
