<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../include/head.jsp" flush="true"/>
		<title>공지사항 글 보기</title>
		<link rel="stylesheet" href="resources/css/title.css"/>
		<link href="resources/css/notice_view.css" rel="stylesheet">
		    <!-- 헤더 부분  끝-->
				<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<script>
function DoDelete(bno)
{
	if(confirm("해당 게시물을 삭제하시겠습니까?") == false)
	{
		return;
	}
	document.location = "notice_delete.do?no=" + bno;
}
</script>
			<table width="100%" align="center">
				<tr>
					<td style="text-align:center; border:0px" >
						<a href=notice.do style="color: black; margin: 20px;"><h1>공지사항</h1></a>
						<hr>
				 	</td>  
				</tr>						
				<tr>
					<td style="border:0px;">
						<table border="0" width="100%" align="center">
							<tr>
								<td style="width:20%">
									제목
								</td>
								<td>
									${ item.bname }
								</td>
							</tr>
							<tr>
								<td>
									작성자
								</td>
								<td>
									${ item.name }
								</td>
							</tr>
							<tr>
								<td>
									내용
								</td>
								<td>								
									<c:forEach var="file" items="${item.files}">
									    <img src="${pageContext.request.contextPath}/resources/upload/${file.bpname}" alt="${file.bfname}" width="700" height="700">
									</c:forEach><br>
								    <pre>${ item.bcontent }</pre>
								</td>
							</tr>
						</table>
						<table>
							<tr>
								<td style="border:0">
								<c:if test="${ login.ugrade == 0 }">	
									<input type="button" value="수정" style="margin:0 0 0 850px; width:70px; height:30px; font-size:20px" onclick="location.href='notice_update.do?no=${ item.bno }'">
									<input type="button" value="삭제" style="margin:0 0 0 20px; width:70px; height:30px; font-size:20px" onclick="DoDelete(${ item.bno });">
									<input type="button" value="목록" style="margin:0 0 0 20px; width:70px; height:30px; font-size:20px" onclick="location.href='notice.do'">
								</c:if>
								<c:if test="${ login.ugrade != 0 }">
									<input type="button" value="목록" style="margin:0 0 0 930px; width:70px; height:30px; font-size:20px" onclick="location.href='notice.do'">
								</c:if>
								</td>					
							</tr>
						</table>
					</td>
				</tr>					
			</table>
<jsp:include page="../include/tail.jsp" flush="true"/>
			<!-- 컨텐츠 출력 되는곳 -------------------------- -->