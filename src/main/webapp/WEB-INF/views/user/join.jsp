<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>회원가입</title>
<link href="resources/css/user.css" type="text/css" rel="stylesheet">
<!-- 헤더 부분  끝-->
<!-- 스크립트 영역  -->
<script type="text/javascript">

// id, email 중복검사 결과를 담아놓을 플래그 변수
let checkCode_id = "ERROR";
let checkCode_mail = "ERROR";

// 인증번호 받은 메일인지 확인
let emailF = null;

window.onload = function(){
	
	// id입력창 객체를 찾는다
	var objs = document.getElementsByName("userid");
	// 이 페이지가 로딩되면, id 입력창으로 커서를 이동한다
	objs[0].focus();
	
	// id 입력창 입력값을 체크
	$("input[name='userid']").keyup(function(){
		checkid();
	});
	
	// email 입력창 입력값을 체크
	$("input[name='email']").keyup(function(){
		checkemail();
	});
};

const idpattern = /[ㄱ-ㅎ가-힣ㅏ-ㅣ]+/;

function idValidChk(id)
{
    if(idpattern.test(id) === true)
    {
    	return false;
    }
    else
    {
    	return true;
    }
}

function checkid()
{
	// 중복검사 결과를 초기화
	checkCode_id = "ERROR";
	// 메세지 박스를 초기화
	$("#id_msg").html("");
	// 입력값이 없으면 입력값을 넣도록 메세지 출력
	if($("#id").val() == "") { $("#id_msg").html("아이디가 입력되지 않았습니다"); }
	// 입력값이 4글자 이상이면 id중복 체크 ajax 호출
	if($("#id").val().length > 3 && idValidChk( $("#id").val()))
	{
		$.ajax({	// ajax 통신으로 DBMS에 id 조회를 요청
			url			: "idcheck.do?id=" + $("#id").val(),
			type		: "get",
			dataType	: "html",
			success		: function(response){
				response = response.trim();
				console.log(response);
				// ajax로 받은 결과 코드를 플래그 변수에 넣습니다
				checkCode_id = response;
				switch(response)
				{
				case "ERROR" :
					$("#id_msg").html("중복검사 오류가 발생했습니다");
					break;
				case "DUPLICATE" :
					$("#id_msg").html("중복된 아이디입니다");
					break;
				case "NOT_DUPLICATE" :
					$("#id_msg").html("사용 가능한 아이디입니다");
					break;
				}
			}
		});
	}
	
	else if($("#id").val().length < 4)
	{
		$("#id_msg").html("4글자 이상 입력해주세요");					
	}
	else
	{
		$("#id_msg").html("한글은 입력하실 수 없습니다.");
	}
}

// 이메일 형식 검사 코드 및 함수
const pattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;

function emailValidChk(email) {
    if(pattern.test(email) === false) { return false; }
    else { return true; }
}

// 메일 체크 함수
function checkemail()
{
	// 중복검사 결과를 초기화
	checkCode_mail = "ERROR";
	// 메세지 박스를 초기화
	$("#email_msg").html("");
	// 입력값이 없으면 입력값을 넣도록 메세지 출력
	if($("#email").val() == "") { $("#email_msg").html("이메일이 입력되지 않았습니다"); }
	// 이메일 형식이 맞으면 email중복 체크 ajax 호출
	if( emailValidChk( $("#email").val() ) )
	{
		$.ajax({	// ajax 통신으로 DBMS에 id 조회를 요청
			url			: "emailcheck.do?email=" + $("#email").val(),
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




function DoJoin()
{
	// id 입력값이 없으면 메세지 출력하고 submit 중지
	if($("#id").val() == "")
	{
		alert("아이디를 입력하세요");
		$("#id").focus();
		return;
	}
	// pw 입력값이 없으면 중지
	if($("#pw").val() == "")
	{
		alert("비번을 입력하세요");
		$("#pw").focus();
		return;
	}
	// pwc 입력값이 없으면 중지
	if($("#pwc").val() == "")
	{
		alert("비번확인을 입력하세요");
		$("#pwc").focus();
		return;
	}
	// pw 입력값이 있는데, pwc 입력값과 다르면 중지
	if($("#pw").val() != $("#pwc").val())
	{
		alert("비번과 비번확인이 일치하지 않습니다");
		$("#pwc").val("");
		$("#pwc").focus();
		return;
	}
	
	// 이름 입력값이 없으면 중지
	if($("#name").val() == "")
	{
		alert("이름을 입력하세요");
		$("#name").focus();
		return;
	}
	
	// id가 중복이거나, 중복검사가 ERROR이면 중지
	if(checkCode_id == "ERROR")
	{
		alert("ID중복검사 오류상태입니다");
		$("#id").val("");
		$("#id").focus();
		return;
	}
	
	if(checkCode_id == "DUPLICATE")
	{
		alert("중복된 ID입니다. 회원가입을 진행할 수 없습니다");
		$("#id").val("");
		$("#id").focus();
		return;
	}

	// 메일 입력값이 없으면 중지
	if($("#email").val() == "")
	{
		alert("메일주소를 입력하세요");
		$("#email").focus();
		return;
	}
	
	// 메일이 중복이거나, 중복검사가 ERROR이면 중지
	if(checkCode_mail == "ERROR")
	{
		alert("이메일 중복검사 오류상태입니다");
		$("#email").val("");
		$("#email").focus();
		return;
	}
	if(checkCode_mail == "DUPLICATE")
	{
		alert("중복된 이메일입니다. 회원가입을 진행할 수 없습니다");
		$("#email").val("");
		$("#email").focus();
		return;
	}
	
	// 코드 입력값이 없으면 중지
	if($("#code").val() == "")
	{
		alert("코드를 입력하세요");
		$("#code").focus();
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
			if($("#code").val() == result)
			{
				if( confirm("회원가입을 진행하시겠습니까?") ){
					$("#joinfrm").submit();
				}
			}else
			{
				alert("인증코드가 일치하지 않습니다.");
				$("#code").focus();
			}
		}			
	});			
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

<!-- 메인 컨텐츠 시작 부분 -->
<div id="head">회원가입</div>
<div id="main">
    <form id="joinfrm" name="joinfrm" method="POST" action="joinok.do">
        <table id="join_table">
            <tr>
                <td>
                    <input type="text" id="id" name="userid" class="join_input" placeholder="[필수]아이디를 입력하세요">
                </td>
                <td rowspan="6">

                </td>
            </tr>
            <tr>
                <td>
                    <input type="password" id="pw" name="userpw" class="join_input" placeholder="[필수]비밀번호를 입력하세요">
                </td>
            </tr>
            <tr>
                <td>
                    <input type="password" id="pwc" name="pwc" class="join_input" placeholder="[필수]비밀번호 확인을 입력하세요">
                </td>
            </tr>
            <tr>
                <td>
                    <div id="id_msg">아이디가 중복되었습니다</div>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="name" name="uname" class="join_input" placeholder="[필수]이름을 입력하세요">
                </td>
            </tr>
            <tr>
                <td>
                    <div id="gender_box">
                        <label><input type="radio" name="gender" value="m">남성</label>&nbsp&nbsp&nbsp
                        <label><input type="radio" name="gender" value="f">여성</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="email" id="email" name="email" class="join_input" placeholder="[필수]이메일을 입력하세요">
                </td>
                <td>
                    <input type="button" value="인증번호 받기" id="email_num" onclick="SendMail();">
                </td>
            </tr>
            <tr>
                <td>
                    <div id="email_msg">이메일이 중복되었습니다</div>
                </td>
                <td rowspan="3">

                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="code" name="code" class="join_input" placeholder="인증번호 입력" maxlength="5">
                </td>
            </tr>
            <tr>
                <td style="height: 150px; text-align: center;">
                    <input id="submitButton" type="button" value="가입하기" onclick="DoJoin();">
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 메인 컨텐츠 끝 -->

<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>