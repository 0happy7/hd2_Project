<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
   <title>비밀번호찾기</title>
   <link href="resources/css/title.css" type="text/css" rel="stylesheet">
   <link href="resources/css/user.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->

<!-- 스크립트 부분 -->
<script>
	window.onload = function()
	{
		$("#npw").focus();
		$("#find_pw_ok_form").submit(function (){
			if( $("#npw").val() == "" ){
				alert("비밀번호를 입력하세요");
				$("#npw").focus;
				return false;
			}
			if( $("#npwc").val() == "" ){
				alert("비밀번호확인을 입력하세요");
				$("#npwc").focus;
				return false;
			}
			// pw 입력값이 있는데, pwc 입력값과 다르면 중지
			if($("#npw").val() != $("#npwc").val())
			{
				alert("비번과 비번확인이 일치하지 않습니다");
				$("#npwc").val("");
				$("#npwc").focus();
				return false;
			}
			if( confirm("비밀번호를 변경 하시겠습니까?") ){
				return true;
			}
			return false;
		});
	}
</script>
<!-- 스크립트 부분 끝 -->
    <!-- 컨텐츠 시작 부분 -->
    <div id="head">비밀번호 변경</div>
    <div id="main">
        <div id="find_pw_ok">
             <form id="find_pw_ok_form" action="pw_update.do" method="post">
		        <input style="display: none;" name="userno" value="${userno}">
		            <div id="find_pw_ok_input">
		                <table>
		                    <tr>
		                        <td style="text-align: right;"><label for="pw">새로운 비밀번호: </label></td>
		                        <td style="text-align: left;"><input type="password" id="npw" name="npw" class="find_pw_ok_input"></td>
		                    </tr>
		                    <tr>
		                        <td style="text-align: right;"><label for="pwc">비밀번호 확인: </label></td>
		                        <td style="text-align: left;"><input type="password" id="npwc" name="npwc" class="find_pw_ok_input"></td>
		                    </tr>
		                </table>
		            </div>
            	<br>
            <input type="submit" id="find_pw_ok_next_submit" value="변경하기">
        </form>
        </div>
    </div>
    <!-- 컨텐츠 끝 부분 -->

    <!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>