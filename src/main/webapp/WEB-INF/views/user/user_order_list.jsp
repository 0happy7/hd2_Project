<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/user_head.jsp" flush="true"/>
<title>주문목록</title>
                    <!-- 메인 내용 -->
                    <!-- 상단 페이지, 검색창 -->
                    <div class="mypage_table_topbox">
                        <span>총 ${ search.total }건 | 페이지 ${ search.pageno }/${ search.maxpage }</span>
                            <form id="reg" name="reg" method="get" action="">
                                <span class="search_box">
                                    <select id="searchname" name="searchname">
	                                    <c:if test="${ search.searchname == 'O' }">
	                                        <option value="O" selected>주문번호</option>
	                                        <option value="P">상품정보</option>
	                                    </c:if>
	                                    <c:if test="${ search.searchname == 'P' }">
	                                        <option value="O">주문번호</option>
	                                        <option value="P" selected>상품정보</option>
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
                    <table border="1" class="mypage_table_main">
                        <tr>
                            <th style="width: 12%;">주문번호</th>
                            <th style="width: 15%;">상품정보</th>
                            <th style="width: 8%;">가격</th>
                            <th style="width: 5%;">수량</th>
                            <th style="width: 10%;">총결제금액</th>
                            <th style="width: 20%;">결제 결과(결제일시)</th>
                            <th style="width: 10%;">주문 상태</th>
                            <th style="width: 13%;">운송장 정보</th>
                        </tr>
                        <c:forEach var="orderlist" items="${ orderlist }">
                        <tr>
                            <td><a href="user_orderpage.do?orderno=${ orderlist.orderno }">${ orderlist.ordernum }</a></td>
                            <td>${ orderlist.iname }</td>
                            <td>${ orderlist.price }</td>
                            <td>${ orderlist.oitemcnt }</td>
                            <td>${ orderlist.lpayprice }</td>
                            <td>결제 완료<br>(${ orderlist.paydate })</td>
                            <td>${ orderlist.status }</td>
                            <td>${orderlist.deliveryc}(${ orderlist.trackingno })</td>
                        </tr>
                        </c:forEach>
                    </table>
                    <br>
					<div style="text-align: center;">
                        		<c:if test="${ search.startBk > 10 }">
									<a href="user_order_list.do?page=${search.startBk - 1}&searchname=${search.searchname}&keyword=${search.keyword}">이전</a>
								</c:if>
								<c:forEach var="page" begin="${search.startBk}" end="${search.endBk}">
									<c:if test="${ page == search.pageno }">
										<a style="color:red" href="user_order_list.do?page=${ page }&searchname=${search.searchname}&keyword=${search.keyword}">${ page }</a>
									</c:if>
									<c:if test="${ page != search.pageno }">
										<a href="user_order_list.do?page=${ page }&searchname=${search.searchname}&keyword=${search.keyword}">${ page }</a>
									</c:if>	
								</c:forEach>
								<c:if test="${ search.endBk < search.maxpage }">
									<a href="user_order_list.do?page=${search.endBk + 1}&searchname=${search.searchname}&keyword=${search.keyword}">다음</a>
								</c:if>
                    </div>

                    <!-- 메인 내용 끝 -->
                </td>
            </tr>

        </table>

    </div>




    <!-- 메인 영역 끝 -->
<jsp:include page="../include/tail.jsp" flush="true"/>