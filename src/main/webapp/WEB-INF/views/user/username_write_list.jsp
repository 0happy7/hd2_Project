<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
   <title>마이페이지</title>
   <link href="resources/css/title.css" type="text/css" rel="stylesheet">
   <link rel="stylesheet" href="resources/css/mypage.css"/>

<script>

function submit(){
	$("#reg").submit();
}
</script>
<!-- 헤더 부분  끝-->
    <div id="head">${username}님의 게시글</div>
    <!-- 메인 영역 시작 -->
    <div id="main">
		    <!-- 메인 내용 -->
                    <!-- 상단 페이지, 검색창 -->
                    <div class="mypage_table_topbox">
                        <span>총 ${ search.total }건 | 페이지 ${ search.pageno }/${ search.maxpage }</span>
                            <form id="reg" name="reg" method="get" action="">
                            	<input type="hidden" name="userno" value="${userno}">
                                <span class="search_box">
                                    <select id="searchname" name="searchname">
                                    	<c:if test="${ search.sena == 'sena01' }">
	                                        <option value="sena01" selected>제목</option>
	                                        <option value="sena02">내용</option>
	                                    </c:if>
	                                    <c:if test="${ search.sena == 'sena02' }">
	                                        <option value="sena01">제목</option>
	                                        <option value="sena02" selected>내용</option>
	                                    </c:if>
	                                    <c:if test="${ search.sena == '' }">
	                                        <option value="sena01">제목</option>
	                                        <option value="sena02">내용</option>
	                                    </c:if>
	                                    

                                    </select>
                                    <span class="search_input_box">
                                        <input type="text" id="keyword" name="keyword" value="${ search.keyword}" class="search_text">
                                        <a href="javascript:submit();"><img src="resources/img/search.png" class="search_img"></a>
                                    </span>
                                </span>
                            </form>
                    </div>
                    <br>
                    <!-- 글 목록 -->
                    <table border="1" class="mypage_table_main">
                        <tr>
                            <th style="width: 15%;">글 작성 게시판</th>
                            <th>글 제목</th>
                            <th style="width: 15%;">작성일</th>
                        </tr>
                        <c:forEach var="list" items="${ list }">
                        <tr>
                      		<c:if test="${ list.bkind == 'F' }">
								<td>댕댕이 맛집</td>
							</c:if>
                            <c:if test="${ list.bkind == 'T' }">
								<td>댕댕이 여행지</td>
							</c:if>
                            <td>
                            <c:if test="${ list.bkind == 'F' }">
								<a href="food_view.do?no=${ list.bno }">${list.bname }</a>
							</c:if>
                            <c:if test="${ list.bkind == 'T' }">
								<a href="trip_view.do?no=${ list.bno }">${list.bname }</a>
							</c:if>
                            </td>
                            <td>${list.bwdate }</td>
                        </tr>
                        </c:forEach>
                        
                    </table>
                    <br>
					<div style="text-align: center;">
                        		<c:if test="${ search.startbk > 10 }">
									<a href="username_write_list.do?userno=${userno}&page=${search.startbk - 1}&searchname=${search.sena}&keyword=${search.keyword}">이전</a>
								</c:if>
								<c:forEach var="page" begin="${search.startbk}" end="${search.endbk}">
									<c:if test="${ page == search.pageno }">
										<a style="color:red" href="username_write_list.do?userno=${userno}&page=${ page }&searchname=${search.sena}&keyword=${search.keyword}">${ page }</a>
									</c:if>
									<c:if test="${ page != search.pageno }">
										<a href="username_write_list.do?userno=${userno}&page=${ page }&searchname=${search.sena}&keyword=${search.keyword}">${ page }</a>
									</c:if>	
								</c:forEach>
								<c:if test="${ search.endbk < search.maxpage }">
									<a href="username_write_list.do?userno=${userno}&page=${search.endbk + 1}&searchname=${search.sena}&keyword=${search.keyword}">다음</a>
								</c:if>
                    </div>


                    <!-- 메인 내용 끝 -->

    </div>
    <!-- 메인 영역 끝 -->
<jsp:include page="../include/tail.jsp" flush="true"/>