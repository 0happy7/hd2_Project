<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>댕댕이게시판 글 보기</title>
<link href="resources/css/trip_write.css" type="text/css" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="resources/css/title.css"/>
<!-- 헤더 부분  끝-->
	<script type="text/javascript" src="../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	window.onload = function()
	{
		document.getElementById("addrsearch").addEventListener("click", function(){ //주소입력칸을 클릭하면
	        //카카오 지도 발생
	        new daum.Postcode({
	            oncomplete: function(data) { //선택시 입력값 세팅
	                document.getElementById("addr").value = data.address; // 주소 넣기
	                
	            }
	        }).open();
	    });
		
		$("#bname").focus();
		
		$("#trip_write").click(function()
		{
			if($("#bname").val() == "")
			{
				alert("제목을 입력하세요");
				$("#bname").focus();
				return false;	
			}
			if($("#bcontent").val() == "")
			{
				alert("내용을 입력하세요");
				$("#bcontent").focus();
				return false;	
			}
			
			if($("#attach").val() == "")
			{
				alert("파일을 첨부하세요");
				return false;	
			}
			
			if(confirm("게시물을 저장하시겠습니까?") == false)
			{
				return;
			}
			$("#writeFrm").submit();
		});
	}
	</script>
	
    <!-- 컨텐츠 시작 부분 -->
    <div id="head"><a href="trip.do">댕댕이 여행지 게시판</a></div>
    <div id="main">
	    <form id="writeFrm" name="writeFrm" method="post" action="trip_writeok.do" enctype="multipart/form-data">
	    <input type="hidden" id="bkind" name="bkind" value="T">
            <table border="1" id="trip_write_table">
                <tr>
                    <td class="trip_write_table_td" style="height: 70px;">*여행지명</td>
                    <td>
                        <input type="text" placeholder="여행지명을 입력하세요" id="bname" name="bname">
                    </td>
                </tr>
                <tr>
                    <td class="trip_write_table_td" style="height: 70px;">*주소</td>
                    <td>
                        <input type="button" value="주소 찾기" id="addrsearch" name="addrsearch">
                        <input type="text" readonly id="addr" name="addr" style="width:84%;height:60%;">
                    </td>
                </tr>
                <tr>
                    <td class="trip_write_table_td">*내용</td>
                    <td>
                        <textarea name="bcontent" id="bcontent" cols="140" rows="35"></textarea>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" class="trip_write_table_td" style="height: 50px;">*사진 첨부</td>
                    <td>
                        <input id="attach" name="attach" type="file" multiple="multiple">
                    </td>
                </tr>


            </table>
            <br>
            <div id="trip_write_button">
                <input type="button" value="글쓰기 완료" id="trip_write" name="trip_write" class="trip_write">&nbsp;&nbsp;
                <input type="button" value="취소" class="trip_write" onclick="location.href='trip.do'">
            </div>
        </form>
    </div>
    <!-- 컨텐츠 끝 부분 -->

<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>