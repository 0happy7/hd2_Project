<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>맛집 게시판 글쓰기</title>
<link href="resources/css/title.css" type="text/css" rel="stylesheet">
<link href="resources/css/food_write.css" type="text/css" rel="stylesheet">
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
		
		$("#food_write").click(function()
		{
			if($("#bname").val() == "")
			{
				alert("제목을 입력하세요");
				$("#bname").focus();
				return false;	
			}
			if($("#tel1").val() == "")
			{
				alert("전화번호 앞에를 입력하세요");
				$("#food_tel1").focus();
				return false;	
			}
			if($("#tel2").val() == "")
			{
				alert("전화번호 뒤에를 입력하세요");
				$("#food_tel2").focus();
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
    <div id="head"><a href="food.do">댕댕이 맛집 게시판</a></div>
    <div id="main">
       <form id="writeFrm" name="writeFrm" method="post" action="food_writeok.do" enctype="multipart/form-data">
	    <input type="hidden" id="bkind" name="bkind" value="F">
            <table border="1" id="food_write_table">
                <tr>
                    <td class="food_write_table_td" style="height: 70px;">*식당명</td>
                    <td>
                        <input type="text" placeholder="식당명을 입력하세요" id="bname" name="bname">
                    </td>
                </tr>
                <tr>
                    <td class="food_write_table_td" style="height: 70px;">*주소</td>
                    <td>
                        <input type="button" value="주소 찾기" id="addrsearch" name="addrsearch" class="addrsearch">
                        <input type="text" readonly id="addr" name="addr" style="width:84%;height:60%;">
                    </td>
                </tr>
                <tr>
                    <td class="food_write_table_td" style="height: 70px;">*전화번호</td>
                    <td>
                        <select id="tel" name="tel" style="width:70px; height:30px; font-size:20;">
							<option id="tel" value="063">063</option>
							<option id="tel" value="010">010</option>
						</select>
                        -
                        <input type="text" id="tel1" name="tel1" maxlength="4">
                        -
                        <input type="text" id="tel2" name="tel2" maxlength="4">
                    </td>
                </tr>
                <tr>
                    <td class="food_write_table_td" style="height: 70px;">영업시간</td>
                    <td>
                        <input type="time" id="btime1" name="btime1"> ~
                        <input type="time" id="btime2" name="btime2">
                        <span style="font-size:14px; color:gray;">(입력 예 : 오전 09:00 ~ 오후 18:00)</span>
                    </td>
                </tr>
                <tr>
                    <td class="food_write_table_td">*내용</td>
                    <td>
                        <textarea name="bcontent" id="bcontent" cols="140" rows="35"></textarea>
                    </td>
                </tr>   
                <tr>
                    <td rowspan="3" class="food_write_table_td" style="height: 50px;">*사진첨부</td>
                    <td>
                        <input id="attach" name="attach" type="file" multiple="multiple">
                    </td>
                </tr>


            </table>
            <br>
            <div id="food_write_button">
                <input type="button" value="글쓰기 완료" class="food_write" id="food_write" name="food_write">&nbsp;&nbsp;
                <input type="button" value="취소" class="food_write" onclick="location.href='food.do'">
            </div>
        </form>
    </div>
    <!-- 컨텐츠 끝 부분 -->

    <!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>