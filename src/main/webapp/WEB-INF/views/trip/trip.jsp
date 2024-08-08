<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>댕댕이게시판 글 보기</title>
<link href="resources/css/trip_write.css" type="text/css" rel="stylesheet">
<link href="resources/css/trip.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/title.css"/>	    
<!-- 컨텍스트 메뉴 HTML 코드 -->
<ul class="right">
    <!-- userno는 JavaScript에서 동적으로 추가됩니다 -->
    <li><a id="writeListLink" href="#">쓴 글</a></li>
</ul>
<script>
$(document).ready(function() {
    // 우클릭 시 컨텍스트 메뉴 표시
    $('.writer').contextmenu(function(e) {
        e.preventDefault();

        // 클릭된 writer 요소의 userno 가져오기
        var userno = $(this).data('userno');
        
        // 컨텍스트 메뉴 업데이트
        var menu = $('.right');
        var menuLink = $('#writeListLink'); // ID로 메뉴 링크 선택
        menuLink.attr('href', 'username_write_list.do?userno=' + userno);

        // 메뉴 위치 조정
        var winWidth = $(window).width();
        var winHeight = $(window).height();
        var menuWidth = menu.outerWidth();
        var menuHeight = menu.outerHeight();
        var posX = e.pageX;
        var posY = e.pageY;

        var posLeft = (posX + menuWidth > winWidth) ? posX - menuWidth - 10 : posX + 10;
        var posTop = (posY + menuHeight > winHeight) ? posY - menuHeight - 10 : posY + 10;

        menu.css({
            left: posLeft + 'px',
            top: posTop + 'px'
        }).show();

        return false; // 기본 컨텍스트 메뉴 방지
    });

    // 페이지 클릭 시 컨텍스트 메뉴 숨기기
    $(document).click(function() {
        $('.right').hide();
    });
});
	
	document.addEventListener("DOMContentLoaded", function() {
	    // 페이지 로드 시에도 선택한 지역 유지
	    var regionSelect = document.getElementById('regionSelect');
	    regionSelect.value = "${area}"; // 서버에서 넘어온 지역 값으로 설정

	    // 지역 선택 변경 시 처리
	    regionSelect.addEventListener('change', function() {
	        handleRegionChange();
	    });

	    // 검색어와 검색 조건이 있는 경우 초기화
	    var keyword = '${keyword}';
	    var sena = '${sena}';
	    if (keyword) {
	        document.getElementById('keyword').value = keyword;
	    }
	    if (sena) {
	        document.getElementById('searchname').value = sena;
	    }

	    // 폼 제출 이벤트 처리
	    var form = document.getElementById('reg');
	    form.addEventListener('submit', function(event) {
	        event.preventDefault(); // 기본 제출 동작 방지
	        submitForm();
	    });
	});

	// 페이지 로드 시 저장된 지역 값이 있으면 선택된 상태로 설정
	window.onload = function() {
	    var selectedRegion = localStorage.getItem('selectedRegion');
	    if (selectedRegion) {
	        document.getElementById('regionSelect').value = selectedRegion;
	    }
	};

	function handleRegionChange() {
	    var selectedRegion = document.getElementById('regionSelect').value;
	    var selectedSearch = document.getElementById('searchname').value;
	    var keyword = document.getElementById('keyword').value;

	    // 지역 값 localStorage에 저장
	    localStorage.setItem('selectedRegion', selectedRegion);

	    // URL 설정
	    var url = 'trip.do';

	    var params = [];

	    if (selectedRegion !== '전체') {
	        params.push('area=' + encodeURIComponent(selectedRegion));
	    }

	    if (keyword.trim() !== '') {
	        params.push('sena=' + encodeURIComponent(selectedSearch));
	        params.push('keyword=' + encodeURIComponent(keyword));
	    }

	    if (params.length > 0) {
	        url += '?' + params.join('&');
	    }

	    // 폼의 action을 설정하고 제출
	    document.getElementById('reg').action = url;
	    submitForm();
	}

	function submitForm() {
	    // 폼 제출
	    document.getElementById('reg').submit();
	}
</script>
<!-- 헤더 부분  끝-->
				<!-- 컨텐츠 출력 되는곳 -------------------------- -->
				
			<table width="100%" align="center">
				<tr>
					<td style="position: relative;">
						<h1 class="main_image_text" style="font-size:25px; width:100%; position: absolute; left: 340px;">댕댕이 여행지 : 강아지와 함께 여행 후 사진을 남기거나 다른 사람의 글로 정보를 얻을 수 있습니다.</h1>						
					<table>
						<tr>
							<td>
								<div class="main_image1">		
									<img src="resources/img/dog_board1.jpg" width=400px height=400px>							
								</div>
							</td>					
							<td>
								<div class="main_image2">
									<img src="resources/img/dog_board2.jpg" width=400px height=400px>
								</div>
							</td>					
							<td>
								<div class="main_image3">
									<img src="resources/img/dog_board3.jpg" width=400px height=400px>
								</div>
							</td>
						</tr>
					</table>
				  </td>  
				</tr>
				<tr>
					<td>
						<font size=4px>&nbsp;&nbsp;&nbsp;총 ${ search.total }건 | 페이지 ${ search.pageno } / ${ search.maxpage }</font>
					</td>
				</tr>
				<tr>
					<td class="tripnotice">
						<a href="notice_view.do?no=4"><h4><img src="resources/img/blueicon2.png" width=30px height=30px>댕댕이여행지 공지 : 댕댕이와 관련된 사진 및 글만 작성해주세요. 자세한 정보는 클릭하여 확인 바랍니다.(공지사항 게시판 이동)</h4></a>
					</td>
				</tr>
				<tr>
					<td>
					<form id="reg" name="reg" method="get" action="trip.do">
				    <span>
				        <br>
				        <br>
				        <br>
				        <font size="3px">지역을 선택해주세요 :</font> 
					        <span>
					            <select id="regionSelect" name="area" style="width:150px;height:30px;font-size:15;" onchange="handleRegionChange();">
					                <option value="전체" ${area eq '전체' ? 'selected' : ''}>전체</option>
					                <option value="전주시" ${area eq '전주시' ? 'selected' : ''}>전주시</option>
					                <option value="군산시" ${area eq '군산시' ? 'selected' : ''}>군산시</option>
					                <option value="익산시" ${area eq '익산시' ? 'selected' : ''}>익산시</option>
					                <option value="정읍시" ${area eq '정읍시' ? 'selected' : ''}>정읍시</option>
					                <option value="남원시" ${area eq '남원시' ? 'selected' : ''}>남원시</option>
					                <option value="김제시" ${area eq '김제시' ? 'selected' : ''}>김제시</option>
					                <option value="완주군" ${area eq '완주군' ? 'selected' : ''}>완주군</option>
					                <option value="진안군" ${area eq '진안군' ? 'selected' : ''}>진안군</option>
					                <option value="무주군" ${area eq '무주군' ? 'selected' : ''}>무주군</option>
					                <option value="장수군" ${area eq '장수군' ? 'selected' : ''}>장수군</option>
					                <option value="임실군" ${area eq '임실군' ? 'selected' : ''}>임실군</option>
					                <option value="순창군" ${area eq '순창군' ? 'selected' : ''}>순창군</option>
					                <option value="고창군" ${area eq '고창군' ? 'selected' : ''}>고창군</option>
					                <option value="부안군" ${area eq '부안군' ? 'selected' : ''}>부안군</option>
					            </select>
					        </span>
					        <select name="searchname" id="searchname" style="width:70px; height:30px; font-size:15px;" onchange="handleRegionChange();">
					            <option value="작성자" ${sena eq '작성자' ? 'selected' : ''}>작성자</option>
					            <option value="내용" ${sena eq '내용' ? 'selected' : ''}>내용</option>
					        </select>
					        <span class="search_box">
					            <input type="text" id="keyword" name="keyword" value="${search.keyword}" class="search_text">
					            <img src="resources/img/search.png" class="search_img" onclick="submitForm();">
					        </span>
					    </span>
					</form>
					</td>
				</tr>					
				<tr>
					<td>
						<br>
						<table border="0" width="100%">
							<c:forEach var="item" items="${list}" varStatus="status">
						        <c:if test="${status.index % 4 == 0}">
						            <tr>
						        </c:if>
						        <td>
						            <div class="post">
						                <a href="trip_view.do?no=${item.bno}">
						                    <div class="image-box">
									            <c:set var="firstFile" value="${item}" />
									            <img src="${pageContext.request.contextPath}/resources/upload/${firstFile.bpname}" alt="${firstFile.bfname}" width="200px" height="150px">
						                    </div>
						                    <div class="text-box">
						                        <h4>${item.bname}</h4>
						                        <span>${item.addr}</span>
						                        <div class="writer-box">
						                            <span class="writer" data-userno="${item.userno}">${item.name}</span>
						                            <span class="date">${item.bwdate}</span>
						                        </div>
						                    </div>
						                </a>
						            </div>
						        </td>
						        <c:if test="${status.index % 4 == 3 || status.last}">
						            </tr>
						        </c:if>
						    </c:forEach>
							<tr>
								<td style="height:50px;">
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td style="text-align:right; font-size:20px;">
								<c:if test="${ search.startbk > 10 }">
									<a href="trip.do?page=${ search.startbk - 1 }&kind=${ search.kind }">이전</a>
								</c:if>																
							<c:forEach var="page" begin="${ search.startbk }" end="${ search.endbk }">
								<c:if test="${page == search.pageno }">
									<span style="color:red"><a href="trip.do?page=${ page }&kind=${ search.kind }">${ page }</a></span>
								</c:if>
								<c:if test="${ page != search.pageno }">
									<a href="trip.do?page=${ page }&kind=${ search.kind }">${ page }</a>
								</c:if>								
							</c:forEach>
								<c:if test="${ search.endbk < search.maxpage }">
									<a href="trip.do?page=${ search.endbk + 1 }&kind=${ search.kind }">다음</a>
								</c:if>								
								</td>
								<td>									
								</td>
								<c:if test="${ sessionScope.login != null }">
									<td style="text-align:center; font-size:20px;">
										<a href="trip_write.do"><input type="button" style="width:80px; height:40px; font-size:18px;" value="글쓰기"></a>
									</td>
								</c:if>
								<td>
								</td>
							</tr>
						</table>			
					</td>
				</tr>
			</table>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
			
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>
