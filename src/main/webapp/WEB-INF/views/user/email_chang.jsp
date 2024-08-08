<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
   <title>이메일변경</title>
   <link href="resources/css/title.css" type="text/css" rel="stylesheet">
   <link href="resources/css/user.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->
<!-- 스크립트 부분 -->
<script>
	let emailF = null;
	let checkCode_mail = "ERROR";
	window.onload = function()
	{
		$("#email").focus();
		
		$("input[name='nemail']").keyup(function(){
			checkemail();
		});

	};
	
	function DoChMail()
	{
		if( $("#email").val() == "" ){
			alert("현재 이메일을 입력하세요");
			$("#email").focus();
			return false;
		}
		if( $("#nemail").val() == "" ){
			alert("새로운 이메일을 입력하세요");
			$("#nemail").focus();
			return false;
		}
		// 코드 입력값이 없으면 중지
		if($("#email_num_check").val() == "")
		{
			alert("인증번호를 입력하세요");
			$("#email_num_check").focus();
			return;
		}
		
		// 메일 입력값이 바뀌면 중지
		if($("#nemail").val() != emailF)
		{
			alert("인증받은 메일주소가 아닙니다. 메일주소를 확인하세요");
			$("#email").focus();
			return;
		}
		
		if($("#email").val() != "${login.email}"){
			alert("현재 이메일이 올바르지 않습니다.");
			return;
		}
		$.ajax({
			url : "use_mail_check.do",
			type : "post",
			data :
			{	userno : $("#userno").val(),
				email : $("#email").val()
			},
			dataType : "html",
			success : function(response)
			{
				response = response.trim();
				if(response == "false")
				{
					alert("현재 이메일이 올바르지 않습니다.");
					$("#email").focus();
				}else
				{	
					$.ajax({
						type : "get",
						url: "getcode.do",
						dataType: "html",
						success : function(result) 
						{
							result = result.trim();
							if($("#email_num_check").val() == result)
							{
								if( confirm("이메일 변경을 하시겠습니까?") ){
									$("#email_chang_frm").submit();
								}
							}else
							{
								alert("인증코드가 일치하지 않습니다.");
								$("#email_num_check").focus();
							}
						}			
					});		
				}				
			}
		});
		return true;
	}
	
	const pattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;

	function emailValidChk(email) {
	    if(pattern.test(email) === false) { return false; }
	    else { return true; }
	}
	
	function checkemail()
	{
		// 중복검사 결과를 초기화
		checkCode_mail = "ERROR";
		// 메세지 박스를 초기화
		$("#email_msg").html("");
		// 입력값이 없으면 입력값을 넣도록 메세지 출력
		if($("#nemail").val() == "") { $("#email_msg").html("이메일이 입력되지 않았습니다"); }
		else{
			if( emailValidChk( $("#nemail").val() ) )
			{
				$.ajax({	// ajax 통신으로 DBMS에 id 조회를 요청
					url			: "emailcheck.do?email=" + $("#nemail").val(),
					type		: "get",
					dataType	: "html",
					success		: function(response){
						response = response.trim();
						console.log(response);
						// ajax로 받은 결과 코드를 플래그 변수에 넣습니다
						checkCode_mail = response;
						switch(response)
						{
						case "ERROR" :
							$("#email_msg").html("중복검사 오류가 발생했습니다");
							break;
						case "DUPLICATE" :
							$("#email_msg").html("중복된 이메일입니다");
							break;
						case "NOT_DUPLICATE" :
							$("#email_msg").html("사용 가능한 이메일입니다");
							break;
						}
					}
				});
			}else
			{
				$("#email_msg").html("이메일 형식으로 입력해주세요 (test@naver.com)");					
			}
		}
	}
	
	function SendMail() {
		if( $("#nemail").val() == "" ){
			alert("메일주소를 입력하세요");
			$("#nemail").focus();
			return;
		}
		if( emailValidChk( $("#nemail").val() ) == false ){
			alert("이메일 형식으로 입력해주세요 (test@naver.com)");
			$("#nemail").focus();
			return;
		}
		$("#email_msg").html("이메일 코드 전송 중...");
		
		$.ajax({	// ajax 통신으로 DBMS에 id 조회를 요청
			url			: "sendmail.do?email=" + $("#nemail").val(),
			type		: "get",
			dataType	: "html",
			success		: function(result){
				emailF = $("#nemail").val();
				result = result.trim();
				$("#email_msg").html(result);
				alert(result);
			}
		});
	}
</script>
<!-- 스크립트 끝 -->

<!-- 컨텐츠 시작 부분 -->
<div id="head">이메일 변경</div>
<div id="main"> 
    <div id="email_chang">
		<form id="email_chang_frm" action="email_change_ok.do" method="post">
			<input style="display: none;" id="userno" name="userno" value="${login.userno}">
		    <div id="email_chang_input_box">
		        <table>
		            <tr>
		                <td style="text-align: right;"><label for="email">현재 이메일: </label></td>
			            <td style="text-align: left;"><input type="text" id="email" name="email" class="email_chang_input"></td>
			            <td></td>
			        </tr>
			        <tr>
			            <td style="text-align: right;"><label for="email">새로운 이메일: </label></td>
			            <td>
			                <input type="text" id="nemail" name="nemail" class="email_chang_input">   
			            </td>
			            <td>
			                <input type="button" value="인증번호 받기" id="email_chang_num" onclick="SendMail();">   
			            </td>
			        </tr>
			        <tr>
			            <td></td>
			            <td><div id="email_msg" style="margin: 0px; width: 220px; height: 40px; text-align: left; font-size: 15px; line-height: normal;"></div></td>
			            <td></td>
			        </tr>
			        <tr>
			            <td style="text-align: right;"><label for="email_num_check">이메일 인증번호: </label></td>
			            <td style="text-align: left;">
			                <input type="text" id="email_num_check" name="email_num_check" class="email_chang_input" maxlength="5">          
			            </td>
			            <td></td>
			        </tr>
		    	</table>
			</div>
			<br>
		<input type="button" id="email_chang_submit" value="변경하기" onclick="DoChMail();">
		</form>
	</div>
</div>
<!-- 컨텐츠 끝 부분 -->

<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>