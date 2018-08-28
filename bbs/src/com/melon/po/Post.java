package com.melon.po;

import java.util.Date;

public class Post {
	private Integer id;
	private String tittle;
	private String content;
	private Date postTime;
	private Integer replyNum;
	private Integer postFamily;
	public Integer getPostFamily() {
		return postFamily;
	}
	public void setPostFamily(Integer postFamily) {
		this.postFamily = postFamily;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTittle() {
		return tittle;
	}
	public void setTittle(String tittle) {
		this.tittle = tittle;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getPostTime() {
		return postTime;
	}
	public void setPostTime(Date postTime) {
		this.postTime = postTime;
	}
	public Integer getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(Integer replyNum) {
		this.replyNum = replyNum;
	}
}
