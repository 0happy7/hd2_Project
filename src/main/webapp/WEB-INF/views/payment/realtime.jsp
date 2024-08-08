<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="../resources/css/realtime.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#close').click(function(close) {
				window.close();
			})
		});
		
		
	</script>
</head>
<body>
	<div id="container">
		<p>계좌이체</p>
		<table style="float: left;">
			<tr>
				<td style="background-color: lightsteelblue; width: 150px;">
					이용기관명</td>

			</tr>
			<tr>
				<td style="background-color: lightsteelblue;">금 액</td>
			</tr>
		</table>

		<table>
			<tr>
				<td style="width: 300px;">힐링독쇼핑몰</td>
			</tr>
			<tr>
				<td>10,000원</td>
			</tr>
		</table>
		<br>
		<table style="float: left";>
			<tr>
				<td style="width: 150px;">은행</td>
			</tr>
			<tr>
				<td>계좌번호</td>
			</tr>
			<tr>
				<td>비밀번호</td>
			</tr>
			<tr>
				<td>주민번호</td>
			</tr>
		</table>

		<select name="card_Name" id="card_Kind"
			style="border: 1px solid gray; width: 310px; height: 42px; font-size: 18px;">
			<option value="c1">삼성카드</option>
			<option value="c2">NH농협카드</option>
			<option value="c3">하나카드</option>
			<option value="c4">신한카드</option>
			<option value="c5">KB국민카드</option>
			<option value="c5">현대카드</option>
			<option value="c5">롯데카드</option>
			<option value="c5">BC카드</option>
		</select> <br>
		<form>
			<input class="num" type="text"> <br> <input class="num"
				type="text"> <br> <input class="num" type="text">
			<br> <br>
			<div style="margin-left: 180px;">
				<input type="button" value="결제승인"	onclick="location.href='completed.jsp'" style="height: 30px;">
				<input type="button" value="주문취소" onclick="close()" id="close"
					style="height: 30px;">
			</div>
		</form>
	</div>


</body>
</body>
</html>