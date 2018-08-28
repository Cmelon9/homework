package com.melon.service;

import java.util.List;

import com.melon.po.Comment;
import com.melon.po.Product;

public interface ProductService {

	void productComment(Comment comment);

	void updateCommented(Comment comment);

	Product getProductById(int productId);

	List<Comment> getComments(int productId);

}
