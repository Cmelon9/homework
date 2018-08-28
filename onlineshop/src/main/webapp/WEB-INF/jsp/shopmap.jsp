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
	<title>腾扬超市</title>
	<base href="<%= basePath%>">
	<link rel="stylesheet" type="text/css" href="css/shopmap.css">
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
				<form action="searchProducts" method="get">
					<input type="text" id="searchinput" name="productName"></input>
					<input type="submit" value="搜索" id="searchsubmit"></input>
				</form>
			</div>
		</div>
	</div>

	<div id="banner">
		<ul id="showguide">
			<li><p>全部分类</p>
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

	<script type="text/javascript">
		function creatPage(opt){
			if(!opt.obj) {return false;}
			var obj = opt.obj;
			var objId = opt.objId;
			var allPageNum = opt.allPageNum;
			var nowPageNum = opt.nowPageNum;

			//上一页
			var oLi = $('<li><a></a></li>');
			var oA = oLi.children('a').eq(0);
			oA.attr('href','javascript:;');
			oA.attr('index',(nowPageNum-1));
			if(nowPageNum-1 == 0) oA.attr('index','1');
			oA.html('上一页');
			obj.append(oLi);
			//中间页
			//总页数少于5
			if(allPageNum <= 5){
				for(var i=1 ; i<=allPageNum ; i++){
					var oLi = $('<li><a></a></li>');
					var oA = oLi.children('a').eq(0);
					oA.attr('href','javascript:;');
					oA.attr('index',i);
					oA.html(i);
					obj.append(oLi);
				}
			}else{
				//当前页为1或2
				if(nowPageNum == 1 || nowPageNum == 2){
					for(var i=1 ; i<=5 ; i++){
						var oLi = $('<li><a></a></li>');
						var oA = oLi.children('a').eq(0);
						oA.attr('href','javascript:;');
						oA.attr('index',i);
						oA.html(i);
						obj.append(oLi);
					}
				//当前页为末页或末页前一页
				}else if(allPageNum-nowPageNum == 0 || allPageNum-nowPageNum == 1){
					for(var i=allPageNum-4 ; i<=allPageNum ; i++){
						var oLi = $('<li><a></a></li>');
						var oA = oLi.children('a').eq(0);
						oA.attr('href','javascript:;');
						oA.attr('index',i);
						oA.html(i);
						obj.append(oLi);
					}
				}else{
					for(var i=nowPageNum-2 ; i<=nowPageNum+2 ; i++){
						var oLi = $('<li><a></a></li>');
						var oA = oLi.children('a').eq(0);
						oA.attr('href','javascript:;');
						oA.attr('index',i);
						oA.html(i);
						obj.append(oLi);
					}
				}
			}
			//下一页
			var oLi = $('<li><a></a></li>');
			var oA = oLi.children('a').eq(0);
			oA.attr('href','javascript:;');
			oA.attr('index',(nowPageNum+1));
			if(nowPageNum+1 > allPageNum)  oA.attr('index',allPageNum);
			oA.html('下一页');
			obj.append(oLi);

			var pageA = document.getElementById(objId).getElementsByTagName('a');
			for(var i=1 ; i<pageA.length-1 ; i++){
				if(pageA[i].getAttribute('index') == nowPageNum){
					pageA[i].className = 'nowpage';
				}
			}
			//传页码到后台作分页处理
			var aA = obj.find('a');
			for(var i=0 ; i<aA.length ; i++){
				aA.eq(i).click(function(){
					nowPageNum = parseInt(this.getAttribute('index'));
					obj.html('');
					creatPage({
						obj : obj,
						objId : objId,
						allPageNum : allPageNum ,
						nowPageNum : nowPageNum 
					});
					$.ajax({
						url: opt.requestMapping,
						type: 'POST',
						async : false,
						dataType: 'text',
						contentType : 'application/json;charset=UTF-8',
						data: JSON.stringify({
							"index" : this.getAttribute('index')
						}),
						success : function(){
							window.location.href="forward?link=shopmap"
						}
					})
				});
			}
		}
		</script>

	<div id="itemsmap">
		<ul id="itemslist">
			<c:forEach items="${productList }" var="product">
			<li>
				<a href="getProductById?id=${product.id }"> <img src="img/${product.productPic }"> </a>
				<a href="getProductById?id=${product.id }"> <p>${product.productName }</p> </a>
				<span>总销量:${product.sells }</span>
				<strong>￥${product.productPrice }元</strong>
			</li>
			</c:forEach>
		</ul>
		<div id="flip">
			<ul></ul>
			<span></span>
			<input type="text" value="1">
			<span>页</span>
			<input type="submit" value="确定">
		</div>
	</div>
	<script type="text/javascript">	
		var count = '${ productCount}';
		var nowPageNum = '${ nowPageNum}';
		$('#flip').children('span').eq(0).html('共'+Math.ceil( count / 10)+'页，到');
		creatPage({
			obj : $('#flip').children('ul').eq(0),
			objId: 'flip',
			allPageNum : Math.ceil(count / 10) ,
			nowPageNum : Number(nowPageNum) ,
			requestMapping : "searchProducts"
		});
	</script>

	<div id="bottom">
		<p>我是有底线的~~</p>
		<hr>
		<p>网络141 陈明朗~</p>
	</div>
</body>
</html>