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
	$("#pw").focus()
	
	$("#mypage_check_submit").click(function(){
		pwcheck();
	});
	
	document.getElementById('pw').onkeydown = function(e) {
        if (e.keyCode == 13) {
        	pwcheck();
        };
    };
}
function pwcheck(){
	if( $("#pw").val() == "")
	{
		alert("비밀번호를 입력하세요.");
		$("#pw").focus();
		return;
	}
	$.ajax({
		url : "admin_check_ok.do",
		type : "post",
		data :
		{
			pw : $("#pw").val(),
			userno : $("#userno").val()
		},
		dataType : "html",
		success : function(response)
		{
			response = response.trim();
			if(response == "false")
			{
				alert("패스워드가 일치하지 않습니다.");	
			}else
			{
				document.location = "admin_notice.do";	
			}				
		}
	});
}
</script>
<!-- 스크립트 부분 끝 -->
    <!-- 컨텐츠 시작 부분 -->
    <div id="head">비밀번호 확인</div>
    <div id="main">
        <div id="mypage_check">
            <form id="mypage_check_frm" action="admin_check_ok.do" method="post" onsubmit="return false;">
            <input style="display: none;" id="userno" name="userno" value="${login.userno}">
                <div id="mypage_check_box">
                    <table style="width: 100%;">
                        <tr>
                            <td style="text-align: right;"><label for="pw">비밀번호: </label></td>
                            <td><input type="password" id="pw" name="pw" class="mypage_check_input"></label></td>
                        </tr>
                    </table>
                </div>
                <br>
                <input type="button" id="mypage_check_submit" value="확인">
            </form>
        </div>
    </div>
    <!-- 컨텐츠 끝 부분 -->
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>