<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>관리자페이지</title>
<link rel="stylesheet" href="resources/css/title.css"/>
<link rel="stylesheet" href="resources/css/mypage.css"/>
<!-- 헤더 부분  끝-->
<script>
	window.onload = function()
	{	
		$("#update_btn").click(function(){
			if( confirm("수정을 하시겠습니까?") ){
				updateOrder();
			}
			
		});
	}
	function toggleDeliveryFields() {
	    const orderStatus = document.getElementById('order_status').value;
	    const deliverySelect = document.getElementById('deliveryc');
	    const trackingInput = document.getElementById('trackingno');

	    if (orderStatus === 's4' || orderStatus === 's5' || orderStatus === 's6') { // 배송중, 배송완료, 구매확정 상태
	        deliverySelect.disabled = false;
	        trackingInput.disabled = false;
	    } else {
	        deliverySelect.disabled = true;
	        trackingInput.disabled = true;
	        deliverySelect.value = ''; // 빈 값으로 설정
	        trackingInput.value = '';  // 빈 값으로 설정
	    }
	}

	function updateOrder() {
	    const orderStatus = $("#order_status").val();
	    const deliveryc = (orderStatus === 's4' || orderStatus === 's5' || orderStatus === 's6') ? $("#deliveryc").val() : '';
	    const trackingno = (orderStatus === 's4' || orderStatus === 's5' || orderStatus === 's6') ? $("#trackingno").val() : '';

	    $.ajax({
	        url: "admin_update_order.do",
	        type: "post",
	        data: {
	            orderno: ${ order.orderno },
	            status: orderStatus,
	            deliveryc: deliveryc,
	            trackingno: trackingno,
	            omemo: $("#order_memo").val()
	        },
	        dataType: "html",
	        success: function(response) {
	            response = response.trim();
	            if (response === "true") {
	                alert("수정완료");
	                document.location = 'admin_orderpage.do?orderno=' + ${ order.orderno };
	            }
	        }
	    });
	}

	// 초기 로드시 배송지 정보 필드 설정
	document.addEventListener('DOMContentLoaded', toggleDeliveryFields);
	
</script>

<jsp:include page="../include/admin_head.jsp" flush="true"/>
                <!-- 메인 내용 -->
                <!-- 상단 페이지, 검색창 -->
                <div class="mypage_table_topbox">
                    <div class="mypage_table_topbox_ordertext">주문상세내역</div>
                </div>

                <div class="mypage_table_topbox_order_list">주문정보</div>
                <table border="1" class="spage_order_table">
                   <tr>
    <th>주문상태</th>
    <td>
        <select name="status" id="order_status" class="spage_order_table_select" onchange="toggleDeliveryFields()">
            <c:if test="${ order.status == '결제대기' }">
	            <option value="s1" selected>결제대기</option>
	            <option value="s2">결제완료</option>
	            <option value="s3">상품준비중</option>
	            <option value="s4">배송중</option>
	            <option value="s5">배송완료</option>
	            <option value="s6">구매확정</option>
	            <option value="s7">주문취소</option>
            </c:if>
            <c:if test="${ order.status == '결제완료' }">
	            <option value="s1">결제대기</option>
	            <option value="s2" selected>결제완료</option>
	            <option value="s3">상품준비중</option>
	            <option value="s4">배송중</option>
	            <option value="s5">배송완료</option>
	            <option value="s6">구매확정</option>
	            <option value="s7">주문취소</option>
            </c:if>
            <c:if test="${ order.status == '상품준비중' }">
	            <option value="s1">결제대기</option>
	            <option value="s2">결제완료</option>
	            <option value="s3" selected>상품준비중</option>
	            <option value="s4">배송중</option>
	            <option value="s5">배송완료</option>
	            <option value="s6">구매확정</option>
	            <option value="s7">주문취소</option>
            </c:if>
            <c:if test="${ order.status == '배송중' }">
	            <option value="s1">결제대기</option>
	            <option value="s2">결제완료</option>
	            <option value="s3">상품준비중</option>
	            <option value="s4" selected>배송중</option>
	            <option value="s5">배송완료</option>
	            <option value="s6">구매확정</option>
	            <option value="s7">주문취소</option>
            </c:if>
            <c:if test="${ order.status == '배송완료' }">
	            <option value="s1">결제대기</option>
	            <option value="s2">결제완료</option>
	            <option value="s3">상품준비중</option>
	            <option value="s4">배송중</option>
	            <option value="s5" selected>배송완료</option>
	            <option value="s6">구매확정</option>
	            <option value="s7">주문취소</option>
            </c:if>
            <c:if test="${ order.status == '구매확정' }">
	            <option value="s1">결제대기</option>
	            <option value="s2">결제완료</option>
	            <option value="s3">상품준비중</option>
	            <option value="s4">배송중</option>
	            <option value="s5">배송완료</option>
	            <option value="s6" selected>구매확정</option>
	            <option value="s7">주문취소</option>
            </c:if>
            <c:if test="${ order.status == '주문취소' }">
	            <option value="s1">결제대기</option>
	            <option value="s2">결제완료</option>
	            <option value="s3">상품준비중</option>
	            <option value="s4">배송중</option>
	            <option value="s5">배송완료</option>
	            <option value="s6">구매확정</option>
	            <option value="s7" selected>주문취소</option>
            </c:if>
        </select>
    </td>
</tr>
<tr>
    <th>배송지 정보</th>
    <td>
        <select name="deliveryc" id="deliveryc" class="spage_order_table_select" disabled>
        	<c:if test="${ order.deliveryc == '우체국택배' }">
	        	<option value="d1" selected>우체국택배</option>
	            <option value="d2">대한통운</option>
	            <option value="d3">로젠택배</option>
        	</c:if>
        	<c:if test="${ order.deliveryc == '대한통운' }">
	        	<option value="d1">우체국택배</option>
	            <option value="d2" selected>대한통운</option>
	            <option value="d3">로젠택배</option>
        	</c:if>
        	<c:if test="${ order.deliveryc == '로젠택배' }">
	        	<option value="d1">우체국택배</option>
	            <option value="d2">대한통운</option>
	            <option value="d3" selected>로젠택배</option>
        	</c:if>
        	
        	<c:if test="${ order.deliveryc == '' }">
	        	<option value="d1">우체국택배</option>
	            <option value="d2">대한통운</option>
	            <option value="d3">로젠택배</option>
        	</c:if>
        </select>
        <input type="text" placeholder="운송장 번호 입력" id="trackingno" name="trackingno" value="${ order.trackingno }" class="spage_order_table_input" disabled>
    </td>
</tr>
                    <tr>
                        <th>주문번호</th>
                        <td><span>${ order.ordernum }</span></td>
                    </tr>
                    <tr>
                        <th>주문일시</th>
                        <td><span>${ order.odate }</span></td>
                    </tr>
                </table>
                <br>
                <div class="mypage_table_topbox_order_list">결제정보</div>
                    <table border="1" class="spage_pay_table">
                        <tr>
                            <th>상품금액</th>
                            <td><span>${ item.price }</span></td>
                        </tr>
                        <tr>
                            <th>배송비</th>
                            <td><span>${ item.shippingfee }</span></td>
                        </tr>
                        <tr>
                            <th>총 결제 금액</th>
                            <td><span>${ pay.payprice }</span></td>
                        </tr>
                        <tr>
                            <th>결제수단</th>
                            <td><span>${ pay.payment }</span></td>
                        </tr>
                        <tr>
                            <th>결제일시</th>
                            <td><span>${ pay.paydate }</span></td>
                        </tr>
                    </table>
                <br>
                <div class="mypage_table_topbox_order_list">상품정보</div>
                    <table border="1" class="spage_product_table">
                        <tr>
                            <th style="width: 5%;">번호</th>
                            <th>이미지</th>
                            <th style="width: 50%;">상품 정보</th>
                            <th>가격</th>
                            <th style="width: 5%;">수량</th>
                            <th>총구매금액</th>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>
                                <img src="down.do?name=${ item.thumbnailF }&file=${item.thumbnailP}" alt="${item.thumbnailF}" style="width: 100px; height: 100px;">
                            </td>
                            <td>${ item.iname }</td>
                            <td>${ item.price }</td>
                            <td>${ order.oitemcnt }</td>
                            <td>${ order.tprice }</td>
                        </tr>
                    </table>
                    <br>
                <div class="mypage_table_topbox_order_list">주문자 및 배송지정보</div>
                    <div class="spage_user_table_box">
                        <table border="1" class="spage_user_table">
                            <tr>
                                <th colspan="2">주문자정보</th>
                            </tr>
                            <tr>
                                <th>주문자명</th>
                                <td><span>${ login.uname }</span></td>
                            </tr>
                            <tr>
                                <th>회원아이디</th>
                                <td><span>${ login.userid }</span></td>
                            </tr>

                            <tr>
                                <th>이메일주소</th>
                                <td><span>${ login.email }</span></td>
                            </tr>
                        </table>

                        <table border="1" class="spage_user_table">
                            <tr>
                                <th colspan="2">배송지 정보</th>
                            </tr>
                            <tr>
                                <th>수취인명</th>
                                <td><span>${ order.oaddrname }</span></td>
                            </tr>
                            <tr>
                                <th>수취인번호</th>
                                <td><span>${ order.oaddrtel }</span></td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td><span>${ order.oaddr } ${ order.oaddrdetail }</span></td>
                            </tr>
                            <tr>
                                <th>요청사항</th>
                                <td><span>${ order.oreq }</span></td>
                            </tr>
                        </table>
                    </div>
                    <br>
                <div class="mypage_table_topbox_order_list">관리자 메모</div>
                    <textarea name="order_memo" id="order_memo" cols="30" rows="10" class="spage_admin_text">${ order.omemo }</textarea>
                <br>
                <div class="spage_button_box">
                    <input type="button" id="update_btn" value="저장" class="spage_button">
                    <input type="button" value="취소" class="spage_button" onclick="location.href='admin_orderpage.do?orderno=${ order.orderno }'">
                </div>
                <!-- 메인 내용 끝 -->
            </td>
        </tr>
    </table>
</div>


    <!-- 메인 영역 끝 -->
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>