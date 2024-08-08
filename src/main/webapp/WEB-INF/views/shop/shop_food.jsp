<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/> 
<title>힐링독(Healing Dog)</title>
<link rel="stylesheet" href="resources/css/title.css"/>
<link href="resources/css/shop_food.css" rel="stylesheet">
<link href="resources/css/star.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>	 	
<script>
    $(document).ready(function() {
        let page = 2; // 시작 페이지를 1로 설정
        let isLoading = false; // 데이터 로딩 중인지 여부를 체크
        let isLastPage = false; // 마지막 페이지 여부를 체크

        function loadMoreItems() {
            if (isLoading || isLastPage) return; // 데이터 로딩 중이거나 마지막 페이지인 경우 아무 작업도 하지 않음
            isLoading = true; // 데이터 로딩 시작

            // 폼 값 가져오기
            let searchname = $('#searchname').val();
            let keyword = $('#keyword').val();
            
            $.ajax({
                url: 'shop_food_scroll.do',
                type: 'GET',
                dataType: 'json',
                data: {
                    page: page,
                    searchname: searchname,
                    keyword: keyword
                },
                success: function(response) {
                    console.log(response); // 응답 데이터 확인용
                    const items = response[0]; // 서버에서 받은 JSON 배열
                    isLastPage = response[1]; // 마지막 페이지 여부

                    if (items.length > 0) {
                        let $row = $('<tr></tr>');
                        items.forEach(function(item, index) {
                            if (index % 3 === 0 && index !== 0) {
                                $('#itemTable').append($row);
                                $row = $('<tr></tr>');
                            }

                            // 별점 표시를 위한 HTML 생성
                            const rating = parseFloat(item.ratingStar);
                            const ratingPercentage = rating * 20;

                            // 별점을 소수점 두 자리까지 표현
                            const formattedRating = rating.toFixed(1);

                            let ratingHtml =
                                '<div class="starpoint_wrap">' +
                                '<div class="starpoint_box">' +
                                '<div class="starpoint_bg" style="width: ' + ratingPercentage + '%;"></div>' +
                                '<div class="starpoint_empty"></div>' +
                                '</div>' +
                                '</div>';

                            let $td = $('<td>' +
                                '<ul>' +
                                '<li style="margin-left: 30px;">' +
                                '<a href="shop_food_view.do?itemno=' + item.itemno + '">' +
                                '<div class="img_boxes">' +
                                '<img src="down.do?name=' + item.thumbnailF + '&file=' + item.thumbnailP + '" alt="' + item.thumbnailF + '" width="200px" height="150px">' +
                                '</div>' +
                                '<div class="text_boxes">' +
                                '<h4>상품명 : ' + item.iname + '</h4>' +
                                '<h4>가격 : ' + item.price + '원</h4>' +
                                '<h4>별점 : ' + ratingHtml + ' (' + formattedRating + ')</h4>' +
                                '</div>' +
                                '</a>' +
                                '</li>' +
                                '</ul>' +
                                '</td>');

                            $row.append($td);
                        });
                        $('#itemTable').append($row);

                        if (isLastPage) {
                            $('#paginationMessage').text('마지막 페이지입니다');
                        } else {
                            page++; // 페이지 번호 증가
                        }
                    } else {
                        $('#paginationMessage').text('마지막 페이지입니다');
                        isLastPage = true; // 데이터가 없는 경우 마지막 페이지로 설정
                    }

                    isLoading = false; // 데이터 로딩 완료
                },
                error: function(xhr, status, error) {
                    console.error(error);
                    isLoading = false; // 오류 발생 시에도 로딩 상태를 해제
                }
            });







        }

        $(window).on('scroll', function() {
            if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
                loadMoreItems(); // 페이지 로드 요청
            }

            // 상단으로 가는 버튼 표시/숨기기
            if ($(window).scrollTop() > 200) {
                $('#scrollToTop').fadeIn();
            } else {
                $('#scrollToTop').fadeOut();
            }
        });

        $('#scrollToTop').on('click', function(e) {
            e.preventDefault();
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        });

        // 초기 데이터 로드
        loadMoreItems();
    });
    
    function submit(){
    	$("#reg").submit();
    }
</script>
		    <!-- 헤더 부분  끝-->
				<!-- 컨텐츠 출력 되는곳 -------------------------- -->
			<table width="100%" align="center">
				<tr>
					<td>
						<div id="imgslider">
							<div class="imgboxbox">
								<c:forEach var="itemlist" items="${listall}">
								<div>
									<img class="" src="down.do?name=${itemlist.thumbnailF}&file=${itemlist.thumbnailP}" alt="${itemlist.thumbnailF}" width=200px; height=300px;>
									<br>${itemlist.iname}<br>
									<div class="starpoint_wrap">
											        <div class="starpoint_box">
											            <!-- 별점 배경 -->
											            <div class="starpoint_empty"></div>
											
											            <!-- 별점 채우기 -->
											            <c:choose>
											                <c:when test="${itemlist.ratingStar == '5.0'}">
											                    <div class="starpoint_bg" style="width:100%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '4.5'}">
											                    <div class="starpoint_bg" style="width:90%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '4.0'}">
											                    <div class="starpoint_bg" style="width:80%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '3.5'}">
											                    <div class="starpoint_bg" style="width:70%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '3.0'}">
											                    <div class="starpoint_bg" style="width:60%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '2.5'}">
											                    <div class="starpoint_bg" style="width:50%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '2.0'}">
											                    <div class="starpoint_bg" style="width:40%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '1.5'}">
											                    <div class="starpoint_bg" style="width:30%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '1.0'}">
											                    <div class="starpoint_bg" style="width:20%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '0.5'}">
											                    <div class="starpoint_bg" style="width:10%;"></div>
											                </c:when>
											                <c:otherwise>
											                    <div class="starpoint_bg"></div>
											                </c:otherwise>
											            </c:choose>
											        </div>
											    </div>
											    (${itemlist.rating})
								</div>
								 </c:forEach>
							</div>						
						</div>
					</td>
				</tr>
				<tr>
					
				</tr>
				<tr>
					<td align="right">		
						<form id="reg" name="reg" method="get" action="">	
							<span style="margin-left:2%">
								<select id="searchname" name="searchname" style="width:70px; height:30px; font-size:20;">
									<option value="N">상품명</option>
								</select>
								<span class="search_box">
									<input type="text" id="keyword" name="keyword" class="search_text" value="${ search.keyword}">
									<a href="javascript:submit();"><img src="resources/img/search.png" class="search_img"></a>
								</span>
							
							</span>
						</form>
					</td>
				</tr>					
				<tr>
					<td>
						<br>
<table border="0" width="100%" id="itemTable">							
                <tr>				
                    <c:forEach var="itemlist" items="${itemlist}">			
                        <td>										
                            <ul>				
                                <li style="margin-left: 30px;">
                                    <a href="shop_food_view.do?itemno=${itemlist.itemno}">
                                        <div class="img_boxes">								
                                            <img src="down.do?name=${itemlist.thumbnailF}&file=${itemlist.thumbnailP}" alt="${itemlist.thumbnailF}" width=200px; height=150px;>
                                        </div>
                                        <div class="text_boxes">
                                            <h4>
                                                상품명 : ${itemlist.iname}
                                            </h4>
                                            <h4>
                                                가격 : ${itemlist.price}원
                                            </h4>
											<h4>
											    별점 :
											    <div class="starpoint_wrap">
											        <div class="starpoint_box">
											            <!-- 별점 배경 -->
											            <div class="starpoint_empty"></div>
											
											            <!-- 별점 채우기 -->
											            <c:choose>
											                <c:when test="${itemlist.ratingStar == '5.0'}">
											                    <div class="starpoint_bg" style="width:100%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '4.5'}">
											                    <div class="starpoint_bg" style="width:90%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '4.0'}">
											                    <div class="starpoint_bg" style="width:80%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '3.5'}">
											                    <div class="starpoint_bg" style="width:70%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '3.0'}">
											                    <div class="starpoint_bg" style="width:60%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '2.5'}">
											                    <div class="starpoint_bg" style="width:50%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '2.0'}">
											                    <div class="starpoint_bg" style="width:40%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '1.5'}">
											                    <div class="starpoint_bg" style="width:30%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '1.0'}">
											                    <div class="starpoint_bg" style="width:20%;"></div>
											                </c:when>
											                <c:when test="${itemlist.ratingStar == '0.5'}">
											                    <div class="starpoint_bg" style="width:10%;"></div>
											                </c:when>
											                <c:otherwise>
											                    <div class="starpoint_bg"></div>
											                </c:otherwise>
											            </c:choose>
											        </div>
											    </div>
											    (${itemlist.rating})
											</h4>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </td>
                    </c:forEach>
                </tr>
            </table>
            <div id="paginationMessage" style="text-align: center; font-weight: bold; color: red;"></div>
        </td>
    </tr>
</table>
<!-- 상단으로 가는 버튼 -->
<a href="#" id="scrollToTop" style="display: none; position: fixed; bottom: 20px; right: 20px; background: #000; color: #fff; padding: 10px; border-radius: 5px; text-align: center; text-decoration: none;">
    ↑ 상단으로
</a>
<jsp:include page="../include/tail.jsp" flush="true"/>