<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>댕댕이게시판 글 보기</title>
<link href="resources/css/trip_view.css" rel="stylesheet">	
<link rel="stylesheet" href="resources/css/title.css"/>
<!-- 헤더 부분  끝-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function DoDelete(bno)
{
	if(confirm("해당 게시물을 삭제하시겠습니까?") == false)
	{
		return;
	}
	document.location = "trip_delete.do?no=" + bno;
		
}

//댓글 추가
function AddReply()
{
	if($("#rcontent").val() == "")
	{
		alert("내용을 입력하세요");
		$("#rcontent").focus();
		return false;	
	}
	
	if(confirm("댓글을 등록하시겠습니까?") == false)
	{
		return;
	}
	$.ajax({
		url : "trip_replyok.do",
		 type : "post",
		 data:
		 {
		 	bno : $("#bno").val(),
		 	runame : $("#runame").val(),
		 	rcontent : $("#rcontent").val()
		 },
		 dataType : "html",
		 success : function(response)
		 {
		 	response = response.trim();
		 	alert(response);
		 	document.location.reload();	 		
		 }
	});
}

function ReplyDelete(rno)
{
	if(confirm("해당 댓글을 삭제하시겠습니까?") == false)
	{
		return;
	}
	
	$.ajax({
		url : "trip_replydeleteok.do?rno=" + rno,
		 type : "get",
		 dataType : "html",
		 success : function(response)
		 {
		 	response = response.trim();
		 	alert(response);
		 	document.location.reload();	 		
		 }
	});
}
</script>

			<!-- 컨텐츠 출력 되는곳 -------------------------- -->
			<table width="100%" align="center">
				<tr>
					<td style="text-align:center; border:0px" >
						<a href=trip.do style="color: black; margin: 20px;"><h1>댕댕이 여행지 게시판</h1></a>
						<hr>
				 	</td>  
				</tr>						
				<tr>
					<td style="border:0px;">
						<table border="0" width="100%" align="center">
							<tr>
								<td>
									여행지명
								</td>
								<td colspan="5">
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
								<td>
									등록일
								</td>
								<td>
									${ item.bwdate }
								</td>
								<td>
									조회수
								</td>
								<td>
									${ item.bhit }
								</td>
							</tr>
							<tr>
								<td>
									주소
								</td>
								<td colspan="5">
									${ item.addr }
								</td>
							</tr>
							<tr>
								<td>
									내용
								</td>
								<td colspan="5">
									<c:forEach var="file" items="${item.files}">
									    <img src="${pageContext.request.contextPath}/resources/upload/${file.bpname}" alt="${file.bfname}" width="400" height="400">
									    <br>
									</c:forEach><br>
									<pre>${ item.bcontent }</pre>
								</td>
							</tr>
						</table>
						<table>
							<tr>
								<td style="text-align:left; padding:0 0 0 20px; border:0px solid;"><b><font size=12px;>댓글</font>
								<c:if test="${ sessionScope.login != null}">
									<c:if test="${ login.userno == item.userno || login.ugrade == 0}">	
									<input type="button" value="수정" style="margin:0 0 0 795px; width:70px; height:30px; font-size:20px" onclick="location.href='trip_update.do?no=${ item.bno }'">
									<input type="button" value="삭제" style="margin:0 0 0 20px; width:70px; height:30px; font-size:20px" onclick="DoDelete(${ item.bno });">
									<input type="button" value="목록" style="margin:0 0 0 20px; width:70px; height:30px; font-size:20px" onclick="location.href='trip.do'">
									</c:if>
								</c:if>
								<c:if test="${ sessionScope.login == null || login.userno != item.userno  }">
									<c:if test="${ login.ugrade != 0 }">
										<input type="button" value="목록" style="margin:0 0 0 835px; width:70px; height:30px; font-size:20px" onclick="location.href='trip.do'">
									</c:if>
								</c:if>
								</td>					
							</tr>
							<tr>
								<td style="border:0px solid;">
								</td>
							</tr>
							<tr>
								<td style="text-align:left; padding:0 0 0 20px; border:0px solid;" >
								<c:if test="${ sessionScope.login != null }">
									<input type="text" value="${login.uname }" id="runame" name="runame" readonly style="width:150px; height:28px;">
									<input type="text" id="rcontent" name="rcontent" style="width:900px; height:28px;">
									<input type="hidden" id="bno" name="bno" value="${ item.bno }">
									<input type="button" value="등록" onclick="AddReply();" style="width:70px; height:30px; font-size:20px;">
								</c:if>
								</td>
							</tr>
						</table>
						<table border="1" width="100%" align="center">
							<tr>
								<td width=10%>
									<h4>댓글 작성자</h4>
								</td>
								<td width=70%>
									<h4>내용</h4>
								</td>
								<td>
									<h4>댓글날짜</h4>
								</td>
							</tr>
							<c:forEach var="reply" items="${reply}">
					        <tr>
					            <td width="10%">
					                ${reply.runame }
					            </td>
					            <td width="70%">
					                ${reply.rcontent }
					            </td>
					            <td>
					                ${reply.rwdate }
					                <c:if test="${ login.userno == reply.ruserno || login.ugrade == 0}">
					                	<input type="button" value="삭제" onclick="ReplyDelete(${reply.rno });">
					                </c:if>
					            </td>
					        </tr>
					    </c:forEach>
						</table>
					</td>
				</tr>				
			</table>
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>
			<!-- 컨텐츠 출력 되는곳 -------------------------- -->
			