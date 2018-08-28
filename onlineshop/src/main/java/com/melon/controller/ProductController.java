package com.melon.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.melon.po.Comment;
import com.melon.po.Product;
import com.melon.po.User;
import com.melon.service.ProductService;

@Controller
public class ProductController {
	@Autowired
	private ProductService productService;
	
	@RequestMapping("getProductById")
	public String getProductById(HttpServletRequest request) {
		int productId = Integer.parseInt(request.getParameter("id"));
		//根据商品ID得到商品信息，单价等等
		Product result = productService.getProductById(productId);
		//根据商品ID得到商品的评价
		List<Comment> commentList = productService.getComments(productId);
		request.setAttribute("product", result);
		request.setAttribute("commentList", commentList);
		return "/WEB-INF/jsp/introduction.jsp";
	}
	
	@RequestMapping("/commentProduct")
	public String commentProduct(@RequestBody String json,HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		JSONObject data = JSONObject.parseObject(json);
		String content = data.getString("commentContext");
		Integer productId = data.getInteger("productId");
		String orderNum = data.getString("orderNum");
		Date commentTime = new Date();
		Comment comment = new Comment();
		comment.setCommentTime(commentTime);
		comment.setOrderNum(orderNum);
		comment.setContent(content);
		comment.setProductId(productId);
		comment.setUserId(user.getId());
		productService.productComment(comment);
		productService.updateCommented(comment);
		return "/WEB-INF/jsp/personal.jsp";
	}
	
	@RequestMapping("/editProductBefore")
	public @ResponseBody Map<String,Object> editProductBefore(@RequestBody String json,HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject data = JSONObject.parseObject(json);
		int productId = data.getInteger("productId");
		Product product = productService.getProductById(productId);
		//request.setAttribute("product", product);
		map.put("product", product);
		return map;
	}
}
