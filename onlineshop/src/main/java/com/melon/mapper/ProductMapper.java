package com.melon.mapper;

import java.util.List;

import com.melon.po.Comment;
import com.melon.po.Product;

public interface ProductMapper {

	void productComment(Comment comment);

	void updateCommented(Comment comment);

	Product getProductById(int productId);

	List<Comment> getComments(int productId);

}
