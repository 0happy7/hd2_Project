<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
	
<title>댕댕이게시판 글 보기</title>
<link href="resources/css/food_write.css" type="text/css" rel="stylesheet">
<link href="resources/css/food.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/title.css"/>	    
<ul class="right">
    <!-- ID를 추가하여 JavaScript에서 접근 가능하게 함 -->
	<li><a id="writeListLink" href="#">쓴 글</a></li>
</ul>
<c:set var="count" value="4" scope="page" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function(){
        //Show contextmenu:
        $('.writer').contextmenu(function(e){
            //Get window size:
            var winWidth = $(document).width();
            var winHeight = $(document).height();
            //Get pointer position:
            var posX = e.pageX;
            var posY = e.pageY;
            //Get contextmenu size:
            var menuWidth = $(".right").width();
            var menuHeight = $(".right").height();
            //Security margin:
            var secMargin = 10;
            //Prevent page overflow:
            if(posX + menuWidth + secMargin >= winWidth
            && posY + menuHeight + secMargin >= winHeight){
              //Case 1: right-bottom overflow:
              posLeft = posX - menuWidth - secMargin + "px";
              posTop = posY - menuHeight - secMargin + "px";
            }
            else if(posX + menuWidth + secMargin >= winWidth){
              //Case 2: right overflow:
              posLeft = posX - menuWidth - secMargin + "px";
              posTop = posY + secMargin + "px";
            }
            else if(posY + menuHeight + secMargin >= winHeight){
              //Case 3: bottom overflow:
              posLeft = posX + secMargin + "px";
              posTop = posY - menuHeight - secMargin + "px";
            }
            else {
              //Case 4: default values:
              posLeft = posX + secMargin + "px";
              posTop = posY + secMargin + "px";
            };
            //Display contextmenu:
            $(".right").css({
              "left": posLeft,
              "top": posTop
            }).show();
            //Prevent browser default contextmenu.
            return false;
        });
        //Hide contextmenu:
        $(document).click(function(){
            $(".right").hide();
        });

        // Update link with userno when context menu is triggered
        $('.writer').contextmenu(function(e) {
            var userno = $(this).data('userno'); // get userno from data attribute
            var link = $('#writeListLink'); // get the link element
            link.attr('href', 'username_write_list.do?userno=' + userno); // update href with userno
            return false; // prevent default context menu
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
        var url = 'food.do';

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
<!-- 헤더 부분 끝-->
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<table width="100%" align="center">
    <tr>
        <td style="position: relative;">
            <h1 class="main_image_text" style="font-size:25px; width:100%; position: absolute; left: 480px">댕댕이맛집 : 강아지들과 함께 먹을 수 있는 식당에 대한 게시판입니다.</h1>						
            <table>
                <tr>
                    <td>
                        <div class="main_image11">		
                            <img src="resources/img/food_board1.jpg" width=400px height=400px>							
                        </div>
                    </td>					
                    <td>
                        <div class="main_image22">
                            <img src="resources/img/food_board2.jpg" width=400px height=400px>
                        </div>
                    </td>					
                    <td>
                        <div class="main_image33">
                            <img src="resources/img/food_board3.jpg" width=400px height=400px>
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
        <td class="foodnotice">
            <a href="notice_view.do?no=4"><h4><img src="resources/img/blueicon2.png" width=30px height=30px>댕댕이맛집 공지 : 댕댕이와 갈 수 있는 음식점사진 및 글만 작성해주세요. 자세한 정보는 클릭하여 확인 바랍니다.(공지사항 게시판 이동)</h4></a>
        </td>	
    </tr>
    <tr>
        <td>
            <form id="reg" name="reg" method="get" action="food.do">
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
                            <a href="food_view.do?no=${item.bno}">
                                <div class="image-box">
                                    <c:set var="firstFile" value="${item}" />
                                    <img src="${pageContext.request.contextPath}/resources/upload/${firstFile.bpname}" alt="${firstFile.bfname}" width="200px" height="150px">
                                </div>
                                <div class="text-box">
                                    <h4>${item.bname}</h4>
                                    <span>${item.addr}</span><br>
                                    <span>${item.tel}-${item.tel1}-${item.tel2}</span>
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
                        <a href="food.do?page=${ search.startbk - 1 }&kind=${ search.kind }">이전</a>
                    </c:if>																
                <c:forEach var="page" begin="${ search.startbk }" end="${ search.endbk }">
                    <c:if test="${page == search.pageno }">
                        <span style="color:red"><a href="food.do?page=${ page }&kind=${ search.kind }">${ page }</a></span>
                    </c:if>
                    <c:if test="${ page != search.pageno }">
                        <a href="food.do?page=${ page }&kind=${ search.kind }">${ page }</a>
                    </c:if>								
                </c:forEach>
                    <c:if test="${ search.endbk < search.maxpage }">
                        <a href="food.do?page=${ search.endbk + 1 }&kind=${ search.kind }">다음</a>
                    </c:if>								
                    </td>
                    <td>									
                    </td>
                    <c:if test="${ sessionScope.login != null }">
                        <td style="text-align:center; font-size:20px;">
                            <a href="food_write.do"><input type="button" style="width:80px; height:40px; font-size:18px;" value="글쓰기"></a>
                        </td>
                    </c:if>
                    <td>
                    </td>
                </tr>
            </table>			
        </td>
    </tr>
</table>				
<jsp:include page="../include/tail.jsp" flush="true"/>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
