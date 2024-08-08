<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>관리자페이지</title>
<link rel="stylesheet" href="resources/css/title.css"/>
<link rel="stylesheet" href="resources/css/mypage.css"/>
<!-- 헤더 부분  끝-->
<!-- 스크립트 부분 -->
<script>
	window.onload = function()
	{	
		$("#update_btn").click(function(){
			if( confirm("수정을 하시겠습니까?") ){
				updateUser();
			}
			
		});
	}
	function updateUser(){
		$.ajax({
		    url: "admin_update_user.do",
		    type: "post",
		    data: {
				userno : ${user.userno},
				adminmemo : $("#adminmemo").val()
		    },
		    dataType: "html",
		    success: function(response) {
		        response = response.trim();
		        if (response == "true") {
		        	alert("수정완료");
		        	document.location = 'admin_userpage.do?userno=' + ${user.userno};	
		        }
		    }
		});
	}
	
</script>
    <div id="head">관리자페이지</div>
    <!-- 메인 영역 시작 -->
    <div id="main">
        <table class="mypage_table">
            <tr>
                <td class="mypage_table_ftd">
                    <a href="admin_notice.jsp">공지사항</a><br><br>
                    <a href="admin_info.jsp">관리자 정보</a><br><br>
                    <a href="admin_order.jsp">주문 관리</a><br><br>
                    <ul>
                        <li class="mypage_table_li">상품 관리</li>
                        <ul>
                            <li class="mypage_table_uli"><a href="admin_productAll.jsp">전체상품</a></li>
                            <li class="mypage_table_uli"><a href="admin_product_write.jsp">상품등록</a></li>
                        </ul>
                    </ul>
                    <br>
                    <ul>
                        <li class="mypage_table_li" style="color: orange;">회원 관리</li>
                        <ul>
                            <li class="mypage_table_uli"><a href="admin_user.jsp" style="font-weight: bold;">전체회원</a></li>
                            <li class="mypage_table_uli"><a href="admin_userX.jsp">탈퇴회원</a></li>
                        </ul>
                    </ul>
                    <br><br>
                    <a href="admin_board.jsp">게시판</a>
                </td>
                <td class="mypage_table_maintd">
                    <!-- 메인 내용 -->
                    <!-- 상단 -->
                    <div class="mypage_table_topbox">
                        <div class="mypage_table_topbox_usertext">주문상세내역</div>
                    </div>

                    <div class="mypage_table_topbox_user_list">회원기본정보</div>
                    <table border="1" class="spage_userpage_table">
                        <tr>
                            <th>아이디</th>
                            <td><span>${user.userid}</span></td>
                        </tr>
                        <tr>
                            <th>성명</th>
                            <td><span>${user.uname}</span></td>
                        </tr>
                        <tr>
                            <th>성별</th>
                            <td><span>
                                <c:if test="${ user.gender == 'm' }">
								남성
								</c:if>
								<c:if test="${ user.gender == 'f' }">
								여성
								</c:if>
                            </span></td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td><span>${user.email}</span></td>
                        </tr>
                        <tr>
                            <th>관리자메모</th>
                            <td>
                            <input type="hidden" id="userno" name="userno" value="${user.userno}">
                            <input type="text" id="adminmemo" name="adminmemo" value="${user.adminmemo}">
                            </td>
                        </tr>

                    </table>
                    <br>
                    <div class="mypage_table_topbox_user_list">주문 내역</div>
                    <table border="1" class="spage_userpage_order_table">
                        <tr>
                            <th>번호</th>
                            <th>주문번호</th>
                            <th>상품 정보</th>
                            <th>가격</th>
                            <th>수량</th>
                            <th>총구매금액</th>
                            <th>주문상태</th>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>202407010001</td>
                            <td>강아지사료</td>
                            <td>15000</td>
                            <td>1</td>
                            <td>15000</td>
                            <td>상품준비중</td>
                        </tr>
                    </table>
                    <div class="spage_button_box">
                        <input type="button" value="완료" id="update_btn" name="update_btn" class="spage_button">
                        <input type="button" value="취소" class="spage_button" onclick="location.href='admin_userpage.do?userno=${user.userno}'">
                    </div>
                    <!-- 메인 내용 끝 -->
                </td>
            </tr>

        </table>

    </div>


    <!-- 메인 영역 끝 -->
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>