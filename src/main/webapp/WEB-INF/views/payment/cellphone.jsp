<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="../resources/css/cellphone.css">
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
		<table id="row1">
			<tr>
				<td style="width: 400px;">상품명</td>
				<td style="text-align: right;">(힐링독쇼핑)휴대폰결제</td>
			</tr>
			<tr>
				<td>결제일시</td>
				<td style="text-align: right;">2024. 07. 02</td>
			</tr>
			<tr>
				<td>결제금액</td>
				<td style="text-align: right;"><span
					style="text-align: right; font-size: xx-large;">1,000</span> 원</td>
			</tr>
		</table>
		<table>
			<tr>
				<td style="width: 202px;">가입통신사</td>
				<td style="width: 434px;"><input class="btn"
					style="width: 70px; height: 35px;" type="button" value="SKT"
					onclick="change_btn(this)"> <input class="btn"
					style="width: 70px; height: 35px;" type="button" value="KT"
					onclick="change_btn(this)"> <input class="btn"
					style="width: 70px; height: 35px;" type="button" value="LGU+"
					onclick="change_btn(this)"> <input class="btn"
					style="width: 70px; height: 35px;" type="button" value="알뜰폰"
					onclick="change_btn(this)"></td>
			</tr>
			<tr>
				<td>휴대폰번호</td>
				<td><input type="text" maxlength="11" id="cellphone"
					style="width: 250px; height: 20px;"></td>
			</tr>
			<tr>
				<td>주민번호 앞 7자리</td>
				<td><input type="text" maxlength="6" id="cellphone"
					style="width: 80px; height: 20px;">- <input type="text"
					maxlength="1" id="cellphone" style="width: 20px; height: 20px;">*******</td>
			</tr>
		</table>

		<table id="agree">
			<tr>
				<td class="agree_ck"
					style="font-size: 22px; border-top: 2px solid black;"><input
					type="checkbox" name="ag_ckbox" value="selectall"
					onclick="selectAll(this)"> 전체동의하기</td>
			</tr>
			<br>
			<tr>
				<td class="agree_ck" style="font-size: 15px; width: 650px;"><input
					type="checkbox" name="ag_ckbox" value="ck1"> 통신과금 서비스 이용약관
					<input type="checkbox" name="ag_ckbox" value="ck2"
					style="margin-left: 111px;"> 개인(신용)정보수집/이용동의 <br> <input
					type="checkbox" name="ag_ckbox" value="ck3">
					개인(신용)정보제공/조회/위탁 동의 <input type="checkbox" name="ag_ckbox"
					value="ck4" style="margin-left: 50px;"> SKT광고성 정보 수신동의(선택)
					<br> <input type="checkbox" name="ag_ckbox" value="ck5">
					마케팅을 위한 개인정보수집이용 동의 <input type="checkbox" name="ag_ckbox"
					value="ck6" style="margin-left: 31px;"> (광고)안심결제서비스 안내
					동의(선택) <br></td>
			</tr>
		</table>
		<br>
		<div style="margin-left: 250px;">
			<input type="button" value="결제승인"	onclick="location.href='completed.jsp'" style="height: 30px;">
			<input type="button" value="주문취소" onclick="close()" id="close"
				style="height: 30px;">
		</div>
		<br>

		<!--전체 동의 선택 js-->
		<script>
                function selectAll(selectAll)
                {
                    const checkboxes = document.getElementsByName('ag_ckbox');
                    checkboxes.forEach((checkbox) =>{
                        checkbox.checked = selectAll.checked
                    })
                }

            </script>
	</div>
</body>
</html>