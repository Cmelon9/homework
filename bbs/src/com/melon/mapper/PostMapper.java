package com.melon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.melon.po.PostUser;
import com.melon.po.Reply;
import com.melon.po.ReplyUser;

public interface PostMapper {
	public void publish(PostUser postUser) throws Exception;
	
	public List<PostUser> searchPost(PostUser postUser) throws Exception;
	
	public List<PostUser> searchPostByKey(PostUser postUser) throws Exception; 
	
	public PostUser getPostContent(Integer postId) throws Exception;
	
	public List<ReplyUser> getPostReply(Integer postId)throws Exception;
	
	public void replyPost(Reply reply) throws Exception;
	public void updateReplyNum(@Param("replyNum")Integer replyNum, @Param("postId")Integer postId) throws Exception;
	
	public void deletePost(Integer postId) throws Exception;
}
