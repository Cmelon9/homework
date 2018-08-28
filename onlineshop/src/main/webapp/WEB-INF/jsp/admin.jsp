<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>腾扬超市 - 管理中心</title>
	<base href="<%= basePath%>">
	<link rel="stylesheet" type="text/css" href="css/admin.css">
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
							window.location.href="forward?link=admin"
						}
					})
				});
			}
		}
		</script>
	
		<ul id="selection">
			<strong>全部功能</strong>
			<li><a href="getOrders">订单管理</a></li>
			<li><a href="getProducts">商品管理</a></li>
			<li><a href="getUsers">用户管理</a></li>
		</ul>
		<div id="operation">
			<c:if test="${orderList != null }">
			<div id="orderblock">
				<strong>全部订单</strong>
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
								<div class="introduction"><a href="getProductById?id=${item.product.id }"><img src="img/${item.product.productPic }"></a><a href="#">${item.product.productName }</a></div>
								<div class="price">￥${item.product.productPrice }元</div>
								<div class="count">${item.productCount }</div>
								<div class="subtotal">${item.subtotal }</div>
								<div class="comment"><a href="getProductById?id=${item.product.id }">查看评价</a></div>
							</li>
						</c:forEach>
						</ul>
						<div class="totalcount">${order.total }</div>
						<div class="orderstatus">
							<c:if test="${order.orderStatus == '待发货'}">
								<a href="deliver?orderId=${order.id }">发货</a>
							</c:if>
							<c:if test="${order.orderStatus != '待发货'}">
								${order.orderStatus }
							</c:if>
						</div>
						<div style="clear: both;"></div>
						<div class="shipping">配送地址：${order.address.address } 收件人：${order.address.receiver }   电话：${order.address.telphone }</div>
					</li>
				</c:forEach>
				</ul>
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
				<div id="flip">
					<ul></ul>
					<span></span>
					<input type="text" value="1">
					<span>页</span>
					<input class="submit" type="submit" value="确定" style="width: 50px;">
					<script type="text/javascript">
						var count = '${ orderCount}';
						var nowPageNum = '${ nowPageNum}';
						$('#flip').children('span').eq(0).html('共'+Math.ceil( count / 2)+'页，到');
						creatPage({
							obj : $('#flip').children('ul').eq(0),
							objId: 'flip',
							allPageNum : Math.ceil(count / 2) ,
							nowPageNum : Number(nowPageNum) ,
							requestMapping : "getOrders"
						});
					</script>
				</div>
				</div>
			</c:if>
			<c:if test="${ productList != null}">
			<div id="itemsblock">
				<div id="banner">
					<ul id="showguide">
						<li><p><a href="#" style="color: white;">全部分类</a></p>
							<ul>
								<li>进口商品</li>
								<li>食品饮料</li>
								<li>粮油副食</li>
								<li>美容洗护</li>
								<li>家居家电</li>
								<li>家庭清洁</li>
								<li>母婴用品</li>
								<li>生鲜水果</li>
							</ul>
						</li>
						<li><a id="addProductButton" href="javascript:;">上架商品</a></li>
					</ul>
					<script type="text/javascript">
						var showguide = $('#showguide').find('li').eq(0);
						var guide = $('#showguide').find('ul').eq(0);
						showguide.mouseenter(function(){
							guide.fadeIn('slow');
						});
						showguide.mouseleave(function(){
							guide.fadeOut('slow');
						});
						$('#addProductButton').click(function(){
							$('#itemsmap').css('display','none');
							$('#addgoods').css('display','block');
							$('#flip1').css('display','none');
						});
						function editProduct(productId){
							$.ajax({
								url: 'editProductBefore',
			 					type: 'POST',
			 					async : false,
			 					dataType: 'text',
			 					contentType : 'application/json;charset=UTF-8',
			 					data: JSON.stringify({
									"productId" : productId
			 					}),
			 					success : function(data){
			 						$('#itemsmap').css('display','none');
									$('#editProduct').css('display','block');
									$('#flip1').css('display','none');
									var json = JSON.parse(data);
									var productId = json.product.id;
									var productPic = json.product.productPic;
									var productName = json.product.productName;
									var productCategory = json.product.productCategory;
									var productPrice = json.product.productPrice;
									var buyingPrice = json.product.buyingPrice;
									/* $('#editProductPic').val(productPic); */
									$('#editProductId').val(productId);
									$('#editProductName').val(productName);
									$('#editProductCategory').val(productCategory);
									$('#editProductPrice').val(productPrice);
									$('#editBuyingPrice').val(buyingPrice);
			 					}
							})
						}
					</script>
				</div>
				<div id="itemsmap">
					<ul id="itemslist">
						<div id="goodsinfo">商品信息</div>
						<div id="goodsprice">商品价格</div>
						<div id="volume">总销量</div>
						<div id="profit">利润</div>
						<div id="operate">操作</div>
						<div style="clear: both;"></div>
						<c:forEach items="${productList }" var="product">
						<li>
							<div class="goodsinfo"><a href="getProductById?id=${product.id }"><img src="img/${product.productPic }"></a><a href="getProductById?id=${product.id }">${product.productName }</a></div>
							<div class="goodsprice">${product.productPrice }</div>
							<div class="volume">${product.sells }</div>
							<div class="profit">${product.profit }</div>
							<div class="operate"><a href="javascript:;" onclick="editProduct(${product.id })">编辑</a>|<a href="deleteProduct?id=${product.id }">删除</a></div>
						</li>
						</c:forEach>
					</ul>
				</div>
				<div id="flip1" style="">
					<ul></ul>
					<span></span>
					<input type="text" value="1">
					<span>页</span>
					<input class="submit" type="submit" value="确定" style="width: 50px;">
				
					<script type="text/javascript">
						count = '${productCount}';
						nowPageNum = '${ nowPageNum}';
						$('#flip1').children('span').eq(0).html('共'+Math.ceil(count / 5)+'页，到');
							creatPage({
								obj : $('#flip1').children('ul').eq(0),
								objId: 'flip1',
								allPageNum : Math.ceil(count / 5) ,
								nowPageNum : Number(nowPageNum),
								requestMapping : "getProducts"
							});
					</script>		
				</div>
				<div id="addgoods" style="display:none;">
					<form action="addProduct" method="post" enctype="multipart/form-data">
					<table>
						<tr><td>商品图片</td><td><input type="file" name="productPic1"></td></tr>
						<tr><td>商品名称</td><td><input type="text" name="productName"></td></tr>
						<tr><td>商品分类</td><td><select name="productCategory">
													<option value="1">进口商品</option>
													<option value="2">食品饮料</option>
													<option value="3">粮油副食</option>
													<option value="4">美容洗护</option>
													<option value="5">家居家电</option>
													<option value="6">家庭清洁</option>
													<option value="7">母婴用品</option>
													<option value="8">生鲜水果</option>
												 </select></td></tr>
						<tr><td>商品单价</td><td><input type="text" name="productPrice"></td></tr>
						<tr><td>进货价</td><td><input type="text" name="buyingPrice"></td></tr>
						<tr><td><input type="submit" value="确定"></td></tr>
					</table>
					</form>
				</div>
				<div id="editProduct" style="display:none;">
					<form action="editProduct" method="post" enctype="multipart/form-data">
					<input type="hidden" name="editProductId" id="editProductId">
					<table>
						<tr><td>商品图片</td><td><input type="file" id="editProductPic" name="productPic1"></td></tr>
						<tr><td>商品名称</td><td><input type="text" id="editProductName" name="productName"></td></tr>
						<tr><td>商品分类</td><td><select id="editProductCategory" name="productCategory">
													<option value="1">进口商品</option>
													<option value="2">食品饮料</option>
													<option value="3">粮油副食</option>
													<option value="4">美容洗护</option>
													<option value="5">家居家电</option>
													<option value="6">家庭清洁</option>
													<option value="7">母婴用品</option>
													<option value="8">生鲜水果</option>
												 </select></td></tr>
						<tr><td>商品单价</td><td><input type="text" id="editProductPrice" name="productPrice"></td></tr>
						<tr><td>进货价</td><td><input type="text" id="editBuyingPrice" name="buyingPrice"></td></tr>
						<tr><td><input type="submit" value="确定"></td></tr>
					</table>
					</form>
				</div>
			</div>
			</c:if>
			<c:if test="${userList != null }">
			<div id="userblock">
				<strong>全部用户</strong>
				<ul id="userlist">
					<div id="username">用户名</div>
					<div id="password">密码</div>
					<div id="telphone">手机号</div>
					<div id="useroperate">操作</div>
					<div style="clear: both;"></div>
					<c:forEach items="${userList }" var="user">
					<li>
						<div class="username">${user.username }</div>
						<div class="password">${user.password }</div>
						<div class="telphone">${user.telphone }</div>
						<div class="useroperate"><a href="deleteUser?userId=${user.id }">删除</a></div>
					</li>
					</c:forEach>
				</ul>
				<div id="flip2">
					<ul></ul>
					<span></span>
					<input type="text" value="1">
					<span>页</span>
					<input class="submit" type="submit" value="确定" style="width: 50px;">
				
					<script type="text/javascript">
						count = '${userCount}';
						nowPageNum = '${nowPageNum}';
						$('#flip2').children('span').eq(0).html('共'+Math.ceil(count / 5)+'页，到');
							creatPage({
								obj : $('#flip2').children('ul').eq(0),
								objId: 'flip2',
								allPageNum : Math.ceil(count / 5) ,
								nowPageNum : Number(nowPageNum), 
								requestMapping : "getUsers"
							});
					</script>		
				</div>
			</div>
			</c:if>
		</div>
	</div>
</body>
</html>