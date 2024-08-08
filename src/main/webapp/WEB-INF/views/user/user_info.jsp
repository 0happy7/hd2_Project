<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/user_head.jsp" flush="true"/>
<title>내정보</title>
<!-- 스크립트 부분 -->
<script>
window.onload = function()
{
	$("#user_delete_btn").click(function(){
		if(confirm("회원탈퇴를 하시겠습니까?") == true){
			  var popupW = 500;
			  var popupH = 250;
			  var left = Math.ceil((window.screen.width - popupW)/2);
			  var top = Math.ceil((window.screen.height - popupH)/2);
			  window.open('user_delete.do','','width='+popupW+',height='+popupH+',left='+left+',top='+top+',scrollbars=yes,resizable=no,toolbar=no,titlebar=no,menubar=no,location=no')
		}
		
	});
}
function PWchang() {
	if( confirm("비밀번호를 변경 하시겠습니까?") ){
		window.location.href = "pw_chang.do";
	}
}

function mailchang() {
	if( confirm("이메일을 변경 하시겠습니까?") ){
		window.location.href = "email_chang.do";
	}
}

function name_ch(){
	if( confirm("이름을 변경 하시겠습니까?") ){
		$("#name_ch").css("display", "none");
		$("#name_chok").css("display", "inline-block");
		$("#name").removeAttr("readonly");
		$("#name").focus();
	}

}

function name_chok(){
	if( confirm("이름을 변경 하시겠습니까?") ){
		$("#name_ch").css("display", "inline-block");
		$("#name_chok").css("display", "none");
		$("#name").attr("readonly",true);
		$("#name_frm").submit();
	}
}

</script>
<!-- 스크립트 끝 -->


                    <!-- 메인 내용 -->
                    <table id="mypage_table_info">
                        <tr>
                            <td>
                                <input type="text" id="id" name="id" value="${login.userid}" readonly class="mypage_input">
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" id="pw" name="pw" value="비밀번호" readonly class="mypage_input">
                            </td>
                            <td><input type="button" value="변경" id="pw_ch" class="mypage_chang_button" onclick="PWchang();"></td>
                        </tr>
                        <tr>
                             
                            <td>
                            <form id="name_frm" action="name_choku.do" method="post">
                            	<input style="display: none;" name="userno" value="${login.userno}">
                                <input type="text" id="name" name="uname" value="${login.uname}" readonly class="mypage_input">
                            </form>
                            </td>
                            <td>
                                <input type="button" value="변경" id="name_ch" class="mypage_chang_button" onclick="name_ch();">
                                <input type="button" style="display: none;" value="완료" id="name_chok" class="mypage_chang_button" onclick="name_chok();">
                            </td>
                            <tr>
                                <td>
                                    <input type="email" id="email" name="email" value="${login.email}" readonly class="mypage_input">
                                </td>
                                <td>
                                    <input type="button" value="변경" id="email_ch" class="mypage_chang_button" onclick="mailchang();">
                                </td>
                            </tr>
                            <tr>
                            	<td style="text-align: center;">
                            		<br>
                            		<input type="button" value="회원 탈퇴" id="user_delete_btn" class="mypage_delete_button">
                            	</td>
                            </tr>
                        </tr>
                    </table>
                    <!-- 메인 내용 끝 -->
                </td>
            </tr>

        </table>

    </div>

    <!-- 메인 영역 끝 -->
<jsp:include page="../include/tail.jsp" flush="true"/>