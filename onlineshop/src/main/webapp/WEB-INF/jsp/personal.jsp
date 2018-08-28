<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>个人中心</title>
	<base href="<%= basePath%>">
	<link rel="stylesheet" type="text/css" href="css/personal.css">
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
		<ul id="selection">
			<strong>全部功能</strong>
			<li><a href="mycart">我的购物车</a></li>
			<li><a href="myFavourite">我的收藏</a></li>
			<li><a href="myOrder">我的订单</a></li>
			<li><a href="forward?link=modifyPassword">修改密码</a></li>
			<li><a href="addressManage">收货地址</a></li>
		</ul>	
		
		<div id="operation">
			<c:if test="${favourites==null && orders==null}">
			<div class="recommend" style="display: none;">
				<c:if test="${favourite == null }">
				<strong>为你推荐</strong>
				<ul>
					<li>
						<a href="#"><img src="img/recommend2.jpg"></a>
						<a href="#">反反复复付付付付付付付付付付付付付付付付付付付付付付付付付</a>
						<span>￥300</span>
					</li>
					<li>
						<a href="#"><img src="img/recommend2.jpg"></a>
						<a href="#">反反复复付付付付付付付付付付付付付付付付付付付付付付付付付</a>
						<span>￥300</span>
					</li>
					<li>
						<a href="#"><img src="img/recommend2.jpg"></a>
						<a href="#">反反复复付付付付付付付付付付付付付付付付付付付付付付付付付</a>
						<span>￥300</span>
					</li>
					<li>
						<a href="#"><img src="img/recommend2.jpg"></a>
						<a href="#">反反复复付付付付付付付付付付付付付付付付付付付付付付付付付</a>
						<span>￥300</span>
					</li>
					<li>
						<a href="#"><img src="img/recommend2.jpg"></a>
						<a href="#">反反复复付付付付付付付付付付付付付付付付付付付付付付付付付</a>
						<span>￥300</span>
					</li>
					<li>
						<a href="#"><img src="img/recommend2.jpg"></a>
						<a href="#">反反复复付付付付付付付付付付付付付付付付付付付付付付付付付</a>
						<span>￥300</span>
					</li>
				</ul>
				</c:if>
<%-- 				<c:if test="${favourite != null }">
				<strong>我的收藏</strong>
				<ul>
					<c:forEach items="${favourites }" var="product">
					<li>
						<a href="getProductById?id=${product.id }"><img src="img/${product.productPic }"></a>
						<a href="getProductById?id=${product.id }">${product.productName }</a>
						<span>￥${productPrice }</span>
					</li>
					</c:forEach>
				</ul>
				</c:if> --%>
			</div>
			</c:if>
			<c:if test="${favourites != null }">
			<div class="recommend">
				<strong>我的收藏</strong>
				<ul>
					<c:forEach items="${favourites }" var="product">
					<li>
						<a href="getProductById?id=${product.id }"><img src="img/${product.productPic }"></a>
						<a href="getProductById?id=${product.id }">${product.productName }</a>
						<span>￥${product.productPrice }</span>
					</li>
					</c:forEach>
				</ul>
			</div>
			</c:if>
			<c:if test="${orderList != null}">
			<div id="orderblock">
				<strong>我的订单</strong>
				<div id="orderhead">
					<div id="introduction">商品信息</div>
					<div id="price">单价</div>
					<div id="count">数量</div>
					<div id="subtotal">小计</div>
					<div id="comment">评价</div>
					<div id="total">总价</div>
					<div id="status">交易状态</div>
				</div>
				<ul id="orderlist">
				<c:forEach items="${orderList }" var="order">
					<li class="order">
						<div class="orderinfo">
							<span>订单号：${order.orderNum }</span>
							<span>时间：<fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						</div>
						<ul class="items">
						<c:forEach items="${order.items }" var="item">
							<li>
								<div class="introduction"><a href="getProductById?id=${item.product.id }"><img src="img/${item.product.productPic }"></a><a href="getProductById?id=${item.product.id }">${item.product.productName }</a></div>
								<div class="price">￥${item.product.productPrice }元</div>
								<div class="count">${item.productCount }</div>
								<div class="subtotal">${item.subtotal }</div>
								<div class="comment">
									<c:if test="${item.commented == 0 }"><a href="javascript:;" productId="${item.product.id }" productName="${item.product.productName }" orderNum="${order.orderNum }" class="commentProduct">评价</a></c:if>
									<c:if test="${item.commented == 1 }">已评价</c:if>
								</div>
							</li>
						</c:forEach>
						</ul>
						<div class="totalcount">${order.total }</div>
						<div class="orderstatus">
							<c:if test="${order.orderStatus == '等待收货'}">
								<a href="confirmReceive?orderId=${order.id }">确认收货</a>
							</c:if>
							<c:if test="${order.orderStatus != '等待收货'}">
								${order.orderStatus }
							</c:if>
						</div>
						<div style="clear: both;"></div>
						<div class="shipping">配送地址：${order.address.address } 收件人：${order.address.receiver }   电话：${order.address.telphone }</div>
					</li>
				</c:forEach>
				</ul>
				<div id="flip">
					<ul></ul>
					<span></span>
					<input type="text" value="1">
					<span>页</span>
					<button>确定</button>
					<script type="text/javascript">
						var itemsNum = ${orderCount};
						var allPageNum = Math.ceil(itemsNum / 20);
						var nowPageNum = 1;

						$('#flip').children('span').eq(0).html('共'+allPageNum+'页，到');
						creatPage({
							obj : $('#flip').children('ul').eq(0),
							allPageNum : allPageNum ,
							nowPageNum : nowPageNum 
						});

						function creatPage(opt){
							if(!opt.obj) {return false;}
							var obj = opt.obj;
							var allPageNum = opt.allPageNum;
							var nowPageNum = opt.nowPageNum;

							//上一页
							var oLi = $('<li><a></a></li>');
							var oA = oLi.children('a').eq(0);
							oA.attr('href','#'+(nowPageNum-1));
							if(nowPageNum-1 == 0) oA.attr('href','#1');
							oA.html('上一页');
							obj.append(oLi);
							//中间页
							//总页数少于5
							if(allPageNum <= 5){
								for(var i=1 ; i<=allPageNum ; i++){
									var oLi = $('<li><a></a></li>');
									var oA = oLi.children('a').eq(0);
									oA.attr('href','#'+i);
									oA.html(i);
									obj.append(oLi);
								}
							}else{
								//当前页为1或2
								if(nowPageNum == 1 || nowPageNum == 2){
									for(var i=1 ; i<=5 ; i++){
										var oLi = $('<li><a></a></li>');
										var oA = oLi.children('a').eq(0);
										oA.attr('href','#'+i);
										oA.html(i);
										obj.append(oLi);
									}
								//当前页为末页或末页前一页
								}else if(allPageNum-nowPageNum == 0 || allPageNum-nowPageNum == 1){
									for(var i=allPageNum-4 ; i<=allPageNum ; i++){
										var oLi = $('<li><a></a></li>');
										var oA = oLi.children('a').eq(0);
										oA.attr('href','#'+i);
										oA.html(i);
										obj.append(oLi);
									}
								}else{
									for(var i=nowPageNum-2 ; i<=nowPageNum+2 ; i++){
										var oLi = $('<li><a></a></li>');
										var oA = oLi.children('a').eq(0);
										oA.attr('href','#'+i);
										oA.html(i);
										obj.append(oLi);
									}
								}
							}
							//下一页
							var oLi = $('<li><a></a></li>');
							var oA = oLi.children('a').eq(0);
							oA.attr('href','#'+(nowPageNum+1));
							if(nowPageNum+1 > allPageNum)  oA.attr('href','#'+allPageNum);
							oA.html('下一页');
							obj.append(oLi);

							var aA = obj.find('a');
							var pageA = document.getElementById('flip').getElementsByTagName('a');
							for(var i=1 ; i<pageA.length-1 ; i++){
								if(pageA[i].getAttribute('href').substring(1) == nowPageNum){
									pageA[i].className = 'nowpage';
								}
							}
							for(var i=0 ; i<aA.length ; i++){
								aA.eq(i).click(function(){
									nowPageNum = parseInt(this.getAttribute('href').substring(1));
									obj.html('');
									creatPage({
										obj : obj,
										allPageNum : allPageNum ,
										nowPageNum : nowPageNum 
									});
								});
							}
						}	
					</script>
				</div>
				<script type="text/javascript">
					var aItems = $('.items');
					var aTotalcount = $('.totalcount');
					var aOrderstatus = $('.orderstatus');
					for(var i=0 ; i<aItems.length ; i++){
						aTotalcount.eq(i).css('height', aItems.eq(i).css('height'));
						aOrderstatus.eq(i).css('height', aItems.eq(i).css('height'));
						aTotalcount.eq(i).css('line-height', aItems.eq(i).css('height'));
						aOrderstatus.eq(i).css('line-height', aItems.eq(i).css('height'));
					}
				</script>
			</div>
			</c:if>			
			
			<div id="commentbox" style="display: none;">
				<span id="closebox">x</span>
				<table>
					<input type="hidden" id="commentProductId">
					<input type="hidden" id="commentOrderNum">
					<tr><th>商品</th><td><span id="commentProductName"></span></td></tr>
					<tr><th>评价</th><td><textarea cols="40" rows="5" id="commentcontext"></textarea></td></tr>
					<tr><th></th><td><button id="submitcomment">提交</button></td></tr>
				</table>
				<script type="text/javascript">
					$('.commentProduct').each(function(){
						$(this).click(function(){
							$('#commentbox').css('display','block');
							$('#commentProductId').val($(this).attr('productId'));
							$('#commentOrderNum').val($(this).attr('orderNum'));
							$('#commentProductName').html($(this).attr('productName'));
						});
					});
					$('#closebox').click(function(){
						$('#commentbox').css('display','none');
					});
				
					$('#submitcomment').click(function(){
						$.ajax({
							url: "commentProduct",
							type: 'POST',
							async : false,
							dataType: 'text',
							contentType : 'application/json;charset=UTF-8',
							data: JSON.stringify({
								"commentContext" : $('#commentcontext').val(),
								"productId" : $('#commentProductId').val(),
								"orderNum" : $('#commentOrderNum').val()
							}),
							success : function(){
								window.location.href="myOrder"
							}
						})
					});
				</script>
			</div>
			
			<c:if test="${addressList != null }">
			<div id="addressblock">
				<strong>收货地址管理</strong> <br>
				<table>
					<tr><td><span style="color: #FFC70E;">新增收货地址</span></td></tr>
					<tr><td><span>收货地址</span></td><td><input id="newAddress" type="text" name="address"></td></tr>
					<tr><td><span>收货人姓名</span></td><td><input id="newReceiver" type="text" name="receiver"></td></tr>
					<tr><td><span>收货人手机</span></td><td><input id="newTelphone" type="text" name="telphone"></td></tr>
					<tr><td><input id="addressSubmit" type="submit" value="保存"></td></tr>
				</table>
				
				<script type="text/javascript">
					$('#addressSubmit').click(function(){
						$.ajax({
							type : 'post',
							url : "addAddress",
							dataType : 'text',
							async : false,
							contentType : 'application/json;charset=UTF-8',
							data : JSON.stringify({
								"address" : $('#newAddress').val(),
								"receiver" : $('#newReceiver').val(),
								"telphone" : $('#newTelphone').val()
							}),
							success : function(){
								window.location.href="addressManage";
							}
						});
					});
				</script>
				
				<ul id="addresslist">
					<li>
						<div class="name">收货人</div>
						<div class="telphone">收货人手机</div>
						<div class="address">收货地址</div>
						<div class="addressoperation">操作</div>
					</li>
					<c:forEach items="${addressList }" var="address">
					<li>
						<div class="name">${address.receiver }</div>
						<div class="telphone">${address.telphone }</div>
						<div class="address">${address.address }</div>
						<div class="addressoperation"><a href="javascript:;" class="deleteAddress" addressId="${address.id }">删除</a></div>
					</li>
					</c:forEach>
				</ul>
				
				<script type="text/javascript">
				$('.deleteAddress').each(function(){
					$(this).click(function(){
						$.ajax({
							type : 'post',
							url : "deleteAddress",
							dataType : 'text',
							async : false,
							contentType : 'application/json;charset=UTF-8',
							data : JSON.stringify({
								"addressId" : $(this).attr('addressId')
							}),
							success : function(){
								window.location.href="addressManage";
							}
						});
					});
				});
				</script>
				
			</div>
			</c:if>
			<c:if test="${modify!=null }">
			<div id="modifypassword">
				<strong>修改密码</strong>
				<form action=modifyPassword method="post">
				<table>
						<tr><td><span>输入新密码</span></td><td><input id="password1" type="password" name="password"></td></tr>
						<tr><td><span>重复输入新密码</span></td><td><input id="password2" type="password"><small id="repeatpassword"></small></td></tr>
						<tr><td><input id="submit" type="submit" value="确认"></td></tr>
				</table>
						<script type="text/javascript">
						$('#password2').change(function(){
							if($('#password1').val() != $('#password2').val()){
								$('#repeatpassword').html('两次密码不一样');
								$('#submit').attr('disabled',true);
							}else{
								$('#repeatpassword').html('');
								$('#submit').attr('disabled',false);
							}
						});
						</script>
				</form>
			</div>
			</c:if>
		</div>
	</div>
	<div style="clear: both;"></div>

	<div id="bottom">
		<p>我是有底线的~~</p>
		<hr>
		<p>网络141 陈明朗~</p>
	</div>
</body>
</html>