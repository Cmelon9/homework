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
	<link rel="stylesheet" type="text/css" href="css/index.css">
</head>
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
		<div id="guide">
			<ul id="classifylist">
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
		</div>
		<div id="picview">
			<a href="#"><img id="ad" src="" alt="加载中"></a>
			<button id="button-prev"> < </button>
			<button id="button-next"> > </button>
		</div>

		<script type="text/javascript">
			var oAd = document.getElementById('ad');	
			var imgs = ['img/ad1.jpg','img/ad2.jpg','img/ad3.jpg','img/ad4.jpg'];
			var num = 0;
			oAd.src = imgs[num];
			function autoPlay(){
				oAd.timer = setInterval(function(){
				num++;
				num %= imgs.length;
				oAd.src = imgs[num];
				},2000)
			}
			autoPlay();
			oAd.onmouseover = function(){
				clearInterval(oAd.timer);
			}
			oAd.onmouseout = autoPlay;

			var prev = document.getElementById('button-prev');
			var next = document.getElementById('button-next');
			prev.onclick = function(){
				clearInterval(oAd.timer);
				num--;
				if(num == -1) num = 3;
				oAd.src = imgs[num];
			}
			next.onclick = function(){
				clearInterval(oAd.timer);
				num++;
				num %= imgs.length;
				oAd.src = imgs[num];
			}
		</script>
	</div>
	<a id="gotop" href="#header">top</a>

	<div class="describe">
		<p>热销</p><span>正在热销中...</span>
	</div>
	<div class="nav">
		<div id="ranking">
			<ul>
				<c:forEach items="${topSells }" var="top">
				<li>
				<a href="getProductById?id=${top.id }">
					<img src="img/${top.productPic }">
					<div class="rankgoods">
						<p>${top.productName }</p>
						<span>销量：</span><strong>${top.sells }</strong>
					</div>
				</a>
				</li>
				</c:forEach>
			</ul>
		</div>
		<div class="recommend">
			<div class="module1">
				<div class="module1in module1inb">
					<a href="getProductById?id=41">
					<img src="img/product33.jpg">
					<div>
						<p>清扬男士洗发水 去屑洗发露清爽控油型750g</p>
						<span>￥</span><strong>55元</strong>
					</div>
					</a>
				</div>
				<div class="module1in">
					<a href="getProductById?id=40">
					<img src="img/product32.jpg">
					<div>
						<p>多芬洗发水 水润秘语滋养洗发乳 玫瑰补水 700ml</p>
						<span>￥</span><strong>50元</strong>
					</div>
					</a>
				</div>
			</div>
			<div class="module2">
				<a href="getProductById?id=39">
					<img src="img/product31.jpg">
					<div>
						<p>康师傅 大食袋香辣牛肉面 120g*5/袋</p>
						<span>￥</span><strong>13元</strong>
					</div>
				</a>
			</div>
			<div class="module1">
				<div class="module1in module1inb">
					<a href="getProductById?id=38">
					<img src="img/product30.jpg">
					<div>
						<p>康师傅 经典袋鲜虾鱼板面 92g*5/袋</p>
						<span>￥</span><strong>12元</strong>
					</div>
					</a>
				</div>
				<div class="module1in">
					<a href="getProductById?id=35">
					<img src="img/product27.jpg">
					<div>
						<p>恒顺香醋 B香型 500ml</p>
						<span>￥</span><strong>7元</strong>
					</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="describe">
		<p>热销</p><span>正在热销中...</span>
	</div>
	<div class="nav">
		<div class="leftcontain">
			<ul>
				<li><a href="#">苹果</a></li>
				<li><a href="#">苹果</a></li>
				<li><a href="#">苹果</a></li>
				<li><a href="#">苹果</a></li>
			</ul>
			<img src="img/act1.jpg">
		</div>
		<div class="recommend">
			<div class="module1">
				<div class="module1in module1inb">
					<a href="getProductById?id=34">
					<img src="img/product26.jpg">
					<div>
						<p>海天味极鲜酱油1280ml</p>
						<span>￥</span><strong>20元</strong>
					</div>
					</a>
				</div>
				<div class="module1in">
					<a href="getProductById?id=33">
					<img src="img/product25.jpg">
					<div>
						<p>十月稻田吉林小町米5kg</p>
						<span>￥</span><strong>30元</strong>
					</div>
					</a>
				</div>
			</div>
			<div class="module2">
				<a href="getProductById?id=32">
					<img src="img/product24.jpg">
					<div>
						<p>泰金香茉莉香米10kg</p>
						<span>￥</span><strong>60元</strong>
					</div>
				</a>
			</div>
			<div class="module1">
				<div class="module1in module1inb">
					<a href="getProductById?id=31">
					<img src="img/product23.jpg">
					<div>
						<p>金龙鱼 盘锦大米 蟹稻共生5kg</p>
						<span>￥</span><strong>30元</strong>
					</div>
					</a>
				</div>
				<div class="module1in">
					<a href="getProductById?id=30">
					<img src="img/product22.jpg">
					<div>
						<p>金龙鱼 黄金比例食用调和油5L/瓶</p>
						<span>￥</span><strong>60元</strong>
					</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="describe">
		<p>热销</p><span>正在热销中...</span>
	</div>
	<div class="nav">
		<div class="leftcontain">
			<ul>
				<li><a href="#">苹果</a></li>
				<li><a href="#">苹果</a></li>
				<li><a href="#">苹果</a></li>
				<li><a href="#">苹果</a></li>
			</ul>
			<img src="img/act2.jpg">
		</div>
		<div class="recommend">
			<div class="module1">
				<div class="module1in module1inb">
					<a href="getProductById?id=29">
					<img src="img/product21.jpg">
					<div>
						<p>菜子王 非转基因纯正压榨菜籽油食用油5L</p>
						<span>￥</span><strong>60元</strong>
					</div>
					</a>
				</div>
				<div class="module1in">
					<a href="getProductById?id=28">
					<img src="img/product20.jpg">
					<div>
						<p>鲁花5S一级花生油4L 物理压榨 食用油</p>
						<span>￥</span><strong>105元</strong>
					</div>
					</a>
				</div>
			</div>
			<div class="module2">
				<a href="getProductById?id=27">
					<img src="img/product19.jpg">
					<div>
						<p>可口可乐碳酸饮料可乐1250ml*6瓶</p>
						<span>￥</span><strong>30元</strong>
					</div>
				</a>
			</div>
			<div class="module1">
				<div class="module1in module1inb">
					<a href="getProductById?id=26">
					<img src="img/product18.jpg">
					<div>
						<p>百事可乐 碳酸汽水饮料整箱330ml*12</p>
						<span>￥</span><strong>25元</strong>
					</div>
					</a>
				</div>
				<div class="module1in">
					<a href="getProductById?id=25">
					<img src="img/product17.jpg">
					<div>
						<p>屈臣氏苏打汽水330ml*24罐</p>
						<span>￥</span><strong>90元</strong>
					</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	
		<script type="text/javascript">
				var aRecommend = document.getElementsByClassName('recommend');
				var aImg = [];
				for(var i=0 ; i<aRecommend.length; i++){
					var temp = aRecommend[i].getElementsByTagName('img');
					for(var j=0 ; j<temp.length ; j++){
						aImg.push(temp[j]);
					}
				}
				function shake(obj,dir,dis){
					var dirlong = parseInt(getComputedStyle(obj)[dir]);
					obj.style[dir] = dis + dirlong + 'px';
				}
				for(var i=0 ; i<aImg.length ; i++){
					aImg[i].onmouseover = function(){
						shake(this,'left',-10);
					}
					aImg[i].onmouseout = function(){
						shake(this,'left',10);
					}
				}
		</script>

	<div id="bottom">
		<p>我是有底线的~~</p>
		<hr>
		<p>网络141 陈明朗~</p>
	</div>
</body>
</html>