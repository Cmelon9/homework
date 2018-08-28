package com.melon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.melon.mapper.PostMapper;
import com.melon.po.PostUser;
import com.melon.po.Reply;
import com.melon.po.ReplyUser;
import com.melon.service.PostService;

@Transactional
public class PostServiceImpl implements PostService{

	@Autowired
	private PostMapper postMapper;
	
	public void publish(PostUser postUser) throws Exception {
		postMapper.publish(postUser);
	}

	@Override
	public List<PostUser> searchPost(PostUser postUser) throws Exception {
		return postMapper.searchPost(postUser);
	}

	@Override
	public PostUser getPostContent(Integer postId) throws Exception {
		return postMapper.getPostContent(postId);
	}

	@Override
	public List<ReplyUser> getPostReply(Integer postId) throws Exception {
		return postMapper.getPostReply(postId);
	}
	
	@Override
	public void replyPost(Reply reply) throws Exception {
		postMapper.replyPost(reply);
	}

	@Override
	public void updateReplyNum(Integer replyNum, Integer postId) throws Exception {
		postMapper.updateReplyNum(replyNum, postId);
	}

	@Override
	public List<PostUser> searchPostByKey(PostUser postUser) throws Exception {
		return postMapper.searchPostByKey(postUser);
	}

	@Override
	public void deletePost(Integer postId) throws Exception {
		postMapper.deletePost(postId);
	}

}
