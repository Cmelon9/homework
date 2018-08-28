<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>计算机硬件交流平台</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/index.css">
</head>
<body style="background-color: #bcddef ;">
	<div class="header">
		<img src="${pageContext.request.contextPath }/img/title.jpg" />
		<a href="${pageContext.request.contextPath }/post/index.action?postFamily=0">首页</a>
		<c:if test="${user == null }">
			<a href="${pageContext.request.contextPath }/jsp/login.jsp">登录</a>
			<a href="${pageContext.request.contextPath }/jsp/register.jsp">注册</a>
		</c:if>
		<c:if test="${user != null }">
		<a href="${pageContext.request.contextPath }/jsp/person.jsp">个人中心</a>
			<div class="welcome">
				<p>欢迎你,${user.username }</p>
				<a href="${pageContext.request.contextPath }/user/logout.action">注销</a>
			</div>
		</c:if>
		<c:if test="${user.level == 1 }">
			<a href="${pageContext.request.contextPath }/jsp/admin.jsp">后台管理</a>
		</c:if>
	</div>
	
	<div class="guide">
		<div class="guide_tittle"> <h3>板块分类</h3> </div>
		<div class="guide_list"> <a href="${pageContext.request.contextPath }/post/index.action?postFamily=0">全部帖子</a> </div>
		<div class="guide_list"> <a href="${pageContext.request.contextPath }/post/index.action?postFamily=1">电脑测评</a> </div>		
		<div class="guide_list"> <a href="${pageContext.request.contextPath }/post/index.action?postFamily=2">电脑选购</a> </div>	
		<div class="guide_list"> <a href="${pageContext.request.contextPath }/post/index.action?postFamily=3">其他</a> </div>	
		<form action="${pageContext.request.contextPath }/post/searchPostByKey.action" method="post" style="float: right;">
			<input type="text" name="key">
			<input type="submit" value="搜索">
		</form>
	</div>
	
	<div class="content">
		<ul id="post_list">
		<c:forEach items="${posts }" var="post">
			<li class="post">
				<div class="post_out">
					<div class="post_in">
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
					</div>
				</div>
			</li>
		</c:forEach>
		</ul>
	</div>
	
	
	<div class="foot">
		<h3>发表新帖</h3>
		<form action="${pageContext.request.contextPath }/post/publish.action" method="post">
			<div id="tittle_box">
				<div class="post_family">
					<div class="family_select">
						帖子分类
					</div>
					<div class="select_box">
						<select name="postFamily">
							<option value="1">电脑测评</option>
							<option value="2">电脑选购</option>
							<option value="3">其他</option>
						</select>
					</div>
				</div>
				<div class="tittle_name">
					标题
				</div>
				<div id="tittle_text">
					<input type="text" id="tittle" name="tittle"></input>
				</div>
			</div>
			<div id="post_content">
				<textarea id="content" name="content" rows="20" cols="110"></textarea>
			</div>
			<div class="foot_button">
				<input id="reset" type="reset" value="重置" style="margin-right: 10px"></input>
				<input id="submit" type="submit" value="发表"></input>
			</div>
		</form>
	</div>
</body>
</html>