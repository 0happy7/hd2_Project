<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
		    
<title>상품 상세정보</title>
<link rel="stylesheet" href="resources/css/title.css"/>
<link href="resources/css/shop_clothes_view.css" rel="stylesheet">
<!-- 헤더 부분  끝-->
<!-- 스크립트 부분 -->
<script>

// 상품 구매 코드
let quantity = 1; // 초기 수량
const pricePerItem = ${item.price}; // 상품 단가
const itemNo = ${item.itemno}; // 상품 번호
const stock = ${item.stock}; // 재고량
window.onload = function()
{
	updateTotalPrice();
	$("#review_write_btn").click(function(){
		if(confirm("리뷰를 등록하시겠습니까?")) {
			reviewWrite();
		}
	});
}

function reviewWrite(){
	if($("#rnote").val() == "")
	{
		alert("댓글을 입력해주세요");
		$("#rnote").focus();
		return;
	}

	$.ajax({
		url : "review_write.do",
		type : "post",
		data :
		{
			reitemno : ${item.itemno},
			recontent :	$("#rnote").val(),
			<c:if test="${ login != null}">
			reuserno : ${login.userno},
			</c:if>
			rate : $('[name=starpoint]:checked').val()
		},
		dataType : "html",
		success : function(response)
		{
			response = response.trim();
			if(response == "false")
			{
				alert("리뷰 작성에 실패하였습니다.");	
			}else
			{
				alert("리뷰가 등록되었습니다.");
	            $.get(location.href, function(data) {
	                var newContent = $(data).find("#food_review_table");
	                $("#food_review_table").replaceWith(newContent);
	            });
	            $.get(location.href, function(data) {
	                var newContent = $(data).find("#total_rating");
	                $("#total_rating").replaceWith(newContent);
	            });  
			}				
		}
	});
}

function review_del(no){
	if( confirm("리뷰를 삭제하시겠습니까?") ) {
		$.ajax({
			url : "review_delete.do",
			type : "post",
			data :
			{
				reviewno : no,
				reitemno : ${item.itemno}
			},
			dataType : "html",
			success : function(response)
			{
				response = response.trim();
				if(response == "false")
				{
					alert("리뷰 삭제에 실패하였습니다.");	
				}else
				{
					alert("리뷰가 삭제되었습니다.");
		            $.get(location.href, function(data) {
		                var newContent = $(data).find("#food_review_table");
		                $("#food_review_table").replaceWith(newContent);
		            });
		            $.get(location.href, function(data) {
		                var newContent = $(data).find("#total_rating");
		                $("#total_rating").replaceWith(newContent);
		            });  
				}				
			}
		});
	}
}

function decrementQuantity() {
    if (quantity > 1) {
        quantity--;
        updateQuantityDisplay();
    }
}

function incrementQuantity() {
    if (quantity < stock) { // 재고량을 초과하지 않도록 제한
        quantity++;
        updateQuantityDisplay();
    } else {
        alert("재고가 부족합니다.");
    }
}

//수량 표시 업데이트 함수
function updateQuantityDisplay() {
    document.getElementById('quantity').textContent = quantity;
    document.getElementById('hiddenQuantity').value = quantity; // Hidden input 업데이트
    updateTotalPrice();
}

// 총 가격 업데이트 함수
function updateTotalPrice() {
    const totalPrice = quantity * pricePerItem;
    const tprice = totalPrice + ${item.shippingfee};
    document.getElementById('totalPrice').textContent = totalPrice;
    document.getElementById('hiddenProductPrice').value = totalPrice;
    document.getElementById('hiddenTotalPrice').value = tprice; // Hidden input 업데이트
}

function confirmPurchase() {
    const totalAmount = quantity * pricePerItem;

    if (quantity > stock) {
        alert(`재고가 부족합니다. 현재 재고: ${stock}`);
        return;
    }

    if (confirm('구매하시겠습니까?\n구매 갯수: ' + quantity + '개 \n총 가격: ' + totalAmount + '원\n배송비: ' + ${item.shippingfee})) {
    	// 폼을 서버로 제출
        document.getElementById('purchaseForm').submit();
    }
}
</script>
<!-- 스크립트 부분 끝 -->
				<!-- 컨텐츠 출력 되는곳 -------------------------- -->
			
				
			<table width="100%" align="center">
				<tr>
					<td style="text-align:center; border:0px" >
						<a href="shop_food.do" style="color: black; margin: 20px;"><h1>상품 상세정보</h1></a>
						<hr>
				 	</td>  
				</tr>
			</table>
			<div class="sidebar">
				<aside>
				    상품 이름 : ${item.iname}<br>
				    <form id="purchaseForm" action="payment.do" method="POST">
				        수량 :
				        <input type="button" style="width:20px; height:20px; font-size:14px;" value="-" onclick="decrementQuantity()">
				        <span id="quantity">1</span>
				        <input type="button" style="width:20px; height:20px; font-size:14px;" value="+" onclick="incrementQuantity()"><br>
				        가격 : <span id="totalPrice">${item.price}</span>원<br>
				        <input type="hidden" name="oitemno" value="${item.itemno}">
				        <input type="hidden" name="oitemcnt" value="1" id="hiddenQuantity"> <!-- Hidden input for quantity -->
				        <input type="hidden" name="pprice" value="${item.price}" id="hiddenProductPrice">
				        <input type="hidden" name="tprice" value="${item.price}" id="hiddenTotalPrice"> <!-- Hidden input for total amount -->
				        배송비 : ${item.shippingfee}원<br>
				        <input type="button" style="width:100px; height:50px; font-size:14px;" value="구매하기" onclick="confirmPurchase()">
				    </form>
				</aside>
			</div>
			<table width="70%">										
				<tr>
					<td style="border:0px;">
						<table border="0">
							<tr>
								<td width=30%;>
									<img src="down.do?name=${item.thumbnailF}&file=${item.thumbnailP}" alt="${item.thumbnailF}" width=340px; height=300px; alt="음식1">
								</td>
								<td>
									<table border="0" style="height:300px; width:400px;">
									<tr align="center">
										<td>평점</td>
										<td id="total_rating">
											<div class="starpoint_wrap">
										        <div class="starpoint_box">
										          <label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5점</span></label>
										          <label for="starpoint_2" class="label_star" title="1"><span class="blind">1점</span></label>
										          <label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5점</span></label>
										          <label for="starpoint_4" class="label_star" title="2"><span class="blind">2점</span></label>
										          <label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5점</span></label>
										          <label for="starpoint_6" class="label_star" title="3"><span class="blind">3점</span></label>
										          <label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5점</span></label>
										          <label for="starpoint_8" class="label_star" title="4"><span class="blind">4점</span></label>
										          <label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5점</span></label>
										          <label for="starpoint_10" class="label_star" title="5"><span class="blind">5점</span></label>
										          <c:choose>
														<c:when test="${ item.ratingStar == '5.0' }">
															<span class="starpoint_bg" style="width:100%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '4.5' }">
															<span class="starpoint_bg" style="width:90%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '4.0' }">
															<span class="starpoint_bg" style="width:80%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '3.5' }">
															<span class="starpoint_bg" style="width:70%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '3.0' }">
															<span class="starpoint_bg" style="width:60%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '2.5' }">
															<span class="starpoint_bg" style="width:50%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '2.0' }">
															<span class="starpoint_bg" style="width:40%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '1.5' }">
															<span class="starpoint_bg" style="width:30%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '1.0' }">
															<span class="starpoint_bg" style="width:20%;"></span> 
														</c:when>
														<c:when test="${ item.ratingStar == '0.5' }">
															<span class="starpoint_bg" style="width:10%;"></span> 
														</c:when>
														
														<c:otherwise>
															<span class="starpoint_bg"></span> 
														</c:otherwise>
												  </c:choose>
	
										        </div>
										    </div>
											(${ item.rating })
										</td>
									</tr>
									<tr align="center">
										<td>상품명</td>
										<td>${item.iname}</td>
									</tr>
									<tr align="center">
										<td>가격</td>
										<td>${item.price}원</td>
									</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="table_td_icontent">
									${item.icontent}
								</td>
							</tr>
						</table>
					</td>
				</tr>		
			</table>
			<table>
				<tr>
					<td style="text-align:left; padding:0 0 0 20px; border:0px solid;" >
						<input type="text" value="${ login.uname }" style="width:150px; height:28px;" readonly>
				        	<div class="starpoint_wrap">
							  <div class="starpoint_box">
							    <label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5점</span></label>
							    <label for="starpoint_2" class="label_star" title="1"><span class="blind">1점</span></label>
							    <label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5점</span></label>
							    <label for="starpoint_4" class="label_star" title="2"><span class="blind">2점</span></label>
							    <label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5점</span></label>
							    <label for="starpoint_6" class="label_star" title="3"><span class="blind">3점</span></label>
							    <label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5점</span></label>
							    <label for="starpoint_8" class="label_star" title="4"><span class="blind">4점</span></label>
							    <label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5점</span></label>
							    <label for="starpoint_10" class="label_star" title="5"><span class="blind">5점</span></label>
							    <input type="radio" name="starpoint" id="starpoint_1" class="star_radio" value="0.5">
							    <input type="radio" name="starpoint" id="starpoint_2" class="star_radio" value="1.0">>
							    <input type="radio" name="starpoint" id="starpoint_3" class="star_radio" value="1.5">>
							    <input type="radio" name="starpoint" id="starpoint_4" class="star_radio" value="2.0">>
							    <input type="radio" name="starpoint" id="starpoint_5" class="star_radio" value="2.5">>
							    <input type="radio" name="starpoint" id="starpoint_6" class="star_radio" value="3.0">>
							    <input type="radio" name="starpoint" id="starpoint_7" class="star_radio" value="3.5">>
							    <input type="radio" name="starpoint" id="starpoint_8" class="star_radio" value="4.0">>
							    <input type="radio" name="starpoint" id="starpoint_9" class="star_radio" value="4.5">>
							    <input type="radio" name="starpoint" id="starpoint_10" class="star_radio" value="5.0">>
							    <span class="starpoint_bg"></span>
							  </div>
							</div>
                        <br>
						<input type="text" id="rnote" placeholder="후기를 작성하세요." style="width:740px; height:28px;">
						<input type="button" value="등록" id="review_write_btn" style="width:70px; height:30px; font-size:20px;">
						<div><br></div>
					</td>
				</tr>
			</table>
			<table border="1" width="70%" align="center" id="food_review_table">
							<tr>
								<td width=10%>
									<h4>후기</h4>
								</td>
								<td width=10%>
									<h4>평점</h4>
								</td>
								<td width=60%>
									<h4>내용</h4>
								</td>
								<td>
									<h4>후기날짜</h4>
								</td>
							</tr>
							<c:forEach var="reviewlist" items="${ reviewlist }">
								<tr>
									<td width=10%>
										${ reviewlist.name }
									</td>
									<td width=15%>
										<div class="starpoint_wrap">
									        <div class="starpoint_box">
									          <label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5점</span></label>
									          <label for="starpoint_2" class="label_star" title="1"><span class="blind">1점</span></label>
									          <label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5점</span></label>
									          <label for="starpoint_4" class="label_star" title="2"><span class="blind">2점</span></label>
									          <label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5점</span></label>
									          <label for="starpoint_6" class="label_star" title="3"><span class="blind">3점</span></label>
									          <label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5점</span></label>
									          <label for="starpoint_8" class="label_star" title="4"><span class="blind">4점</span></label>
									          <label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5점</span></label>
									          <label for="starpoint_10" class="label_star" title="5"><span class="blind">5점</span></label>
									          <c:choose>
													<c:when test="${ reviewlist.rate == '5.0' }">
														<span class="starpoint_bg" style="width:100%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '4.5' }">
														<span class="starpoint_bg" style="width:90%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '4.0' }">
														<span class="starpoint_bg" style="width:80%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '3.5' }">
														<span class="starpoint_bg" style="width:70%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '3.0' }">
														<span class="starpoint_bg" style="width:60%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '2.5' }">
														<span class="starpoint_bg" style="width:50%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '2.0' }">
														<span class="starpoint_bg" style="width:40%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '1.5' }">
														<span class="starpoint_bg" style="width:30%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '1.0' }">
														<span class="starpoint_bg" style="width:20%;"></span> 
													</c:when>
													<c:when test="${ reviewlist.rate == '0.5' }">
														<span class="starpoint_bg" style="width:10%;"></span> 
													</c:when>
													
													<c:otherwise>
														<span class="starpoint_bg"></span> 
													</c:otherwise>
											  </c:choose>

									        </div>
									    </div>
										(${ reviewlist.rate })
									</td>
									<td width=60%>
										${ reviewlist.recontent }
									</td>
									<td>
										${ reviewlist.redate }<br>
										<c:if test="${ login != null && login.userno == reviewlist.reuserno }">
										<input type="button" value="삭제" id="review_del_btn" onclick="javascript:review_del(${reviewlist.reviewno})">
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</table>
<jsp:include page="../include/tail.jsp" flush="true"/>