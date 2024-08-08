<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
   <title>비밀번호변경완료</title>
   <link href="resources/css/title.css" type="text/css" rel="stylesheet">
   <link href="resources/css/user.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->

    <!-- 컨텐츠 시작 부분 -->
    <div id="head">비밀번호 변경 완료</div>
    <div id="main">
        <div id="pwc_ok_box">
                <div id="pwc_ok_textbox">
                    고객님의 비밀번호 변경이 완료되었습니다.
                </div>
                <br>
                <input type="button" id="pwc_ok_login" value="로그인하기" onclick="location.href='login.do'">
        </div>
    </div>
    <!-- 컨텐츠 끝 부분 -->

    <!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>