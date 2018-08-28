<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%= basePath%>">
	<title>确认订单</title>
	<link rel="stylesheet" type="text/css" href="css/orderconfirm.css">
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

	<div id="contain">
		<div id="address">
			<strong>选择收货地址</strong>
			<button onclick="window.location.href='forward?link=personal'">添加新地址</button>
			<ul id="selectaddress">
				<c:forEach items="${addressList }" var="address">
				<li>
					<input type="hidden" value="${address.id }">
					<div>
						<span>${address.receiver }</span>
						<span>${address.telphone }</span>
					</div>
					<div>
						<span>${address.address }</span>
					</div>
					<div>
						<a href="#">编辑</a>|<a href="#">删除</a>
					</div>
				</li>
				</c:forEach>
			</ul>
		</div>
		<div class="logistics">
			<strong>选择物流方式</strong>
			<ul class="selectlogistics">
				<li>
					<img src="img/shunfeng.jpg">顺丰
				</li>
				<li>
					<img src="img/zhongtong.jpg">中通
				</li>
				<li>
					<img src="img/yuantong.jpg">圆通
				</li>
				<li>
					<img src="img/yunda.jpg">韵达
				</li>
				<li>
					<img src="img/shentong.jpg">申通
				</li>
			</ul>
		</div>
		<div class="logistics">
			<strong>选择支付方式</strong>
			<ul class="selectlogistics">
				<li>
					<img src="img/zhifubao.jpg">支付宝
				</li>
				<li>
					<img src="img/weixin.jpg">微信
				</li>
			</ul>
		</div>

		<script type="text/javascript">
			var aAddress = $('#selectaddress').children('li');
			var aLogistics = $('.selectlogistics').eq(0).children('li');
			var apayway = $('.selectlogistics').eq(1).children('li');
			function selected(obj){
				obj.each(function() {
					$(this).click(function() {
						obj.each(function() {
							$(this).removeClass('selected');
						});
						$(this).addClass('selected');
					});
				});
			}
			selected(aAddress);
			selected(aLogistics);
			selected(apayway);	
		</script>

		<div id="order">
			<strong>确认订单信息</strong>
			<div id="cart">
				<div id="carthead">
		 			<div id="introduction">商品信息</div>
		 			<div id="price">单价</div>
		 			<div id="count">数量</div>
		 			<div id="subtotal">小计</div>
		 			<div id="operation">操作</div>
				</div>
				<ul id="items">
				<c:forEach items="${orderItems }" var="orderItem">
					<li>
						<div class="introduction"><a href="getProductById?id=${orderItem.product.id }"><img src="img/${orderItem.product.productPic }"></a>
						<a href="getProductById?id=${orderItem.product.id }">${orderItem.product.productName }</a></div>
						<div class="price"><strong>${orderItem.product.productPrice }</strong></div>
						<div class="count"><strong>${orderItem.productCount }</strong></div>
						<div class="subtotal"><strong>${orderItem.subtotal }</strong></div>
						<div class="operation"><a href="#">删除</a></div>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
		<div id="confirm">
			<div id="paybox">
				<p>合计：￥<span>${total }</span></p>
				<p>寄送至：<span id="confirmaddress"></span></p>
				<p>收货人：<span id="confirmreceiver"></span></p>
			</div>
			<div style="clear: both;"></div>
		<form action="balance" method="post">
			<input type="hidden" id="orderAddressId" name="orderAddressId" value="">
			<div id="passwordbox">
				请输入密码：<input type="password" id="paypassword" name="password"><small>${passworderror }</<small>
			</div>
			<div style="clear: both;"></div>
			<br>
			<button id="balancebutton">提交订单</button>
		</form>
			<div style="clear: both;"></div>
		</div>

		<script type="text/javascript">
			aAddress.each(function() {
				$(this).click(function() {
					if($(this).attr('class').toString() == 'selected'){
						$('#confirmreceiver').html($(this).find('span').eq(0).html() + '  ' + $(this).find('span').eq(1).html());
						$('#confirmaddress').html($(this).find('span').eq(2).html());
						$('#orderAddressId').val($(this).children('input').eq(0).val());
					}
				});
			});
		</script>

	</div>

	<div id="bottom">
		<p>我是有底线的~~</p>
		<hr>
		<p>网络141 陈明朗~</p>
	</div>
</body>
</html>