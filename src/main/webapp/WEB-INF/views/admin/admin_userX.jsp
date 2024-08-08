<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/admin_head.jsp" flush="true"/>
<!-- 스크립트 부분 -->
<script>
$(document).ready(function() {
    $("#user_del_btn").click(function() {
		var len = $("input[name=user_del_check]:checked").length;
		
		if(len == 0)
		{
			alert("선택된 유저가 없습니다.")
			return;
		}
		
		if(confirm("유저를 삭제하시겠습니까?")){
			dropUsers();
		}
		
    });
    $("#user_restore_btn").click(function() {
		var len = $("input[name=user_del_check]:checked").length;
		
		if(len == 0)
		{
			alert("선택된 유저가 없습니다.")
			return;
		}
		
		if(confirm("유저를 복구하시겠습니까?")){
			restoreUsers();
		}
		
    });
    
});

	function dropUsers(){

		var genreArray = new Array();
		
		$("input[name=user_del_check]:checked").each(function() {
			genreArray.push(this.value);
		});
		
		$.ajax({
		    url: "admin_users_drop.do",
		    type: "post",
		    traditional: true,
		    data: {
		        userno: genreArray
		    },
		    dataType: "html",
		    success: function(response) {
		        response = response.trim();
		        if (response == "true") {
		            alert("유저 삭제처리 완료");
		            $.get(location.href, function(data) {
		                var newContent = $(data).find("#mypage_table_main");
		                $("#mypage_table_main").replaceWith(newContent);
		            });
		            $.get(location.href, function(data) {
		                var newContent = $(data).find("#allcheck");
		                $("#allcheck").replaceWith(newContent);
		            });
		            
		        }
		    }
		});
	}
	
	function dropUser(no){
		if(confirm("유저를 삭제하시겠습니까?")){
	 		$.ajax({
			    url: "admin_users_drop.do",
			    type: "post",
			    traditional: true,
			    data: {
			        userno: no
			    },
			    dataType: "html",
			    success: function(response) {
			        response = response.trim();
			        if (response == "true") {
			            alert("유저 삭제처리 완료");
			            $.get(location.href, function(data) {
			                var newContent = $(data).find("#mypage_table_main");
			                $("#mypage_table_main").replaceWith(newContent);
			            });
			            $.get(location.href, function(data) {
			                var newContent = $(data).find("#allcheck");
			                $("#allcheck").replaceWith(newContent);
			            });
			            
			        }
			    }
			}); 
		}
	}
	
	function restoreUsers(){

		var genreArray = new Array();
		
		$("input[name=user_del_check]:checked").each(function() {
			genreArray.push(this.value);
		});
		
		$.ajax({
		    url: "admin_users_restore.do",
		    type: "post",
		    traditional: true,
		    data: {
		        userno: genreArray
		    },
		    dataType: "html",
		    success: function(response) {
		        response = response.trim();
		        if (response == "true") {
		            alert("유저 복원 완료");
		            $.get(location.href, function(data) {
		                var newContent = $(data).find("#mypage_table_main");
		                $("#mypage_table_main").replaceWith(newContent);
		            });
		            $.get(location.href, function(data) {
		                var newContent = $(data).find("#allcheck");
		                $("#allcheck").replaceWith(newContent);
		            });
		            
		        }
		    }
		});
	}
	
	function restoreUser(no){
		if(confirm("유저를 복구하시겠습니까?")){
			$.ajax({
			    url: "admin_users_restore.do",
			    type: "post",
			    traditional: true,
			    data: {
			        userno: no
			    },
			    dataType: "html",
			    success: function(response) {
			        response = response.trim();
			        if (response == "true") {
			            alert("유저 복원 완료");
			            $.get(location.href, function(data) {
			                var newContent = $(data).find("#mypage_table_main");
			                $("#mypage_table_main").replaceWith(newContent);
			            });
			            $.get(location.href, function(data) {
			                var newContent = $(data).find("#allcheck");
			                $("#allcheck").replaceWith(newContent);
			            });
			            
			        }
			    }
			}); 
		}
	}
	function submit(){
		$("#reg").submit();
	}
	
</script>
<!-- 스크립트 부분 끝 -->
                    <!-- 메인 내용 -->
                    <!-- 상단 페이지, 검색창 -->
                    <div class="mypage_table_topbox">
                        <span>총 ${ search.total }건 | 페이지 ${ search.pageno }/${ search.maxpage }</span>
                            <form id="reg" name="reg" method="get" action="">
                                <span class="search_box">
                                    <select id="searchname" name="searchname">
                                        <option value="I"
                                        <c:if test="${ search.searchname == 'I' }">
                                        selected
                                        </c:if>
                                        >아이디</option>
                                        <option value="N"
                                        <c:if test="${ search.searchname == 'N' }">
                                        selected
                                        </c:if>
                                        >이름</option>
                                    </select>
                                    <span class="search_input_box">
                                        <input type="text" id="keyword" name="keyword" value="${ search.keyword}" class="search_text">
                                        <a href="javascript:submit();"><img src="resources/img/search.png" class="search_img"></a>
                                    </span>
                                </span>
                            </form>
                    </div>
                    <br>
                    <!-- 글 목록 -->
                    <input type="checkbox" id="allcheck" onclick="checkAll(this)" style="margin-left: 20px;"/>전체선택<br>
                    <table border="1" id="mypage_table_main" class="mypage_table_main">
                        <tr>
                            <th style="width: 4%;">선택</th>
                            <th style="width: 5%;">번호</th>
                            <th style="width: 20%;">성명</th>
                            <th style="width: 15%;">아이디</th>
                            <th style="width: 20%;">해지사유</th>
                            <th>탈퇴일</th>
                            <th style="width: 15%;">설정</th>
                        </tr>
                        <c:set var="seqno" value="${ search.total - ((search.pageno - 1) * 10) + 1 }"></c:set>
                        <c:forEach var="userlist" items="${ userlist }">
                        <tr>
                            <td>
                                <input type="checkbox" class="chkbox" id="user_del_check" name="user_del_check" value="${userlist.userno}">
                            </td>
                            <td style="vertical-align: middle;">${ seqno = seqno - 1 }</td>
                            <td>${ userlist.uname }</td>
                            <td>${ userlist.userid }</td>
                            <td>${ userlist.reason }</td>
                            <td>${ userlist.withdrawaldate }</td>
                            <td>
                                <a href="javascript:restoreUser(${ userlist.userno });" style="font-size: 15px;">복원</a><br>
                                <a href="javascript:dropUser(${ userlist.userno });" style="font-size: 15px;">삭제</a>
                            </td>
                        </tr>
                        </c:forEach>
                    </table>
                    <br>
                    <div class="mypage_table_button">
                        <button id="user_restore_btn">복원</button>
                        <button id="user_del_btn">삭제</button>
                    </div>
					<div style="text-align: center;">
                        		<c:if test="${ search.startBk > 10 }">
									<a href="admin_userX.do?page=${search.startBk - 1}&searchname=${search.searchname}&keyword=${search.keyword}">이전</a>
								</c:if>
								<c:forEach var="page" begin="${search.startBk}" end="${search.endBk}">
									<c:if test="${ page == search.pageno }">
										<a style="color:red" href="admin_userX.do?page=${ page }&searchname=${search.searchname}&keyword=${search.keyword}">${ page }</a>
									</c:if>
									<c:if test="${ page != search.pageno }">
										<a href="admin_userX.do?page=${ page }&searchname=${search.searchname}&keyword=${search.keyword}">${ page }</a>
									</c:if>	
								</c:forEach>
								<c:if test="${ search.endBk < search.maxpage }">
									<a href="admin_userX.do?page=${search.endBk + 1}&searchname=${search.searchname}&keyword=${search.keyword}">다음</a>
								</c:if>
                    </div>

                    <!-- 메인 내용 끝 -->
                </td>
            </tr>

        </table>

    </div>
    <!-- 메인 영역 끝 -->
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>