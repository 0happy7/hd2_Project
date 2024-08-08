<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
   <title>아이디찾기</title>
   <link href="resources/css/title.css" type="text/css" rel="stylesheet">
   <link href="resources/css/user.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->
    <!-- 컨텐츠 시작 부분 -->
    <div id="head">아이디 찾기</div>
    <div id="main">
        <div id="find_id_ok">
                <div id="find_id_ok_textbox">
	                <c:if test="${ findid != null }">
	                고객님의 정보와 일치하는 아이디는 ${findid.userid} 입니다.
	                </c:if>
	                <c:if test="${ findid == null }">
	                고객님의 정보와 일치하는 아이디가 존재하지 않습니다.
	                </c:if> 
                </div>
                <br>
                <input type="button" id="find_login" value="로그인 하기" onclick="location.href='login.do'"> &nbsp;&nbsp;
                <input type="button" id="find_pw" value="비밀번호 찾기" onclick="location.href='find_pw.do'">
        </div>
    </div>
    <!-- 컨텐츠 끝 부분 -->

    <!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>