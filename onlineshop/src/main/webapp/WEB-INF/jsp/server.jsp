<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>腾扬超市</title>
	<base href="<%= basePath%>">
	<link rel="stylesheet" type="text/css" href="css/server.css">
	<script src="js/jquery.js"></script>
</head>
<body>
	<div id="header">
		<div id="top">
			<ul class="message-l">
			<c:if test="${sessionScope.user == null }">
				<li><a href="forward?link=server">亲，请登录</a></li>
				<li><a href="forward?link=server">免费注册</a></li>
			</c:if>
			<c:if test="${sessionScope.user != null }">
				<li>欢迎你，${sessionScope.user.username }</li>
				<li><a href="logout">注销</a></li>
				<c:if test="${sessionScope.user.level == 0 }">
				<li><a href="forward?link=admin">管理界面</a></li>
				</c:if>
			</c:if>
			</ul>
			<ul class="message-r">
				<li><a href="goindex">商城首页</a></li>
				<li><a href="forward?link=personal">个人中心</a></li>
				<li><a href="mycart">购物车</a></li>
				<li><a href="myFavourite">收藏夹</a></li>
			</ul>
		</div>
		<div id="search">
			<img src="img/logobig.jpg" id="headlogo">
			<div id="searchbox">
				<form>
					<input type="text" id="searchinput"></input>
					<input type="button" value="搜索" id="searchsubmit"></input>
				</form>
			</div>
		</div>
	</div>
	<div id="container">
		<div id="selectbox">
			<div id="select">
				<div id="loginselect" class="selected"><h2>登录</h2></div>
				<div id="registerselect"><h2>注册</h2></div>
			</div>
			<div style="clear: both;"></div>
			<div id="loginbox">
				<form action="login" method="post">
				<div class="username">
					<span>用户名</span><input type="text" name="username">
				</div>
				<div class="password">
					<span>密码</span><input type="password" name="password">
				</div>
				<div class="submit">
					<input type="submit" value="登录">
				</div>
				<small id="loginerror">${loginerror }</small>
				</form>
			</div>
			<div id="registerbox" style="display: none;">
				<form action="register" method="post">
				<div class="username">
					<span>用户名</span><input type="text" name="username" id="registerusername"><small id="usernamesmall">选个喜欢的用户名吧</small>
				</div>
				<div class="password">
					<span>手机</span><input type="text" name="telphone"><small>请输入你的电话号码</small>
				</div>
				<div class="password">
					<span>密码</span><input type="password" name="password" id="registerpassword"><small id="passwordsmall">密码长度为8-16位</small>
				</div>
				<div class="password">
					<span>重复密码</span><input type="password" id="passwordconfirm"><small id="passwordconfirmsmall">请重复你的密码</small>
				</div>
				<div class="submit">
					<input type="submit" id="registersubmit" value="注册">
				</div>
				</form>
			</div>
		</div>

		<script type="text/javascript">
			var loginselect = $('#loginselect');
			var registerselect = $('#registerselect');
			loginselect.click(function() {
				loginselect.removeClass('selected');
				registerselect.removeClass('selected');
				loginselect.addClass('selected');
				$('#registerbox').css('display','none');
				$('#loginbox').css('display','block');
			});
			registerselect.click(function() {
				loginselect.removeClass('selected');
				registerselect.removeClass('selected');
				registerselect.addClass('selected');
				$('#loginbox').css('display','none');
				$('#registerbox').css('display','block');
			});
			
			$('#registerusername').change(function(){
				$.ajax({
					type : 'post',
					url : "usernameIsExist",
					dataType : 'text',
					async : false,
					contentType : 'application/json;charset=UTF-8',
					data : JSON.stringify({
						"username" : $('#registerusername').val()
					}),
					success : function(data){
						var json = JSON.parse(data);
						var result = json.result;
						if(result == 1){
							$('#usernamesmall').html("恭喜你，该用户名可用");
							$('#registersubmit').attr('disabled',false);
						}
						if(result == 0){
							$('#usernamesmall').html("该用户名已被注册");
							$('#registersubmit').attr('disabled',true);
						}
					}
				})
			});
			
			var password = null;
			$('#registerpassword').change(function(){
				password = $('#registerpassword').val();
				if(password.length<8 || password.length>16){
					$('#passwordsmall').html('密码格式不正确');
					$('#registersubmit').attr('disabled',true);
				}else{
					$('#passwordsmall').html('密码可以使用');
					$('#registersubmit').attr('disabled',false);
				}
			});
			
			$('#passwordconfirm').change(function(){
				if($('#passwordconfirm').val() == $('#registerpassword').val()){
					$('#passwordconfirmsmall').html('密码正确');
					$('#registersubmit').attr('disabled',false);
				}else{
					$('#passwordconfirmsmall').html('不正确');
					$('#registersubmit').attr('disabled',true);
				}
			});
		</script>

	</div>
</body>
</html>