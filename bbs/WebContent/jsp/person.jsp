<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>个人中心</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/person.css">
</head>
<body>
	<div class="header">
		<h3>个人中心</h3>
		<div class="head_pic"> <img src="/pic/${user.head }" alt="头像"> </div>
		<div class="option">
			<a href="${pageContext.request.contextPath }/post/index.action?postFamily=0">首页</a>
			<a href="${pageContext.request.contextPath }/user/person.action?tx=1">修改资料</a>
			<a href="${pageContext.request.contextPath }/post/searchPostByUser.action?userId=${user.id}">我的帖子</a>
		</div>
		<c:if test="${user != null }">
			<div class="welcome">
				<p>欢迎你,${user.username }</p>
				<a href="${pageContext.request.contextPath }/user/logout.action">注销</a>
			</div>
		</c:if>
	</div>
	<div class="content">
	
	<c:if test="${tx == 1 }">
		<div class="modify">
		<form action="${pageContext.request.contextPath }/user/modify.action?id=${user.id}" method="post" enctype="multipart/form-data">
			<div class="information_box">
				<div class="information">
					<div class="span"><span>头像</span></div>     
					<div class="box"><input class="input" type="file" name="headPic"></input></div>
				</div>
				<div class="information">
					<div class="span"><span>姓名</span></div>     
					<div class="box"><input class="input" type="text" name="username"></input></div>
				</div>
				<div class="information">
					<div class="span"><span>新密码</span></div>    
					<div class="box"><input class="input" type="password" name="password"></input></div>
				</div>
				<div class="information">
					<div class="span"><span>重复新密码</span></div>    
					<div class="box"><input class="input" type="password" name="newPassword"></input></div>
				</div>
				<div class="information">
					<div class="span"><span>学校</span></div>     
					<div class="box"><input class="input" type="text" name="school"></input></div>
				</div>
				<div class="information">
					<div class="span"><span>专业</span></div>     
					<div class="box"><input class="input" type="text" name="major"></input></div>
				</div>
				<div class="information">
					<div class="span"><span>手机</span></div>    
					<div class="box"><input class="input" type="text" name="tel"></input></div>
				</div>
			</div>
			<div class="butttons">
				<input class="button" type="reset" value="重置"></input>
				<input class="button" type="submit" value="确认"></input>
			</div>
		</form>	
		</div>
	</c:if>
		
	<%-- <c:if test="${tx == 2 }"> --%>
		<div class="mypost">
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
						<div class="last_time">
							<span title="发表时间"><fmt:formatDate value="${post.postTime }"  pattern="yyyy-MM-dd HH:mm:ss"/></span>
						</div>
					</div>
				</div>
			</li>
		</c:forEach>
		</ul>
		</div>
	<%-- </c:if> --%>
		
	</div>
</body>
</html>