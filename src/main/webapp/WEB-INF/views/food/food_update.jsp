<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>맛집 게시판 수정</title>
<link href="resources/css/title.css" type="text/css" rel="stylesheet">
<link href="resources/css/food_update.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->
<!-- <script type="text/javascript" src="../se2/js/HuskyEZCreator.js" charset="utf-8"></script> -->
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
		
		// 기존 파일이 있는 경우, 파일 첨부 input 숨기기
	    /*if ($("#uploadedFiles img").length > 0)
	    {
	        $("#attach").hide(); // 파일 첨부 input 숨기기
	    }*/
		
		// 파일 첨부 input의 값이 변경될 때 이벤트 처리
	    $("#attach").change(function() {
	        var files = $(this)[0].files;
	        if (files.length > 0) {
	            $("#uploadedFiles").empty(); // 기존 파일 보여주는 부분 초기화

	            // 선택된 파일 미리보기
	            for (var i = 0; i < files.length; i++) {
	                var reader = new FileReader();
	                reader.onload = function(e) {
	                    $("#uploadedFiles").append('<img src="' + e.target.result + '" width="200" height="200">');
	                }
	                reader.readAsDataURL(files[i]);
	            }
	        }
	    });
		
		$("#bname").focus();
		
		$("#food_update").click(function()
		{
			if($("#bname").val() == "")
			{
				alert("제목을 입력하세요");
				$("#bname").focus();
				return false;	
			}
			if($("#addr").val() == "")
			{
				alert("주소를 확인해서 넣어주세요.");
				return false;
			}
			if($("#food_tel1").val() == "")
			{
				alert("전화번호 앞에를 입력하세요");
				$("#food_tel1").focus();
				return false;	
			}
			if($("#food_tel2").val() == "")
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
			
			// 기존 파일이 없고, 새로운 파일도 첨부하지 않은 경우
	        if ($("#uploadedFiles img").length == 0 && $("#attach")[0].files.length == 0) {
	            alert("파일을 첨부하세요");
	            return false;
	        }
			
			if(confirm("게시물을 저장하시겠습니까?") == false)
			{
				return;
			}
			$("#modifyFrm").submit();
		});
		
		
	}
	</script>
    <!-- 컨텐츠 시작 부분 -->
    <div id="head"><a href="food.do">댕댕이 맛집 게시판</a></div>
    <div id="main">
        <form id="modifyFrm" name="modifyFrm" method="post" action="food_updateok.do" enctype="multipart/form-data">
        <input type="hidden" id="bno" name="bno" value="${item.bno }">
            <table border="1" id="food_update_table">
                <tr>
                    <td class="food_update_table_td" style="height: 70px;">*식당명</td>
                    <td>
                        <input type="text" id="bname" name="bname" value=${ item.bname }>
                    </td>
                </tr>
                <tr>
                    <td class="food_update_table_td" style="height: 70px;">*주소</td>
                    <td>
                        <input type="button" value="주소 찾기" id="addrsearch" name="addrsearch">
                       <input type="text" readonly id="addr" name="addr" style="width:84%;height:60%;" value="${ item.addr }">
                    </td>
                </tr>
                <tr>
                    <td class="food_update_table_td" style="height: 70px;">*전화번호</td>
                    <td>
                        <select id="tel" name="tel" style="width:70px; height:30px; font-size:20;">
							<option id="tel" value="063">063</option>
							<option id="tel" value="010">010</option>
						</select>
                        -
                        <input type="text" id="tel1" name="tel1" maxlength="4" value=${ item.tel1 }>
                        -
                        <input type="text" id="tel2" name="tel2" maxlength="4" value=${ item.tel2 }>
                    </td>
                </tr>
                <tr>
                    <td class="food_update_table_td" style="height: 70px;">영업시간</td>
                    <td>
                        <input type="time" id="btime1" name="btime1" value=${ item.btime1 }> ~
                        <input type="time" id="btime2" name="btime2" value=${ item.btime2 }>
                        <span style="font-size:14px; color:gray;">(입력 예 : 오전 09:00 ~ 오후 18:00)</span>
                    </td>
                </tr>
                <tr>
                    <td class="food_update_table_td">*내용</td>
                    <td>
                        <textarea name="bcontent" id="bcontent" cols="140" rows="35">${item.bcontent }</textarea>
                    </td>
                </tr>
                <tr>
				    <td rowspan="3" class="food_update_table_td" style="height: 50px;">*사진 첨부</td>
				    <td id="uploadedFiles">
				        <c:forEach var="file" items="${item.files}">
				            <img src="${pageContext.request.contextPath}/resources/upload/${file.bpname}" alt="${file.bfname}" width="200" height="200">
				        </c:forEach>
				    </td>
				</tr>
				<tr>
				    <td>
				        <input id="attach" name="attach" type="file" multiple="multiple">
				    </td>
				</tr>


            </table>
            <br>
            <div id="food_update_button">
                <input type="button" value="수정 완료" class="food_update" id="food_update" name="food_update">&nbsp;&nbsp;
                <input type="button" value="취소" class="food_update" onclick="location.href='food_view.do?no=${item.bno}'">
            </div>
        </form>
    </div>
    <!-- 컨텐츠 끝 부분 -->

<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>