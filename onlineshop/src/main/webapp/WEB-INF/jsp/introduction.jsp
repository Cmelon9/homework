<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>${product.productName }</title>
	<base href="<%= basePath%>">
	<link rel="stylesheet" type="text/css" href="css/introduction.css">
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

	<div id="bannner">
		<ul id="showguide">
			<li id="a"><p>全部分类</p>
				<ul>
					<li><a href="searchProducts?category=0">全部商品</a></li>
					<li><a href="searchProducts?category=1">进口商品</a></li>
					<li><a href="searchProducts?category=2">食品饮料</a></li>
					<li><a href="searchProducts?category=3">粮油副食</a></li>
					<li><a href="searchProducts?category=4">美容洗护</a></li>
					<li><a href="searchProducts?category=5">家居家电</a></li>
					<li><a href="searchProducts?category=6">家庭清洁</a></li>
					<li><a href="searchProducts?category=7">母婴用品</a></li>
					<li><a href="searchProducts?category=8">生鲜水果</a></li>
				</ul>
			</li>
			<li><a href="goindex">首页</a></li>
		</ul>
	</div>
	<script type="text/javascript">
		var showguide = $('#showguide').find('li').eq(0);
		var guide = $('#showguide').find('ul').eq(0);
		showguide.mouseenter(function(){
			guide.fadeIn('slow');
		});
		showguide.mouseleave(function(){
			guide.fadeOut('slow');
		});
	</script>

	<div id="item">
		<img src="img/${product.productPic }">
		<div>
			<form action="addtocart?id=${product.id }&productPrice=${product.productPrice}" method="post">
				<strong>${product.productName }</strong><br>
				<span>价格：</span><strong>￥${product.productPrice}元</strong><br>
				<span>数量：</span><button type="button">-</button><input id="count" type="text" value="1" name="productCount"><button type="button">+</button><br>
				<input id="addtocart" type="submit" value="加入购物车">
				<a id="collect" href="javascript:;" productId="${product.id }">收藏商品</a><span id="collectMessage"></span>
			</form>
		</div>
		<script type="text/javascript">
			var aButton = $('#item').find('button');
			var count = $('#item').find('input').eq(0);
			count.bind('input propertychange', function(){
				var reg = /^[0-9]*$/;
				if (!reg.test(count.val()) || count.val() <= 0) {
					count.val(1);
				}	
			});
			aButton.eq(0).click(function(){
				var countVal = parseInt(count.val());
				countVal--;
				if(countVal==0) countVal=1;
				count.val(countVal);
			});
			aButton.eq(1).click(function(){
				count.val(parseInt(count.val())+1);
			});
			
			$('#collect').click(function(){
				$.ajax({
					url: "collect",
					type: 'POST',
					async : false,
					dataType: 'text',
					contentType : 'application/json;charset=UTF-8',
					data: JSON.stringify({
						"productId" : this.getAttribute('productId')
					}),
					success : function(data){
						var json = JSON.parse(data);
						var result = json.result;
						if(result == 1){
							$('#collectMessage').html("收藏成功");
							$('#collect').attr('disabled',true);
						}
						if(result == 0){
							$('#collectMessage').html("该商品已经收藏过");
							$('#collect').attr('disabled',true);
						}
					}
				})
			});
		</script>
	</div>
	<div style="clear: both;"></div>

	<div id="commentheader">
		<h2>商品评价</h2>
	</div>
	<ul id="comment">
		<c:forEach items="${commentList }" var="comment">
		<li>
			<div class="username">用户：${comment.user.username }</div>
			<div class="content">${comment.content }</div>
			<div class="time"> <fmt:formatDate value="${comment.commentTime }" pattern="yyyy-MM-dd"/> </div>
		</li>
		</c:forEach>
	</ul>

	<div id="bottom">
		<p>我是有底线的~~</p>
		<hr>
		<p>网络141 陈明朗~</p>
	</div>
</body>
</html>