<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../include/head.jsp" flush="true"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="resources/css/title.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/completed.css">
<body>
	<script>
	$(document).ready(function() {
        $("#order_page").click(function()
        {
        	document.location = "user_orderpage.do?orderno=" + ${order.orderno};		
        });
        
        $("#shop_page").click(function() {
        	document.location = "shop_food.do";
        });
        		
	});

        
	</script>
	<!-- 스크립트 부분 끝 -->
    <!-- 컨텐츠 시작 부분 -->
    <div id="head">주문 완료</div>

		<!-- 주문완료 테이블 -->
		<table>
			<tr>
				<td style="width: 0px; border-top: 1px solid darkgray;"></td>
				<td id="row2">힐링독을 이용해 주셔서 감사합니다.</td>
				<td style="width: 0px; border-top: 1px solid darkgray;"></td>
			</tr>

			<tr>
				<td style="width: 0px;"></td>
				<td id="row3">
					<div>
						고객님,&nbsp; <span>주문이 완료</span>되었습니다.
					</div>
				</td>
				<td style="width: 0px;"></td>
			</tr>

			<tr>
				<td style="width: 0px;"></td>
				<td id="row4">고객님이 주문하신 주문번호는<br> <span>${order.ordernum}</span>입니다.
				</td>
				<td style="width: 0px;"></td>
			</tr>

			<tr>
				<td style="width: 0px; border-bottom: 1px solid darkgray;"></td>
				<td id="row5">주문내역 확인은 배송/마이페이지의<br> '주문/배송조회'에서 하실 수
					있습니다.
				</td>
				<td style="width: 0px; border-bottom: 1px solid darkgray;"></td>
			</tr>

			<tr>
				<td style="width: 100px; height: 50px; text-align:center;" colspan="3" >
					<button id="order_page">주문상세보기</button>
					<button id="shop_page">쇼핑계속하기</button>
				</td>
			</tr>
		</table>

<jsp:include page="../include/tail.jsp" flush="true"/>