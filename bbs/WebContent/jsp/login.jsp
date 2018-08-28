<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>登录</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/login.css">
</head>
<body>
	<div class="header">
		<img src="${pageContext.request.contextPath }/img/title.jpg" />
	</div>
	<form action="${pageContext.request.contextPath }/user/login.action" method="post">
		<div class="login_box">
		<img src="${pageContext.request.contextPath }/img/message.jpg" />
			<div class="login_out">
				<div class="login_in">
					<h3 style="text-align: center; letter-spacing: 20px;">登录</h3>
					<div class="username_box">
						<div class="login_text">
							<span>用户名</span>
						</div>
						<div class="input_box">
							<input type="text" name="username" style="height: 30px; font-size: 15px"></input>
						</div>
					</div>
					<div class="password_box">
						<div class="login_text">
							<span>密码</span>
						</div>
						<div class="input_box">
							<input type="password" name="password" style="height: 30px; font-size: 15px"></input>
						</div>
					</div>
					<div class="button">
						<input id="submit" type="submit" value="登录"></input>
						<input id="register" type="button" onclick='location.href=("register.jsp")' value="注册"></input>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>