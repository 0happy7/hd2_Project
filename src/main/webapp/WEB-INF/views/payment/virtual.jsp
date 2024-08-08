<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="../resources/css/virtual.css">
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
		<p>가상계좌(무통장입금)</p>
		<table>
			<tr>
				<td colspan="2"
					style="width: 600px; border: 1px solid gray; background-color: lightgray;">힐링독쇼핑몰</td>
			</tr>
			<tr>
				<td style="width: 150px;">상품명</td>
				<td>강아지사료</td>
			</tr>
			<tr>
				<td>상품금액</td>
				<td>10,000원</td>
			</tr>
			<tr>
				<td>입금계좌번호</td>
				<td>농협 1457556-1223479</td>
			</tr>
		</table>
		<br>
		<table>
			<tr>
				<td>은행</td>

				<td style="width: 500px; height: 50px;">
					<div style="margin-left: 30px;">
						<input class="bank_ck" type="radio" name="bank_ck" value="농협">
						농협 <input class="bank_ck" type="radio" name="bank_ck" value="국민">
						국민 <input class="bank_ck" type="radio" name="bank_ck" value="우리">
						우리 <input class="bank_ck" type="radio" name="bank_ck" value="신한">
						신한 <br> <input class="bank_ck" type="radio" name="bank_ck"
							value="기업"> 기업 <input class="bank_ck" type="radio"
							name="bank_ck" value="전북"> 전북 <input class="bank_ck"
							type="radio" name="bank_ck" value="신협"> 신협 <input
							class="bank_ck" type="radio" name="bank_ck" value="수협">
						수협
					</div>
				</td>
			</tr>

			<tr>
				<td>입금자명</td>
				<td><input type="text" style="height: 20px; margin-left: 30px;">
				</td>
			</tr>
			<tr>
				<td>입금기한</td>
				<td><div style="margin-left: 30px;">2024/07/03</div></td>
			</tr>
		</table>
		<br> <input type="checkbox" name="agree_ck" value="agree_ck">
		상기 구매 내역에 동의합니다. <br>
		<br>
		<div style="margin-left: 230px;">
			<input type="button" value="결제승인"	onclick="location.href='completed.jsp'" style="height: 30px;">
			<input type="button" value="주문취소" onclick="close()" id="close"
				style="height: 30px;">
		</div>
	</div>
</body>
</html>