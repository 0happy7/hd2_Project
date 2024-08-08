<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>아이디찾기</title>
<link href="resources/css/title.css" type="text/css" rel="stylesheet">
<link href="resources/css/user.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->
<!-- 스크립트 부분 -->
<script>
	let emailF = null;
	window.onload = function()
	{
		$("#name").focus();
		
		$("input[name='email']").keyup(function(){
			checkemail();
		});

	};
	
	function DoFindID()
	{
		if( $("#name").val() == "" ){
			alert("이름을 입력하세요");
			$("#name").focus();
			return false;
		}
		if( $("#email").val() == "" ){
			alert("이메일을 입력하세요");
			$("#email").focus();
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
		if($("#email").val() != emailF)
		{
			alert("인증받은 메일주소가 아닙니다. 메일주소를 확인하세요");
			$("#email").focus();
			return;
		}
		
		$.ajax({
			type : "get",
			url: "getcode.do",
			dataType: "html",
			success : function(result) 
			{
				result = result.trim();
				if($("#email_num_check").val() == result)
				{
					if( confirm("아이디 찾기를 진행하시겠습니까?") ){
						$("#find_id_frm").submit();
					}
				}else
				{
					alert("인증코드가 일치하지 않습니다.");
					$("#email_num_check").focus();
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
		// 메세지 박스를 초기화
		$("#email_msg").html("");
		// 입력값이 없으면 입력값을 넣도록 메세지 출력
		if($("#email").val() == "") { $("#email_msg").html("이메일이 입력되지 않았습니다"); }
		else{
			// 입력값이 4글자 이상이면 id중복 체크 ajax 호출
			if( emailValidChk( $("#email").val() ) )
			{
				$("#email_msg").html("인증번호 받기를 진행해주세요");				
			}else
			{
				$("#email_msg").html("이메일 형식으로 입력해주세요 (test@naver.com)");					
			}
		}
	}
	
	function SendMail() {
		if( $("#email").val() == "" ){
			alert("메일주소를 입력하세요");
			$("#email").focus();
			return;
		}
		if( emailValidChk( $("#email").val() ) == false ){
			alert("이메일 형식으로 입력해주세요 (test@naver.com)");
			$("#email").focus();
			return;
		}
		$("#email_msg").html("이메일 코드 전송 중...");
		
		$.ajax({	// ajax 통신으로 DBMS에 id 조회를 요청
			url			: "sendmail.do?email=" + $("#email").val(),
			type		: "get",
			dataType	: "html",
			success		: function(result){
				emailF = $("#email").val();
				result = result.trim();
				$("#email_msg").html(result);
				alert(result);
			}
		});
	}
</script>
<!-- 스크립트 끝 -->
    <!-- 컨텐츠 시작 부분 -->
    <div id="head">아이디 찾기</div>
    <div id="main"> 
        <div id="find_pw_box">
            <form id="find_id_frm" action="find_id_ok.do" method="post">
                <div id="find_id_input_box">
                    <table>
                        <tr>
                            <td style="text-align: right;"><label for="name">이름: </label></td>
                            <td style="text-align: left;"><input type="text" id="name" name="uname" class="find_id_input"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;"><label for="email">이메일: </label></td>
                            <td>
                                <input type="text" id="email" name="email" class="find_id_input">   
                            </td>
                            <td>
                                <input type="button" value="인증번호 받기" id="email_num" onclick="SendMail();">   
                            </td>
                        </tr>
                        <tr>
                        	<td></td>
                        	<td><div id="email_msg" style="margin: 0px; width: 220px; height: 40px; text-align: left; font-size: 15px; line-height: normal;"></div></td>
                        	<td></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;"><label for="email_num_check">인증번호: </label></td>
                            <td style="text-align: left;">
                                <input type="text" id="email_num_check" name="email_num_check" class="find_id_input" maxlength="5">
                            </td>
                            <td></td>
                        </tr>

                    </table>
                </div>
                <br>
                <input type="button" id="next_submit" value="다음" onclick="DoFindID();">
            </form>
        </div>
    </div>
    <!-- 컨텐츠 끝 부분 -->

    <!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>