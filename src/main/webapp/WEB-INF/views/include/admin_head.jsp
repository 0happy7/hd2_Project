<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>관리자페이지</title>
<link rel="stylesheet" href="resources/css/title.css"/>
<link rel="stylesheet" href="resources/css/mypage.css"/>
<!-- 헤더 부분  끝-->
<script>
    function checkAll(el){
        const checkBoxes  = document.querySelectorAll('.chkbox');
        checkBoxes.forEach((row)=>{
            row.checked = el.checked;
        })
    }
</script>
    <div id="head">관리자페이지</div>
    <!-- 메인 영역 시작 -->
    <div id="main">
        <table class="mypage_table">
            <tr>
                <td class="mypage_table_ftd">	
                    <a href="admin_notice.do"
	                    <c:if test="${ adminpage == 'N' }">
	                     style="color: orange;"
	                    </c:if>
                    >공지사항</a><br><br>
                    <a href="admin_info.do"
                    	<c:if test="${ adminpage == 'A' }">
	                     style="color: orange;"
	                    </c:if>
                    >관리자 정보</a><br><br>
                    <a href="admin_order.do"
                        <c:if test="${ adminpage == 'O'}">
	                     style="color: orange;"
	                    </c:if>
                    >주문 관리</a><br><br>
                    <ul>
                        <li class="mypage_table_li"
	                         <c:if test="${ adminpage == 'P1' || adminpage == 'P2' }">
		                     style="color: orange;"
	                    </c:if>
                        >상품 관리</li>
                        <ul>
                            <li class="mypage_table_uli"><a href="admin_productAll.do"
	                            <c:if test="${ adminpage == 'P1' }">
	                            style="font-weight: bold;"
	                            </c:if>
                            >전체상품</a></li>
                            <li class="mypage_table_uli"><a href="admin_product_write.do"
	                            <c:if test="${ adminpage == 'P2' }">
	                            style="font-weight: bold;"
	                            </c:if>
                            >상품등록</a></li>
                        </ul>
                    </ul>
                    <br>
                    <ul>
                        <li class="mypage_table_li"
                        <c:if test="${ adminpage == 'U1' || adminpage == 'U2' }">
	                     style="color: orange;"
	                    </c:if>
                        >회원 관리</li>
                        <ul>
                            <li class="mypage_table_uli"><a href="admin_user.do"
                            	<c:if test="${ adminpage == 'U1' }">
	                            style="font-weight: bold;"
	                            </c:if>
                            >전체회원</a></li>
                            <li class="mypage_table_uli"><a href="admin_userX.do"
                                <c:if test="${ adminpage == 'U2' }">
	                            style="font-weight: bold;"
	                            </c:if>
                            >탈퇴회원</a></li>
                        </ul>
                    </ul>
                    <br><br>
                    <a href="admin_board.do"
                   		<c:if test="${ adminpage == 'B' }">
	                     style="color: orange;"
	                    </c:if>
                    >게시판</a>
                </td>
                <td class="mypage_table_maintd">