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
	<title></title>
	<base href="<%= basePath%>">
	<link rel="stylesheet" type="text/css" href="css/cart.css">
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
	
	<div id="cart">
		<div id="carthead">
			<div id="select">选中</div>
 			<div id="introduction">商品信息</div>
 			<div id="price">单价</div>
 			<div id="count">数量</div>
 			<div id="subtotal">小计</div>
 			<div id="operation">操作</div>
		</div>
		<ul id="items">
			<c:forEach items="${items }" var="item" varStatus="status">
				<li>
					<input class="productid" type="hidden" value="${item.product.id }">
					<div class="select"><input index="${status.index }" class="selection" type="checkbox"></div>
					<div class="introduction"><a href="getProductById?id=${product.id }"><img src="img/${item.product.productPic }"></a>
					<a href="#">${item.product.productName }</a></div>
					<div class="price"><strong>${item.product.productPrice }</strong></div>
					<div class="count"><button class="reduceCount" productId="${item.product.id }">-</button>
										<input type="text" class="cartItemCount" productId="${item.product.id }" value="${item.productCount }">
										<button class="addCount" productId="${item.product.id }">+</button></div>
					<div class="subtotal"><strong class="subtotalin">${item.subtotal }</strong></div>
					<div class="operation"><a href="#">删除</a></div>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div id="total">
 		<div id="selectAll">
 			<button>全选</button>
 		</div>
 		<div id="confirm">
 			总价：<strong>0</strong>
 			<button id="submit">结算</button>
 		</div>
 	</div>
 	
 	<script type="text/javascript">
 		$('.cartItemCount').each(function(){
 			$(this).change(function(){
 				$.ajax({
 					url: 'modifyProductCount',
 					type: 'POST',
 					async : false,
 					dataType: 'text',
 					contentType : 'application/json;charset=UTF-8',
 					data: JSON.stringify({
						"productId" : $(this).attr('productId'),
						"productCount" : $(this).val()
 					}),
 					success : function(){
 						window.location.href="mycart";
 					}
 				})
 			});
 		});
 		
 		$('.reduceCount').each(function(){
 			$(this).click(function(){
 				$.ajax({
 					url: 'reduceCount',
 					type: 'POST',
 					async : false,
 					dataType: 'text',
 					contentType : 'application/json;charset=UTF-8',
 					data: JSON.stringify({
						"productId" : $(this).attr('productId')
 					}),
 					success : function(){
 						window.location.href="mycart";
 					}
 				})
 			});
 		});
 		$('.addCount').each(function(){
 			$(this).click(function(){
 				$.ajax({
 					url: 'addCount',
 					type: 'POST',
 					async : false,
 					dataType: 'text',
 					contentType : 'application/json;charset=UTF-8',
 					data: JSON.stringify({
						"productId" : $(this).attr('productId')
 					}),
 					success : function(){
 						window.location.href="mycart";
 					}
 				})
 			});
 		});
 	
		var aSelect = $('.selection');
		var selectAll = $('#selectAll').children('button').eq(0);
		//全选
		selectAll.click(function() {
			aSelect.each(function() {
				$(this).prop('checked', true);
			});
			var total = 0;
			$('.subtotalin').each(function() {
				total += Number($(this).html());
			});
			$('#confirm').children('strong').eq(0).html(total);
		});
		//单点复选框
		for(var i=0 ; i<aSelect.length ; i++){
			aSelect.eq(i).click(function() {
				var total = Number($('#confirm').children('strong').eq(0).html());
				if($(this).prop('checked') == true){
					total += Number($('.subtotalin').eq($(this).attr('index')).html());
				}else{
					total -= Number($('.subtotalin').eq($(this).attr('index')).html());
				}
				$('#confirm').children('strong').eq(0).html(total);
			});
		}
		
		//提交订单
		$('#submit').click(function() {
			var productIdList = new Array();
			for(var i=0 ; i<aSelect.length ; i++){
				if(aSelect.eq(i).prop('checked') == true){
					productIdList.push(Number($('.productid').eq(aSelect.eq(i).attr('index')).val()));
				}
			}
			
			$.ajax({
				url: 'creatOrder',
				type: 'POST',
				async : false,
				dataType: 'text',
				contentType : 'application/json;charset=UTF-8',
				data: JSON.stringify({
					"productIdList" : productIdList,
					"total" : Number($('#confirm').children('strong').eq(0).html())
				}),
				success : function(){
					window.location.href="forward?link=orderconfirm";
				}
			});
		});
	</script>
 	
</body>
</html>