package com.melon.po;

import java.util.Date;

public class Reply {
	private Integer id;
	private Integer postId;
	private Integer userId;
	private String replyContent;
	private Integer stair;
	private Date replyTime;
	public Integer getPostId() {
		return postId;
	}
	public void setPostId(Integer postId) {
		this.postId = postId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Integer getStair() {
		return stair;
	}
	public void setStair(Integer stair) {
		this.stair = stair;
	}
	public Date getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}
}
