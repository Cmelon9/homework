<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>帖子</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/post.css">
</head>
<body style="background-color: #bcddef;">
	<div class="header">
		<img src="${pageContext.request.contextPath }/img/title.jpg" />
		<a href="${pageContext.request.contextPath }/post/index.action?postFamily=0">首页</a>
		<c:if test="${user == null }">
			<a href="${pageContext.request.contextPath }/jsp/login.jsp">登录</a>
			<a href="${pageContext.request.contextPath }/jsp/register.jsp">注册</a>
		</c:if>
		<c:if test="${user != null }">
			<a href="${pageContext.request.contextPath }/jsp/person.jsp">个人中心</a>
		</c:if>
	</div>
	<div class="content">
		<div class="poster">
			<div class="information">
				<div class="pic"> <img src="/pic/${postContent.user.head }"> </div>
				<a href="#">${postContent.user.username }</a>
			</div>
			<div class="post_reply">
				<div class="post_tittle" style="text-align: center";>
					<h2>${postContent.tittle  }</h2>
				</div>
				${postContent.content }
				<div class="option">
					<span>1楼</span>
					<span id="post_time"><fmt:formatDate value="${postContent.postTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </span>
				</div>
			</div>	
		</div>
		
		<ul>
		<c:forEach items="${replyList }" var="reply">
			<li>
				<div class="poster">
					<div class="information">
						<div class="pic"> <img src="/pic/${reply.user.head }"> </div>
						<a href="#">${reply.user.username }</a>
					</div>
					<div class="post_reply">
						${reply.replyContent }
						<div class="option">
							<span>${reply.stair }楼</span>
							<span id="post_time"><fmt:formatDate value="${reply.replyTime }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						</div>
					</div>	
				</div>
			</li>
		</c:forEach>
		</ul>
	</div>

	<hr style="width: 980px">

	<div class="foot">
		<h3 style="margin-left: 100px">回复</h3>
		<form action="${pageContext.request.contextPath }/post/replyPost.action" method="post">
			<div id="reply_content">
				<textarea id="content" name="replyContent" rows="20" cols="110"></textarea>
			</div>
			<input type="hidden" name="postId" value="${postContent.id }">
			<input type="hidden" name="userId" value="${sessionScope.user.id }">
			<input type="hidden" name="replyNum" value="${postContent.replyNum }">
			<div class="foot_button">
				<input id="reset" type="reset" value="重置" style="margin-right: 10px"></input>
				<input id="submit" type="submit" value="发表"></input>
			</div>
		</form>
	</div>	

</body>
</html>