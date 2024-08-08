<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="resources/css/mypage.css"/>
    <script src="resources/js/jquery-3.7.1.js"></script>
    <style>
    	.pop_table{
    		margin: auto;
    		width: 300px
    	}
    	.pop_table th{
			font-size: 20px;
    	}
    	.pop_table td{
    		text-align: center;
    		font-weight: bolder;
    	}
    </style>
    
    <script>
    window.onload = function()
    {
    	$("#user_delete_btn").click(function(){
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
   						if( confirm("회원탈퇴를 하시겠습니까?") ){
   							delete_user();
   						}
   					}				
   				}
   			}); 
    	});
    }
    function delete_user(){
    	$.ajax({
				url : "user_deleteOK.do",
				type : "post",
				data :
				{	userno : $("#userno").val()
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
						window.opener.location = "user_deleteOK.do"
	   					window.open('','_self').close();
					}				
				}
			}); 
    }
    
    
    </script>
</head>
<body>
    <table class="pop_table">
        <tr>
            <th colspan="2">비밀번호 확인<hr></th>
        </tr>
        <tr>
        	<td>비밀번호 : </td>
            <td>
            <form action="admin_check_ok.do" method="post">
	            <input style="display: none;" id="userno" name="userno" value="${login.userno}">
	            <input type="password" id="pw" name="pw">
            </form>    	
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
            <br><br>
                <input type="button" id="user_delete_btn" value="탈퇴하기" class="mypage_delete_button">
            </td>
        </tr>
    </table>
</body>
</html>