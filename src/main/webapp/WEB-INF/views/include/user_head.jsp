<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="resources/css/title.css" type="text/css" rel="stylesheet">
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
    <div id="head">마이페이지</div>
    <!-- 메인 영역 시작 -->
    <div id="main">
        <table class="mypage_table">
            <tr>
                <td class="mypage_table_ftd">
                    <a href="user_write_list.do"
                    	<c:if test="${ adminpage == 'W' }">
	                     style="color: orange;"
	                    </c:if>
                    >내가 쓴 글</a><br><br>
                    <a href="user_order_list.do"
                        <c:if test="${ adminpage == 'O' }">
	                     style="color: orange;"
	                    </c:if>
                    >주문 내역</a><br><br>
                    <a href="user_check.do"
                        <c:if test="${ adminpage == 'M' }">
	                     style="color: orange;"
	                    </c:if>
                    >내 정보</a><br><br>
                </td>
                <td class="mypage_table_maintd">