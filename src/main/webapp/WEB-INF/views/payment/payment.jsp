<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
		
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/payment.css">
<link href="resources/css/title.css" type="text/css" rel="stylesheet">
<style>
    .custom-delivery {
        display: none;
    }
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
let def = "N"; // 기본배송지 여부
// 팝업 창
$(document).ready(function() {
    // 주소 찾기
    document.getElementById("find_add_button").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("addr").value = data.address; // 주소 넣기
                
            }
        }).open();
    });
    
    document.getElementById("find_add_button2").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address").value = data.address; // 주소 넣기
                
            }
        }).open();
    });
    
    if( $("input[name='chk_delivery']:checked").val() == "직접입력"){
    	toggleDeliveryInfo('direct');
    }
    
    // 배송지 저장
	$("#addr_save").click(function(){
    	if( $("#dname").val() == "")
		{
			alert("배송지 입력을 확인해주세요.");
			$("#dname").focus();
			return;
		}
		if( $("#addrname").val() == "")
		{
			alert("배송지 입력을 확인해주세요.");
			$("#addrname").focus();
			return;
		}
		if( $("#addrtel").val() == "")
		{
			alert("배송지 입력을 확인해주세요.");
			$("#addrtel").focus();
			return;
		}
		if( $("#addr").val() == "")
		{
			alert("배송지 입력을 확인해주세요.");
			$("#addr").focus();
			return;
		}
		if( $("#addrdetail").val() == "")
		{
			alert("배송지 입력을 확인해주세요.");
			$("#addrdetail").focus();
			return;
		}
		if(confirm("기본 배송지로 설정하시겠습니까?")){
			def = "Y";
		}
		if(confirm("배송지를 등록하시겠습니까?")){
			addrsave();
		}
	});
    
    $("#payBtn").click(function() {
        // 모든 체크박스가 체크되어 있는지 확인
        var checkboxes = $("input[name='ag_ckbox']");
        var allChecked = true;

        checkboxes.each(function() {
            if (!$(this).is(":checked")) {
                allChecked = false;
                return false; // 반복문을 종료
            }
        });

        // 모든 체크박스가 체크되어 있으면 결제 진행
        if (allChecked) {
			var selectedOption = $("input[name='chk_delivery']:checked").val();
            if (selectedOption === "기존배송지") {
            	if( $("#recipientName").val() == "")
        		{
        			alert("배송지 입력을 확인해주세요.");
        			$("#recipientName").focus();
        			return;
        		}
        		if( $("#recipientPhone").val() == "")
        		{
        			alert("배송지 입력을 확인해주세요.");
        			$("#recipientPhone").focus();
        			return;
        		}
        		if( $("#address").val() == "")
        		{
        			alert("배송지 입력을 확인해주세요.");
        			$("#address").focus();
        			return;
        		}
        		if( $("#addressDetail").val() == "")
        		{
        			alert("배송지 입력을 확인해주세요.");
        			$("#addressDetail").focus();
        			return;
        		}
            } else if (selectedOption === "직접입력") {
        		if( $("#addrname").val() == "")
        		{
        			alert("배송지 입력을 확인해주세요.");
        			$("#addrname").focus();
        			return;
        		}
        		if( $("#addrtel").val() == "")
        		{
        			alert("배송지 입력을 확인해주세요.");
        			$("#addrtel").focus();
        			return;
        		}
        		if( $("#addr").val() == "")
        		{
        			alert("배송지 입력을 확인해주세요.");
        			$("#addr").focus();
        			return;
        		}
        		if( $("#addrdetail").val() == "")
        		{
        			alert("배송지 입력을 확인해주세요.");
        			$("#addrdetail").focus();
        			return;
        		}
            }
            if (confirm("결제 하시겠습니까?")) {
                iamport(); // 결제 함수 호출
            }
        } else {
            alert("모든 약관에 동의해야 결제가 가능합니다.");
        }
    });
});

function addrsave() {
    var reqValue;
    var deliverySelect = document.getElementById("delivery2");
    
    if (deliverySelect.value === "custom") {
        reqValue = document.getElementById("customInput2").value;
    } else {
        reqValue = deliverySelect.options[deliverySelect.selectedIndex].text;
    }

    $.ajax({
        url: "addrsave.do",
        type: "post",
        data: {
            dname: $("#dname").val(),
            addrname: $("#addrname").val(),
            addrtel: $("#addrtel").val(),
            addr: $("#addr").val(),
            addrdetail: $("#addrdetail").val(),
            req: reqValue,
            def: def
        },
        dataType: "html",
        success: function(response) {
            response = response.trim();
            if (response == "false") {
                alert("배송지 등록 실패");
            }else{
            	alert("배송지를 저장하였습니다.");
            	location.reload();
            }
        }
    });
}


// 배송지 입력 방식
function toggleDeliveryInfo(option) {
    const existingForm = document.getElementById('existingDeliveryForm');
    const directForm = document.getElementById('directDeliveryForm');

    if (option === 'existing') {
        existingForm.style.display = 'block';
        directForm.style.display = 'none';
    } else if (option === 'direct') {
        existingForm.style.display = 'none';
        directForm.style.display = 'block';
    }
}

// 배송요청사항 직접입력시
function toggleDeliveryInput(formId) {
    const formElement = document.getElementById(formId);
    if (!formElement) {
        console.error(`Form element with id '${formId}' not found.`);
        return;
    }

    const deliverySelect = formElement.querySelector('select[name=delivery_name]');
    const customInput = formElement.querySelector('input[name=custom_delivery]');

    if (!deliverySelect || !customInput) {
        console.error(`Delivery select or custom input not found inside form with id '${formId}'.`);
        return;
    }

    if (deliverySelect.value === 'custom') {
        customInput.style.display = 'inline-block';
    } else {
        customInput.style.display = 'none';
    }
}

// 배송지 선택했을때
document.addEventListener("DOMContentLoaded", function() {
    // 페이지 로드 시 기본 선택된 주소 정보를 설정
    updateAddressFields();
});

function updateAddressFields() {
    var placeSelect = document.getElementById("place");
    var selectedOption = placeSelect.options[placeSelect.selectedIndex];

    // 선택된 옵션의 데이터 속성 값을 가져옴
    var rawPhone = selectedOption.getAttribute("data-addrtel");
    var cleanedPhone = rawPhone ? rawPhone.replace(/-/g, '') : '';  // '-' 제거

    // 입력 필드에 값 설정
    document.getElementById("recipientName").value = selectedOption.getAttribute("data-addrname");
    document.getElementById("recipientPhone").value = cleanedPhone;
    document.getElementById("address").value = selectedOption.getAttribute("data-addr");
    document.getElementById("addressDetail").value = selectedOption.getAttribute("data-addrdetail");
}

//결제 
function iamport(){
	//가맹점 식별코드
	IMP.init('imp58821308');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'healingDog_' + new Date().getTime(),
	    name : '${ itemvo.iname }' , //결제창에서 보여질 이름
	    amount : 100, //실제 결제되는 가격 ${ tprice }
	    buyer_email : '${login.email}',
	    buyer_name : '${login.uname}'
	}, function(rsp) {
		console.log(rsp);
		$.ajax({
        	type : "POST",
        	url : "verifyIamport/" + rsp.imp_uid 
        }).done(function(data) {
        	
        	console.log(data);
        	
        	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
        	
        	if(rsp.paid_amount == data.response.amount){
    	    	var msg = '결제가 완료되었습니다.';
    	        msg += '고유ID : ' + rsp.imp_uid;
    	        msg += '상점 거래ID : ' + rsp.merchant_uid;
    	        msg += '결제 금액 : ' + rsp.paid_amount;
    	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        	alert(msg);
	        	order_write(rsp.merchant_uid, rsp.pay_method, rsp.card_name, rsp.quota);
        	} else {
	   	    	 var msg = '결제에 실패하였습니다.';
		         msg += '에러내용 : ' + rsp.error_msg;
        		alert(msg);
        	}
        	
        });
	});
}
// 주문정보 등록
function order_write(ordernum, payment, cardcom, installment ){
    var selectedOption = $("input[name='chk_delivery']:checked").val();
    var oaddrname;
    var oaddrtel;
    var oaddr;
    var oaddrdetail;
    var oreq; // 배송 요청 사항
    var reqValue;
    if (selectedOption === "기존배송지") {
    	var deliverySelect = document.getElementById("delivery1");
        if (deliverySelect.value === "custom") {
            reqValue = document.getElementById("customInput1").value;
        } else {
            reqValue = deliverySelect.options[deliverySelect.selectedIndex].text;
        }
    	
        var selectedAddress = $("#place option:selected");
        oaddrname = selectedAddress.data('addrname');
        oaddrtel = selectedAddress.data('addrtel');
        oaddr = selectedAddress.data('addr');
        oaddrdetail = selectedAddress.data('addrdetail');
        oreq = reqValue;
    } else if (selectedOption === "직접입력") {
        var deliverySelect = document.getElementById("delivery2");
        
        if (deliverySelect.value === "custom") {
            reqValue = document.getElementById("customInput2").value;
        } else {
            reqValue = deliverySelect.options[deliverySelect.selectedIndex].text;
        }
    	
        oaddrname = $("#addrname").val();
        oaddrtel = $("#addrtel").val();
        oaddr = $("#addr").val();
        oaddrdetail = $("#addrdetail").val();
        oreq = reqValue;
    }
	
	 $.ajax({
	        url: "order_write.do",
	        type: "post",
	        data: {
	        	ordernum: ordernum,
				<c:if test="${ login != null}">
				ouserno : ${login.userno},
				</c:if>
	        	oitemno: ${ itemvo.itemno },
	        	tprice: ${tprice},
	        	oitemcnt: ${oitemcnt},
	        	oaddrname: oaddrname,
	        	oaddrtel: oaddrtel,
	        	oaddr: oaddr,
	        	oaddrdetail: oaddrdetail,
	        	oreq: oreq,
				payment: payment,
				cardcom: cardcom,
				installment: installment
	        },
	        dataType: "html",
	        success: function(response) {
	            response = response.trim();
	            if (response == "false") {
	                alert("주문정보 등록 실패");
	            }else{
	            	alert("주문정보를 저장하였습니다.");
	            	document.location = "completed.do?orderno=" + response;	
	            }
	        }
	    });
}

function addr_error() {
    alert("배송지를 등록해주세요");
    
    // 라디오 버튼들을 가져옵니다.
    var radioButtons = document.getElementsByName("chk_delivery");
    
    // '기존배송지' 라디오 버튼의 체크를 해제합니다.
    for (var i = 0; i < radioButtons.length; i++) {
        if (radioButtons[i].value === "기존배송지") {
            radioButtons[i].checked = false;
        }
    }
    
    // '직접입력' 라디오 버튼을 체크 상태로 유지합니다.
    for (var i = 0; i < radioButtons.length; i++) {
        if (radioButtons[i].value === "직접입력") {
            radioButtons[i].checked = true;
            // '직접입력' 관련된 추가 로직이 필요한 경우 호출합니다.
            toggleDeliveryInfo('direct');
        }
    }
}
/*
function pay_write(payment, cardcom, installment){
	console.log(porderno);
	console.log(payment);
	console.log(cardcom);
	console.log(installment);
	
	$.ajax({
	        url: "pay_write.do",
	        type: "post",
	        data: {
				<c:if test="${ login != null}">
				puserno : ${login.userno},
				</c:if>
				payment: payment,
				payprice: ${tprice},
				cardcom: cardcom,
				installment: installment
	        },
	        dataType: "html",
	        success: function(response) {
	            response = response.trim();
	            if (response == "false") {
	                alert("결제정보 등록 실패");
	            }else{
	            	alert("결제정보를 저장하였습니다.");
	            }
	        }
	    });
	
}
*/
function validatePhoneNumber(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
}
</script>
<!-- 헤더 부분  끝-->
<div id="container" class="container">
	<p style="text-align: right;">01 주문/결제 > 02 주문 완료 </p>
	
	<span style="font-size: 32px;font-weight: bolder;">배송지 정보</span>
	<span style="font-size: 20px; font-weight: bolder; margin-left: 200px;">
		<c:if test="${ addrlist == '[]' }">
			<input type="radio" name="chk_delivery" value="기존배송지" onclick="addr_error()"> 기존배송지
			<input type="radio" name="chk_delivery" checked value="직접입력" onclick="toggleDeliveryInfo('direct')"> 직접입력
		</c:if>
		<c:if test="${ addrlist != '[]' }">
			<input type="radio" name="chk_delivery" checked value="기존배송지" onclick="toggleDeliveryInfo('existing')"> 기존배송지
			<input type="radio" name="chk_delivery" value="직접입력" onclick="toggleDeliveryInfo('direct')"> 직접입력
		</c:if>
	</span>
	
		<form id="existingDeliveryForm" style="display: block;" class="existingInfo">
			<!-- 기존배송지 정보 -->
			<table id="existingInfo">
			    <tr>
				    <td class="info">
				        배송지 선택
				        <select name="place_name" id="place" onchange="updateAddressFields()">
				            <c:forEach var="addrlist" items="${addrlist}">
				                <option value="${addrlist.addrno}"
				                        data-dname="${addrlist.dname}"
				                        data-addrname="${addrlist.addrname}"
				                        data-addrtel="${addrlist.addrtel}"
				                        data-addr="${addrlist.addr}"
				                        data-addrdetail="${addrlist.addrdetail}"
				                        ${addrlist.def == 'Y' ? 'selected' : ''}>
				                    ${addrlist.dname}
				                </option>
				            </c:forEach>
				        </select>
				    </td>
				</tr>
				<tr>
				    <td class="info">
				        받는 사람
				        <input type="text" id="recipientName" style="width: 300px; height: 30px; margin-left: 30px;">
				    </td>
				</tr>
				<tr>
				    <td class="info">
				        휴대폰 번호
				        <input type="tel" id="recipientPhone" maxlength="11" oninput="validatePhoneNumber(this)" style="width: 300px; height: 30px; margin-left: 10px;">
				    </td>
				</tr>
				<tr>
				    <td class="info">
				        배송지 주소
				        <input type="button" id="find_add_button2" value="주소찾기" style="width: 70px; height: 35px;">
				        <input type="text" id="address" readonly style="width: 450px; height: 30px; margin-left: 10px;">
				        <input type="text" id="addressDetail" style="width: 540px; height: 30px; margin: 10px 0px 10px 110px;" placeholder="상세 주소 입력해주세요.">
				    </td>
				</tr>
				<tr>
			    	<td class="info">
				        배송 요청 사항
				        <select name="delivery_name" id="delivery1" onchange="toggleDeliveryInput('existingDeliveryForm')">
				            <option value="d1">부재시 핸드폰으로 연락주세요.</option>
				            <option value="d2">부재시 경비실에 맡겨주세요.</option>
				            <option value="d3">배송전에 연락주세요.</option>
				            <option value="d4">택배보관함에 보관해주세요.</option>
				            <option value="d5">부재시 집앞에 놔주세요.</option>
				            <option value="custom">직접 입력</option>
				        </select>
				        <input type="text" id="customInput1" name="custom_delivery" style="width: 400px; height: 40px; margin-left: 151px; display: none;" placeholder="직접 입력하세요">
			   		</td>
			   </tr>
			
			</table>
		</form>
	
	<form id="directDeliveryForm" style="display: none;" class="directInfo">
		<!-- 직접입력 배송지 정보 -->
		<table id="directInfo">
		    <tr>
		        <td class="info">
		            배송지명
		            <input id="dname" name="dname" style="width: 300px; height: 40px; margin-left: 35px;" placeholder="배송지명 입력">
		    	</td>
			</tr>
			<tr>
			    <td class="info">
			        받는 사람
			        <input type="text" id="addrname" name="addrname" style="width: 300px; height: 30px; margin-left: 30px;">
			    </td>
			</tr>
			<tr>
			    <td class="info">
			        휴대폰 번호
			         <input type="tel" id="addrtel" name="addrtel" maxlength="11" oninput="validatePhoneNumber(this)" style="width: 300px; height: 30px; margin-left: 10px;">
			    </td>
			</tr>
			<tr>
			    <td class="info">
			        배송지 주소
			        <input type="button" id="find_add_button" value="주소찾기" style="width: 70px; height: 35px;">
					<input type="text" id="addr" name="addr" readonly style="width: 450px; height: 30px; margin-left: 10px;">
					<input type="text" id="addrdetail" name="addrdetail" style="width: 540px; height: 30px; margin: 10px 0px 10px 110px;" placeholder="상세 주소 입력해주세요.">
			    </td>
			</tr>
			<tr>
			    <td class="info">
			        배송 요청 사항
			        <select name="delivery_name" id="delivery2" onchange="toggleDeliveryInput('directDeliveryForm')">
			            <option value="d1">부재시 핸드폰으로 연락주세요.</option>
			            <option value="d2">부재시 경비실에 맡겨주세요.</option>
			            <option value="d3">배송전에 연락주세요.</option>
			            <option value="d4">택배보관함에 보관해주세요.</option>
			            <option value="d5">부재시 집앞에 놔주세요.</option>
			            <option value="custom">직접 입력</option>
			        </select>
			        <input type="button" id="addr_save" value="배송지 저장하기">
			        <input type="text" id="customInput2" name="custom_delivery" style="width: 400px; height: 40px; margin-left: 151px; display: none;" placeholder="직접 입력하세요">
			    </td>
			</tr>
		</table>
	</form>
	          <!-- 결제금액 상자 -->
	<table id="pay">
	    <tr>
	        <td class="pay">
	            <span style="margin-left: 10px;"> 총 상품금액 </span> <span style="margin-left: 26%;line-height: 60px;">${pprice}원</span>
				<br><br><br>
				<span style="margin-left: 10px;"> 배송비 </span> <span style="margin-left: 50%;color: blue;">${ itemvo.shippingfee }원</span><hr>
				<span  style="margin-left: 10px;">결제 예정 금액 </span> <span style="margin-left: 7%;font-size: 30px;color: red;">${tprice}</span>원
				<br><br><br><br>
				<button id="payBtn" class="payBtn">결제하기</button>
	        </td>
	    </tr>
	</table>
	
	
	<!-- 상품정보 및 구매 정보 보여주기 -->
	<h1>주문상품</h1>
	<table border="1">
		<tr>
			<td>
				<img src="down.do?name=${ itemvo.thumbnailF }&file=${itemvo.thumbnailP}" alt="${itemvo.thumbnailF}" width=200px; height=150px; alt="음식1">
			</td>
			<td>
			${ itemvo.iname }<br>
			수량 ${ oitemcnt }개<br>
			${ pprice }원<br>
			배송비 : ${ itemvo.shippingfee }원
			</td>
		</tr>
	</table>
	<br><br>
	<!-- 결제수단 선택 -->
	<h1>결제수단 선택</h1>
	<table id="choose_Pay">
	    <tr>
	        <td class="choose_Pay" style="width: 150px;height: 40px; background: lightgray;  text-align: center;border-top: 2px solid black;"> 결제 예상 금액 </td>
	<td class="choose_Pay" style="font-size: 25px; border-top: 2px solid black;">  ${tprice}원</td>
	</tr>
	<tr>
	    <td class="choose_Pay" style="background: lightgray;  text-align: center; border-top: 2px solid black;" >
	    결제 수단 선택
	</td>
	<td class="choose_Pay"  style="border-top: 2px solid black;">
	<input type="radio" name="ck_box" value="신용카드" id="card" checked> 신용카드
	<!--
	<input type="radio" name="ck_box" value="실시간 계좌이체" style="margin-left: 32px;" id="real"> 실시간 계좌이체 <br>
	<input type="radio" name="ck_box" value="휴대폰 결제" id="phone"> 휴대폰 결제
	<input type="radio" name="ck_box" value="무통장 입금" id="direct"> 무통장 입금
	-->
	</td>
	</table>
	<br><br>
	
	<!-- 결제수단 선택 동의-->
	<h1>결제수단 선택</h1>
	<table id="agree">
	    <tr>
            <td class="agree_ck" style="font-size: 22px; border-top: 2px solid black;">
                <input type="checkbox" id="selectAll" name="ag_ckbox" value="selectall" onclick="selectAll(this)"> 전체동의하기
            </td>
	</tr>
	<tr>
            <td class="agree_ck" style="font-size: 15px;">
                <input type="checkbox" class="individual" name="ag_ckbox" value="ck1"> 개인정보 제3자 제공에 동의합니다. <br>
                <input type="checkbox" class="individual" name="ag_ckbox" value="ck2"> 결제대행서비스 이용약관에 동의합니다. <br>
                <input type="checkbox" class="individual" name="ag_ckbox" value="ck3"> 주문할 상품 설명에 명시된 내용과 사용조건을 확인하였으며, 취소, 환불 규정에 동의 합니다.
            </td>
	            </tr>
	        </table>
	        <br>
	        
	        
	    </form>
</div>
<br><br><br><br><br><br><br><br><br>

<!--전체 동의 선택 js-->
<script>
function selectAll(selectAllCheckbox) {
    const checkboxes = document.querySelectorAll('.individual');
    checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAllCheckbox.checked;
    });
}

function updateSelectAllCheckbox() {
    const individualCheckboxes = document.querySelectorAll('.individual');
    const selectAllCheckbox = document.getElementById('selectAll');

    // 모든 개별 체크박스가 선택되었는지 확인
    const allChecked = Array.from(individualCheckboxes).every(cb => cb.checked);
    selectAllCheckbox.checked = allChecked;
}

document.querySelectorAll('.individual').forEach(cb => {
    cb.addEventListener('change', updateSelectAllCheckbox);
});

</script>		
<jsp:include page="../include/tail.jsp" flush="true"/>