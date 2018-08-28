package com.melon.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.melon.po.PostUser;
import com.melon.po.Reply;
import com.melon.po.ReplyUser;
import com.melon.po.User;
import com.melon.service.PostService;


@Controller
@RequestMapping("/post")
public class PostServiceController {

	@Autowired
	private PostService postService;
	
	//��������
	@RequestMapping("/publish")
	public String publish(PostUser postUser,HttpServletRequest request) throws Exception {
		Date date = new Date();
		postUser.setPostTime(date);
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		postUser.setUser(user);
		postUser.setReplyNum(1);
		postService.publish(postUser);
		List<PostUser> posts = postService.searchPost(null);
		request.setAttribute("posts", posts);
		
		return "index";
	}
	
	//������ҳʱ������������
	@RequestMapping("/index")
	public String searchPost(HttpServletRequest request) throws Exception {
		PostUser postUser = new PostUser();
		Integer postFamily = Integer.parseInt(request.getParameter("postFamily"));
		if(postFamily != 0) {
			postUser.setPostFamily(postFamily);
		}
		List<PostUser> posts = postService.searchPost(postUser);
		request.setAttribute("posts", posts);
		return "index";
	}
	
	//����Ա������������
	@RequestMapping("/postManage")
	public String postManage(HttpServletRequest request) throws Exception {
		List<PostUser> posts = postService.searchPost(null);
		request.setAttribute("posts", posts);
		return "admin";
	}
	
	//�������ӱ���������ݲ����������
	@RequestMapping("/searchPostByKey")
	public String searchPostByKey(PostUser postUser, HttpServletRequest request) throws Exception {
		String keyWord = request.getParameter("key");
		postUser.setTittle(keyWord);
		postUser.setContent(keyWord);
		List<PostUser> posts = postService.searchPostByKey(postUser);
		request.setAttribute("posts", posts);
		return "index";
	}
	
	//�����Լ����������
	@RequestMapping("/searchPostByUser")
	public String searchPostByUser(Integer userId, HttpServletRequest request) throws Exception {
		userId = Integer.parseInt(request.getParameter("userId"));
		PostUser postUser = new PostUser();
		User user = new User();
		user.setId(userId);
		postUser.setUser(user);
		List<PostUser> posts = postService.searchPost(postUser);
		request.setAttribute("posts", posts);
		return "person";
	}
	
	//�鿴��������
	@RequestMapping("/postPage")
	public String getPostContent(HttpServletRequest request) throws Exception {
		Integer postId = Integer.parseInt(request.getParameter("postId"));
		PostUser postContent = postService.getPostContent(postId);
		request.setAttribute("postContent", postContent);
		List<ReplyUser> replyList = postService.getPostReply(postId);
		request.setAttribute("replyList", replyList);
		return "post";
	}
	
	//����
	@RequestMapping("/replyPost")
	public String replyPost(HttpServletRequest request,Reply reply) throws Exception {
		Integer postId = Integer.parseInt(request.getParameter("postId"));
		Integer userId = Integer.parseInt(request.getParameter("userId"));
		Integer replyNum = Integer.parseInt(request.getParameter("replyNum"));
		Integer stair = replyNum + 1;
		Date replyTime = new Date();
		reply.setPostId(postId);
		reply.setUserId(userId);
		reply.setStair(stair);
		reply.setReplyTime(replyTime);
		postService.replyPost(reply);
		postService.updateReplyNum(stair, postId);
		return "index";
	}
	
	//����Աɾ������
	@RequestMapping("/deletePost")
	public String deletePost(HttpServletRequest request) throws Exception {
		Integer postId = Integer.parseInt(request.getParameter("postId"));
		postService.deletePost(postId);
		List<PostUser> posts = postService.searchPost(null);
		request.setAttribute("posts", posts);
		return "admin";
	}
}
