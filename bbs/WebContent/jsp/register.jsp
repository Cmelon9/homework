<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>注册</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/register.css">
</head>
<body>
	<div class="header">
		<img src="${pageContext.request.contextPath }/img/title.jpg" />
	</div>
	<div class="register_box">
		<div class="tittle">
			<h2>注册</h2>
		</div>
		<form action="${pageContext.request.contextPath }/user/register.action" method="post" enctype="multipart/form-data">
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
					<div class="span"><span>密码</span></div>    
					<div class="box"><input class="input" type="password" name="password"></input></div>
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
				<input class="button" type="submit" value="注册"></input>
			</div>
		</form>		
	</div>
</body>
</html>