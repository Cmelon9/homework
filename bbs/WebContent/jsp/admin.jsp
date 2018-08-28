<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>后台管理</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/admin.css">
</head>
<body>
	<div class="header">
		<img src="${pageContext.request.contextPath }/img/title.jpg" />
		<a href="${pageContext.request.contextPath }/post/index.action?postFamily=0">首页</a>
		<div class="welcome">
			欢迎光临，${user.username }
		</div>
	</div>
	<div class="content">
		<div class="guide">
			<ul>
				<li> <a href="${pageContext.request.contextPath }/user/searchUser.action">用户管理</a> </li>
				<li> <a href="${pageContext.request.contextPath }/post/postManage.action">帖子管理</a> </li>
			</ul>
		</div>
		<div class="content_show">
			<c:if test="${userList != null }">
			<div class="user_list">
				<div class="table_head">
					<div class="attritube"><span>用户名</span></div>
					<div class="attritube"><span>学校</span></div>
					<div class="attritube"><span>专业</span></div>
					<div class="attritube"><span>电话</span></div>
					<div class="attritube"><span>操作</span></div>
				</div>
				<hr style="width: 828px;">
				<ul>
					<li>
						<div class="user">
						<c:forEach items="${userList }" var="user">
							<div class="attritube"><span>${user.username }</span></div>
							<div class="attritube"><span>${user.school }</span></div>
							<div class="attritube"><span>${user.major }</span></div>
							<div class="attritube"><span>${user.tel }</span></div>
							<div class="attritube"><span><a href="${pageContext.request.contextPath }/user/deleteUser.action?id=${user.id}">删除</a></span></div>
							<hr style="width: 828px;">
						</c:forEach>
						</div>
					</li>
				</ul>
			</div>
			</c:if>
			
			<c:if test="${posts != null }">
			<ul id="post_list">
			<c:forEach items="${posts }" var="post">
				<li class="post">
					<div class="post_out">
						<div class="reply_num">
							<span title="回复">${post.replyNum }</span>
						</div>
						<div class="post_show">
							<a href="${pageContext.request.contextPath }/post/postPage.action?postId=${post.id } "><p>${post.tittle }</p></a>
						</div>
						<div class="poster">
							<p>${post.user.username }</p>
						</div>
						<div class="last_time">
							<span title="发表时间"><fmt:formatDate value="${post.postTime }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						</div>
						<div class="delete">
							<a href="${pageContext.request.contextPath }/post/deletePost.action?postId=${post.id } ">删除</a>
						</div>
					</div>
				</li>
			</c:forEach>
			</ul>
			</c:if>
			
			
		</div>
	</div>
</body>
</html>