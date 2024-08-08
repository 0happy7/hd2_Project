<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/admin_head.jsp" flush="true"/>
                    <!-- 메인 내용 -->
                    <!-- 상단 페이지, 검색창 -->
                    <div class="mypage_table_topbox">
                        <span>총 ${ search.total }건 | 페이지 ${ search.pageno }/${ search.maxpage }</span>
                            <form id="reg" name="reg" method="get" action="">
                                <span class="search_box">
                                    <select id="searchname" name="searchname">
                                    	<c:if test="${ search.searchname == 'N' }">
		                                    <option value="N" selected>주문자</option>
	                                        <option value="O">주문번호</option>
	                                        <option value="P">상품명</option>
	                                    </c:if>
	                                    <c:if test="${ search.searchname == 'O' }">
		                                    <option value="N">주문자</option>
	                                        <option value="O" selected>주문번호</option>
	                                        <option value="P">상품명</option>
	                                    </c:if>
	                                    <c:if test="${ search.searchname == 'P' }">
		                                    <option value="N">주문자</option>
	                                        <option value="O">주문번호</option>
	                                        <option value="P" selected>상품명</option>
	                                    </c:if>
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
                    <input type="checkbox" onclick="checkAll(this)" style="margin-left: 25px;"/> 전체선택<br>
                    <table border="1" class="mypage_table_main">
                        <tr>
                            <th style="width: 4%;">선택</th>
                            <th style="width: 15%;">주문일시</th>
                            <th style="width: 15%;">주문번호</th>
                            <th style="width: 10%;">주문자</th>
                            <th style="width: 20%;">주문상품</th>
                            <th style="width: 5%;">수량</th>
                            <th>금액</th>
                            <th style="width: 13%;">결제수단</th>
                            <th style="width: 13%;">주문상태</th>
                        </tr>
                        <c:forEach var="orderlist" items="${ orderlist }">
                        <tr>
                            <td>
                                <input type="checkbox" class="chkbox" value="1">
                            </td>
                            <td>${ orderlist.odate }</td>
                            <td><a href="admin_orderpage.do?orderno=${ orderlist.orderno }">${ orderlist.ordernum }</a></td>
                            <td>${ orderlist.uname }</td>
                            <td>${ orderlist.iname }</td>
                            <td>${ orderlist.oitemcnt }</td>
                            <td>${ orderlist.lpayprice }</td>
                            <td>${ orderlist.payment }</td>
                            <td>${ orderlist.status }</td>
                        </tr>
                        </c:forEach>
                    </table>
                    <br>
                    <div class="mypage_table_button">
                        <button>삭제</button>
                    </div>
					<div style="text-align: center;">
                        		<c:if test="${ search.startBk > 10 }">
									<a href="admin_order.do?page=${search.startBk - 1}&searchname=${search.searchname}&keyword=${search.keyword}">이전</a>
								</c:if>
								<c:forEach var="page" begin="${search.startBk}" end="${search.endBk}">
									<c:if test="${ page == search.pageno }">
										<a style="color:red" href="admin_order.do?page=${ page }&searchname=${search.searchname}&keyword=${search.keyword}">${ page }</a>
									</c:if>
									<c:if test="${ page != search.pageno }">
										<a href="admin_order.do?page=${ page }&searchname=${search.searchname}&keyword=${search.keyword}">${ page }</a>
									</c:if>	
								</c:forEach>
								<c:if test="${ search.endBk < search.maxpage }">
									<a href="admin_order.do?page=${search.endBk + 1}&searchname=${search.searchname}&keyword=${search.keyword}">다음</a>
								</c:if>
                    </div>

                    <!-- 메인 내용 끝 -->
                </td>
            </tr>

        </table>

    </div>
    <!-- 메인 영역 끝 -->
    
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>>