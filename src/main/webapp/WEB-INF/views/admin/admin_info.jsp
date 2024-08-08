<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/admin_head.jsp" flush="true"/>

<!-- 스크립트 부분 -->
<script>

function PWchang() {
	if( confirm("비밀번호를 변경 하시겠습니까?") ){
		window.location.href = "pw_chang.do";
	}
}

function name_ch(){
	if( confirm("이름을 변경 하시겠습니까?") ){
		$("#name_ch").css("display", "none");
		$("#name_chok").css("display", "inline-block");
		$("#name").removeAttr("readonly");
		$("#name").focus();
	}

}

function name_chok(){
	if( confirm("이름을 변경 하시겠습니까?") ){
/* 		$.ajax({
			url : "name_change.do",
			type : "post",
			data :
			{
				userno : ${login.userno},
				uname : $("#name").val()
			},
			dataType : "html",
			success : function(response)
			{
			}
		}); */
		$("#name_ch").css("display", "inline-block");
		$("#name_chok").css("display", "none");
		$("#name").attr("readonly",true);
		$("#name_frm").submit();
	}
}

</script>
<!-- 스크립트 끝 -->
                    <!-- 메인 내용 -->
                    <table id="mypage_table_info">
                        <tr>
                            <td>
                                <input type="text" id="id" name="id" value="${login.userid}" readonly class="mypage_input">
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" id="pw" name="pw" value="비밀번호" readonly class="mypage_input">
                            </td>
                            <td><input type="button" value="변경" id="pw_ch" class="mypage_chang_button" onclick="PWchang();"></td>
                        </tr>
                        <tr>
                             
                            <td>
							<form id="name_frm" action="name_chok.do" method="post">
								<input style="display: none;" name="userno" value="${login.userno}">
                            	<input type="text" id="name" name="uname" value="${login.uname}" readonly class="mypage_input">
							</form>
                            </td>
                            <td>
                                <input type="button" value="변경" id="name_ch" class="mypage_chang_button" onclick="name_ch();">
                                <input type="button" style="display: none;" value="완료" id="name_chok" class="mypage_chang_button" onclick="name_chok();">
                            </td>
                           
                        </tr>
                    </table>
                    <!-- 메인 내용 끝 -->
                </td>
            </tr>
        </table>
    </div>

    <!-- 메인 영역 끝 -->
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>