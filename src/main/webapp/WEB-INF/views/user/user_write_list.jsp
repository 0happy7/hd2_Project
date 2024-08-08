<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/user_head.jsp" flush="true"/>
<title>마이페이지</title>
<script>
$(document).ready(function() {
    $("#board_del_btn").click(function() {
    	
		var len = $("input[name=board_del_check]:checked").length;
		
		if(len == 0)
		{
			alert("선택된 게시물이 없습니다.")
			return;
		}
		if(confirm("선택한 게시물을 삭제하시겠습니까?")){
			dropBoards();
		}
		
		
    });
});

function dropBoards(){

	var genreArray = new Array();
	
	$("input[name=board_del_check]:checked").each(function() {
		genreArray.push(this.value);
	});
	
	$.ajax({
	    url: "admin_boards_drop.do",
	    type: "post",
	    traditional: true,
	    data: {
	    	bno: genreArray
	    },
	    dataType: "html",
	    success: function(response) {
	        response = response.trim();
	        if (response == "true") {
	            alert("게시글 삭제 완료");
	            $.get(location.href, function(data) {
	                var newContent = $(data).find("#mypage_table_main");
	                $("#mypage_table_main").replaceWith(newContent);
	            });
	            $.get(location.href, function(data) {
	                var newContent = $(data).find("#allcheck");
	                $("#allcheck").replaceWith(newContent);
	            });
	            $.get(location.href, function(data) {
	                var newContent = $(data).find("#mypage_table_topbox");
	                $("#mypage_table_topbox").replaceWith(newContent);
	            });
	        }
	    }
	});
}

function submit(){
	$("#reg").submit();
}
	
</script>
<!-- 메인 내용 -->
<!-- 상단 페이지, 검색창 -->
<div id="mypage_table_topbox" class="mypage_table_topbox">
	<span>총 ${ search.total }건 | 페이지 ${ search.pageno }/${ search.maxpage }</span>
    <form id="reg" name="reg" method="get" action="">
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
<input type="checkbox" id="allcheck" onclick="checkAll(this)" style="margin-left: 30px;"/> 전체선택<br>
<table border="1" id="mypage_table_main" class="mypage_table_main">
    <tr>
        <th style="width: 5%;">선택</th>
        <th style="width: 15%;">글 작성 게시판</th>
        <th>글 제목</th>
        <th style="width: 15%;">작성일</th>
    </tr>
    <c:forEach var="list" items="${ list }">
	    <tr>
	        <td>
	            <input type="checkbox" id="board_del_check" name="board_del_check" class="chkbox" value="${ list.bno }">
	        </td>
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
<div class="mypage_table_button">
    <button id="board_del_btn">삭제</button>
</div>
					<div style="text-align: center;">
                        		<c:if test="${ search.startbk > 10 }">
									<a href="user_write_list.do?userno=${userno}&page=${search.startbk - 1}&searchname=${search.sena}&keyword=${search.keyword}">이전</a>
								</c:if>
								<c:forEach var="page" begin="${search.startbk}" end="${search.endbk}">
									<c:if test="${ page == search.pageno }">
										<a style="color:red" href="user_write_list.do?userno=${userno}&page=${ page }&searchname=${search.sena}&keyword=${search.keyword}">${ page }</a>
									</c:if>
									<c:if test="${ page != search.pageno }">
										<a href="user_write_list.do?userno=${userno}&page=${ page }&searchname=${search.sena}&keyword=${search.keyword}">${ page }</a>
									</c:if>	
								</c:forEach>
								<c:if test="${ search.endbk < search.maxpage }">
									<a href="user_write_list.do?userno=${userno}&page=${search.endbk + 1}&searchname=${search.sena}&keyword=${search.keyword}">다음</a>
								</c:if>
                    </div>

<!-- 메인 내용 끝 -->
            </td>
        </tr>

    </table>

</div>
<!-- 메인 영역 끝 -->
<jsp:include page="../include/tail.jsp" flush="true"/>