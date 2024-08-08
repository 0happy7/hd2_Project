<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <script src="resources/js/jquery-3.7.1.js"></script>
  <script src="resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
  <link href="resources/css/title.css" type="text/css" rel="stylesheet">
</head>
<body>
  <!-- 헤더 부분  시작-->
  <div id="container">    
    <div id="title">
        <a href="index.do" id="main_title_a"><div id="main_title"><img src="resources/img/logo.png" width="30px"> 힐링독 <img src="resources/img/logo.png" width="30px"></div></a>
        <div id="menu">
	        <c:if test="${ sessionScope.login == null }">
	        	<div style="visibility: hidden;">[OOO]님이 로그인하셨습니다.</div>
	        	<div id="login_menu"><a href="join.do"><div id="join">회원가입</div></a> <a href="login.do"><div id="login">로그인</div></a></div>
	        </c:if>
	        <c:if test="${ sessionScope.login != null }">
	        	<div>[${login.uname}]님이 로그인하셨습니다.</div>
	        	<div id="loout_menu">
	        	<c:if test="${ login.ugrade == '0' }">
	        		<a href="admin_check.do"><div id="mypage">관리자페이지</div></a>
	        	</c:if>
	        	<c:if test="${ login.ugrade == '1' }">
	        		<a href="user_write_list.do"><div id="mypage">마이페이지</div></a>
	        	</c:if>
	        	<a href="logout.do" onclick="return confirm('로그아웃 하시겠습니까?');"><div id="logout">로그아웃</div></a></div>
	        </c:if>
        </div>
    </div>
  <nav>
        <div id="menubar">
            <ul>
                <li><a href="trip.do">댕댕이여행지</a></li>
                <li><a href="food.do">댕댕이맛집</a></li>
                <li><a href="shop_food.do">댕댕이쇼핑몰</a>
                    <ul class="submenu">
                        <li class="submenuLink"><a href="shop_food.do">댕댕이음식</a></li>
                        <li class="submenuLink"><a href="shop_things.do">댕댕이용품</a></li>
                        <li class="submenuLink"><a href="shop_clothes.do">댕댕이옷</a></li>
                    </ul>
                </li>
                <li><a href="notice.do">공지사항</a></li>
            </ul>
        </div>
  </nav>