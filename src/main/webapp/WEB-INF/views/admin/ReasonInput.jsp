<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴사유 입력</title>
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
        $("#reason_input").click(function() {
        	if(confirm("탈퇴처리하시겠습니까?"))
            var reason = $("#reason").val();
            // 부모 창으로 데이터 전송
            window.opener.postMessage(reason, '*'); // 변경된 부분: 데이터를 부모 창으로 전송
            window.close();
        });
    }

    
    </script>
</head>
<body>
    <table class="pop_table">
        <tr>
            <th colspan="2">탈퇴사유 입력<hr></th>
        </tr>
        <tr>
            <td>
	            <textarea id="reason" rows="10" cols="30"></textarea>
            </td>
        </tr>
        <tr>
            <td style="text-align: center;">
            <br><br>
                <input type="button" id="reason_input" value="탈퇴처리" class="mypage_delete_button">
            </td>
        </tr>
    </table>
</body>
</html>