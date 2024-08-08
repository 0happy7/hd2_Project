<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>로그인</title>
<link href="resources/css/user.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->
<!-- 스크립트 부분 -->
<script>
window.onload = function()
{
	$("#id").focus();
	$("#id").val("skm77");
	$("#pw").val("1234");
	
	// id나 pw 입력창에 커서가 가있을때 enter를 통해 로그인 
	document.getElementById('id').onkeydown = function(e) {
        if (e.keyCode == 13) {
        	login();
        };
    };
	
	document.getElementById('pw').onkeydown = function(e) {
        if (e.keyCode == 13) {
        	login();
        };
    };
	
    // 버튼을 통한 로그인
	$("#login_submit").click(function(){
		login();
	});
}
function login(){
	if( $("#id").val() == "")
	{
		alert("아이디를 입력하세요.");
		$("#id").focus();
		return;
	}
	if( $("#pw").val() == "")
	{
		alert("비밀번호를 입력하세요.");
		$("#pw").focus();
		return;
	}
	$.ajax({
		url : "loginok.do",
		type : "post",
		data :
		{
			userid : $("#id").val(),
			userpw : $("#pw").val()
		},
		dataType : "html",
		success : function(response)
		{
			response = response.trim();
			if(response == "false")
			{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");	
			}else
			{
				document.location = "index.do";	
			}				
		}
	});
}
</script>
<!-- 스크립트 부분 끝 -->
    <!-- 컨텐츠 시작 부분 -->
<div id="head">로그인</div>
<div id="main">
    <div id="login_box">
        <form id="login_frm" method="post" action="loginok.do">
            <div id="login_input_box">
                <table style="width: 100%;">
                   <tr>
                       <td style="text-align: right;"><label for="id">아이디: </label></td>
                       <td><input type="text" id="id" name="userid" class="login_input"></td>
                   </tr>
                   <tr>
                       <td style="text-align: right;"><label for="pw">비밀번호: </label></td>
                        <td><input type="password" id="pw" name="userpw" class="login_input"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <div id="login_link">
                                <a href="find_id.do">아이디 찾기</a> |
                                <a href="find_pw.do">비밀번호 찾기</a> |
                                <a href="join.do">회원가입</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <br>
            <input type="button" id="login_submit" value="로그인하기">
        </form>
    </div>
</div>
<!-- 컨텐츠 끝 부분 -->

<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>