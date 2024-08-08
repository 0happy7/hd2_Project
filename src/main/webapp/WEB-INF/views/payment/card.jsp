<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/card.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		$('#close').click(function(close) {
			window.close();
		})
	});
	
	$(document).ready(function() {
        $('#complted').click(function(complted) {
            window.open('completed.jsp', '승인완료', 'width=850px,height=550px,scrollbars=yes,top=200px,left=500px');
        })
    });
</script>
</head>
<body>
	<!-- 컨테이너 -->
	<div id="container">
		<table>
			<tr style="background-color: lightgray;">
				<td style="text-align: center; width: 700px; height: 10px;">신용카드
					인증</td>
			</tr>
			<tr style="background-color: lightgray;">
				<td>
					<table align="center">
						<tr>
							<td style="width: 700px;">(주) 힐링독쇼핑몰</td>
						</tr>
					</table> <br>
					<table align="center">
						<tr>
							<td style="width: 700px; border-bottom: 1px solid darkgray;">신용카드
								직접 입력</td>
						</tr>
						<tr>
							<td style="width: 700px;">카드번호 <input type="text"
								style="width: 100px; height: 25px; margin-left: 45px;">
								<input type="text" style="width: 100px; height: 25px;">
								<input type="text" style="width: 100px; height: 25px;">
								<input type="text" style="width: 100px; height: 25px;">
							</td>
						</tr>
						<tr>
							<td style="width: 700px;">유효기간 <select name="month"
								id="month"
								style="width: 100px; height: 30px; margin-left: 45px;">
									<option value="1월">1월</option>
									<option value="2월">2월</option>
									<option value="3월">3월</option>
									<option value="4월">4월</option>
									<option value="5월">5월</option>
									<option value="6월">6월</option>
									<option value="7월">7월</option>
									<option value="8월">8월</option>
									<option value="9월">9월</option>
									<option value="10">10월</option>
									<option value="11">11월</option>
									<option value="12">12월</option>
							</select> <select name="year" id="2020년year"
								style="width: 100px; height: 30px;">
									<option value="2020년">2020년</option>
									<option value="2021년">2021년</option>
									<option value="2022년">2022년</option>
									<option value="2023년">2023년</option>
									<option value="2024년">2024년</option>
									<option value="2025년">2025년</option>
									<option value="2026년">2026년</option>
									<option value="2027년">2027년</option>
									<option value="2028년">2028년</option>
									<option value="2029년">2029년</option>
									<option value="2030년">2030년</option>
									<option value="2031년">2031년</option>
							</select>
							</td>
						</tr>
						<tr>
							<td style="width: 700px;">CVC <input type="text"
								style="width: 100px; height: 25px; margin-left: 90px;">
							</td>
						</tr>
						<tr>
							<td style="width: 700px;">주민등록번호 <input type="text"
								style="width: 100px; height: 25px;"> <input type="text"
								style="width: 200px; height: 25px;">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<form>
			<div style="align-items: center; margin-left: 25%;">
				<input type="button" value="결제승인" onclick="location.href='completed.jsp'" style="height: 30px;">
				<input type="button" value="주문취소" onclick="close()" id="close"
					style="height: 30px;">
			</div>
		</form>
	</div>
</body>
</html>