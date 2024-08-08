<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/admin_head.jsp" flush="true"/>
<script>
window.onload = function()
{
	$("#user_del_btn").click(function(){
		if(confirm("유저를 탈퇴처리 하시겠습니까?") == true){
            var popupW = 500;
            var popupH = 350;
            var left = Math.ceil((window.screen.width - popupW) / 2);
            var top = Math.ceil((window.screen.height - popupH) / 2);
            var popup = window.open('ReasonInput.do', '', 'width=' + popupW + ',height=' + popupH + ',left=' + left + ',top=' + top + ',scrollbars=yes,resizable=no,toolbar=no,titlebar=no,menubar=no,location=no');

            // 새 창이 로드되고 난 후 실행될 콜백 함수
            $(popup).on('load', function() {
	                // 자식 창에서 데이터 받기
	                window.addEventListener('message', function(e) {
	                var reason = e.data; // 변경된 부분: 받은 데이터를 변수에 저장
	                console.log("Received Data:", reason);
	                delUser(reason);
                });
            });
		}
		
	});
}
function delUser(reason){
	var genreArray = new Array();
	
	//genreArray.push(this.value);

	
	$.ajax({
	    url: "admin_users_del.do",
	    type: "post",
	    traditional: true,
	    data: {
	    	reason: reason,
	        userno: ${user.userno}
	    },
	    dataType: "html",
	    success: function(response) {
	        response = response.trim();
	        if (response == "true") {
	            alert("탈퇴처리 완료")
	            document.location = 'admin_user.do';	
	        }
	    }
	});
}
</script>
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
                            <td><span>${user.adminmemo}</span></td>
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
                        <input type="button" value="수정" class="spage_button" onclick="location.href='admin_userpage_update.do?userno=${user.userno}'">
                        <input type="button" value="목록" class="spage_button" onclick="location.href='admin_user.do'">
                        <input type="button" value="탈퇴처리" id="user_del_btn" class="spage_button_user_delete">
                    </div>
                    <!-- 메인 내용 끝 -->
                </td>
            </tr>

        </table>

    </div>


    <!-- 메인 영역 끝 -->
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>