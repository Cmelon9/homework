package com.melon.service;

import java.util.List;

import com.melon.po.PostUser;
import com.melon.po.Reply;
import com.melon.po.ReplyUser;

public interface PostService {
	public void publish(PostUser postUser) throws Exception;
	
	public List<PostUser> searchPost(PostUser postUser) throws Exception;
	
	public List<PostUser> searchPostByKey(PostUser postUser) throws Exception; 
	
	public PostUser getPostContent(Integer postId) throws Exception;
	
	public List<ReplyUser> getPostReply(Integer postId)throws Exception;
	
	public void replyPost(Reply reply) throws Exception;
	public void updateReplyNum(Integer replyNum, Integer postId) throws Exception;
	
	public void deletePost(Integer postId) throws Exception;
}
