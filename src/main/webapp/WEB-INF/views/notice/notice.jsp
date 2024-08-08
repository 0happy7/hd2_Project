<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>힐링독(Healing Dog)</title>
<link rel="stylesheet" href="resources/css/title.css"/>		
<link href="resources/css/notice.css" rel="stylesheet">	
		    <!-- 헤더 부분  끝-->

				<!-- 컨텐츠 출력 되는곳 -------------------------- -->
			<table width="100%" align="center">
				<tr>
					<td style="text-align:center; border:0px;" >
						<h1  style="color: black; margin: 20px;">공지사항</h1>
						<hr>
				 	</td>  
				</tr>
				<tr>
					<td style="border:0;">
						<font size=4px>&nbsp;&nbsp;&nbsp;총 ${ nsearch.total }건 | 페이지 ${ nsearch.pageno } / ${ nsearch.maxpage }</font>
						<select name="searchname" style="margin-left:600px; width:100px; height:30px; font-size:20;">
							<option value="sena00">제목</option>
							<option value="sena01">작성자</option>
							<option value="sena02">내용</option>
						</select>
						<div class="search_box">
							<input type="text" class="search_text">
							<a href="trip.do"><img src="resources/img/search.png" class="search_img"></a>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align:center; border:0px;">
						<table border="0" width="100%" align="center">
							<tr>
								<td style="width:10%">
									<h3>번호</h3>
								</td>
								<td>
									<h3>제목</h3>
								</td>
								<td style="width:10%">
									<h3>작성자</h3>
								</td>
								<td style="width:20%">
									<h3>등록일</h3>
								</td>
							</tr>
							<c:forEach var="item" items="${ nlist }">
							<tr>
								<td>
									${ item.bno }
								</td>
								<td>									
									<a href="notice_view.do?no=${ item.bno }">${ item.bname }</a>
								</td>
								<td>
									${ item.name }
								</td>
								<td>
									${ item.bwdate }
								</td>
							</tr>
							</c:forEach>
						</table>									
					</td>
				</tr>				
			</table>	
			<table border="0" align="center">
				<tr>
					<td class="page" style="text-align:right; font-size:20px;">
						<div>
						<c:if test="${ nsearch.startbk > 10 }">
								<a href="notice.do?page=${ nsearch.startbk - 1 }&kind=${ nsearch.kind }">이전</a>
							</c:if>																
						<c:forEach var="page" begin="${ nsearch.startbk }" end="${ nsearch.endbk }">
							<c:if test="${page == nsearch.pageno }">
								<span style="color:red"><a href="notice.do?page=${ page }&kind=${ nsearch.kind }">${ page }</a></span>
							</c:if>
							<c:if test="${ page != nsearch.pageno }">
								<a href="notice.do?page=${ page }&kind=${ nsearch.kind }">${ page }</a>
							</c:if>								
						</c:forEach>
							<c:if test="${ nsearch.endbk < nsearch.maxpage }">
								<a href="notice.do?page=${ nsearch.endbk + 1 }&kind=${ nsearch.kind }">다음</a>
							</c:if>	
						</div>							
					</td>						
					<c:if test="${ nsearch.ugrade == '0' }">	
						<td style="text-align:center; font-size:20px; padding: 0 0 0 300px; border:0px;">
							<a href="notice_write.do"><input type="button" style="width:80px; height:40px; font-size:18px;" value="글쓰기"></a>
						</td>
					</c:if>
					<td style="border:0px;">
					
					</td>
				</tr>
			</table>
<jsp:include page="../include/tail.jsp" flush="true"/>
			<!-- 컨텐츠 출력 되는곳 -------------------------- -->