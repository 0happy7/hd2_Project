<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
   <title>비밀번호변경</title>
   <link href="resources/css/title.css" type="text/css" rel="stylesheet">
   <link href="resources/css/user.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->
<!-- 스크립트 부분 -->
<script>
window.onload = function()
{
	$("#pw_chang_submit").click(function(){
		if( $("#pw").val() == "")
		{
			alert("현재 비밀번호를 입력하세요.");
			$("#pw").focus();
			return;
		}
		if( $("#new_pw").val() == "")
		{
			alert("새로운 비밀번호를 입력하세요.");
			$("#new_pw").focus();
			return;
		}
		if( $("#new_pwc").val() == "")
		{
			alert("새로운 비밀번호 확인을 입력하세요.");
			$("#new_pwc").focus();
			return;
		}
		
		if( $("#new_pw").val() != $("#new_pwc").val())
		{
			alert("비밀번호 확인을 다르게 입력하셨습니다.");
			$("#new_pwc").focus();
			return;
		}
		
		$.ajax({
			url : "admin_check_ok.do",
			type : "post",
			data :
			{
				userno : $("#userno").val(),
				pw : $("#pw").val()
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
					if( confirm("비밀번호를 변경 하시겠습니까?") ){
						$("#pw_chang_form").submit();
					}
					
				}				
			}
		});
	});
}


</script>
<!-- 스크립트 부분 끝 -->
    <!-- 컨텐츠 시작 부분 -->
    <div id="head">비밀번호 변경</div>
    <div id="main">
        <div id="pw_chang">
            <form id="pw_chang_form" action="pw_update.do" method="post">
            <input style="display: none;" id="userno" name="userno" value="${login.userno}">
                <div id="pw_chang_input">
                    <table>
                        <tr>
                            <td style="text-align: right;"><label for="pw">현재 비밀번호:</label></td>
                            <td style="text-align: left;"><input type="password" id="pw" name="pw" class="pw_chang_input"></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;"><label for="new_pw">새로운 비밀번호:</label></td>
                            <td style="text-align: left;"><input type="password" id="new_pw" name="npw" class="pw_chang_input"></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;"><label for="pwc">비밀번호 확인:</label></td>
                            <td style="text-align: left;"><input type="password" id="new_pwc" name="new_pwc" class="pw_chang_input"></td>
                        </tr>
                    </table>
                </div>
                <br>
                <input type="button" id="pw_chang_submit" value="변경하기">
            </form>
        </div>
    </div>
    <!-- 컨텐츠 끝 부분 -->

    <!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>