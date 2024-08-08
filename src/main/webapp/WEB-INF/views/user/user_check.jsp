<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/user_head.jsp" flush="true"/>
<title>마이페이지</title>
<!-- 스크립트 부분 -->
<script>
window.onload = function()
{
	$("#mypage_check_submit").click(function(){
		pwcheck();
	});
	
	document.getElementById('pw').onkeydown = function(e) {
        if (e.keyCode == 13) {
        	pwcheck();
        };
    };
}
function pwcheck(){
	if( $("#pw").val() == "")
	{
		alert("비밀번호를 입력하세요.");
		$("#pw").focus();
		return;
	}
	$.ajax({
		url : "admin_check_ok.do",
		type : "post",
		data :
		{	userno : $("#userno").val(),
			pw : $("#pw").val()
		},
		dataType : "html",
		success : function(response)
		{
			response = response.trim();
			if(response == "false")
			{
				alert("패스워드가 일치하지 않습니다.");	
			}else
			{
				document.location = "user_info.do";	
			}				
		}
	});
}
</script>

                <!-- 메인 내용 -->
 <div id="mypage_check">
           <form id="mypage_check_frm" action="admin_check_ok.do" method="post" onsubmit="return false;">
               <input style="display: none;" id="userno" name="userno" value="${login.userno}">
               <div id="mypage_check_box">
                   <table style="width: 100%;">
                       <tr>
                           <td style="text-align: right;"><label for="pw">비밀번호: </label></td>
                           <td><input type="password" id="pw" name="pw" class="mypage_check_input"></label></td>
                       </tr>
                   </table>
               </div>
               <br>
               <input type="button" id="mypage_check_submit" value="확인">
           </form>
       </div>
                <!-- 메인 내용 끝 -->
            </td>
        </tr>

    </table>

</div>

    <!-- 메인 영역 끝 -->
<jsp:include page="../include/tail.jsp" flush="true"/>