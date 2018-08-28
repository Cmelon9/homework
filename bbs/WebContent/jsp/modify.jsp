<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>个人中心</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/person.css">
</head>
<body>
	<div class="header">
		<h3>个人中心</h3>
		<div class="head_pic"> <img src="/pic/111.jpg" alt="头像"> </div>
		<div class="option">
			<a href="${pageContext.request.contextPath }/modify?userId=${sessionScope.user.id}">修改资料</a>
			<a href="${pageContext.request.contextPath }/mypost?userId=${sessionScope.user.id}">我的帖子</a>
		</div>
	</div>
	<div class="content">
		<div class="modify">
		<form action="${pageContext.request.contextPath }/user/modify.action" method="post" enctype="multipart/form-data">
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
		
		
	</div>
</body>
</html>