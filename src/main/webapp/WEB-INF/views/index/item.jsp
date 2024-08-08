<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.hd.vo.BoardVO" %>
<%@ page import="com.hd.dto.BoardDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="count" value="0" scope="page" />

<!-- 데이터가 존재하는 경우 -->
<c:if test="${not empty list}">
    <ul>
        <c:forEach var="item" items="${list}" varStatus="status">
            <c:choose>
                <c:when test="${item.bkind == 'T' || item.bkind eq 'T'}">
                    <li>
                        <a href="trip_view.do?no=${item.bno}" style="text-decoration: none;">
                            <div id="mp1">
                                <img id="im1" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/upload/${item.bpname}">
                                <h2>
                                    <p class="text1">${item.bname != null && item.bname != '' ? item.bname : '제목없음'}</p>
                                </h2>
                                <p class="text2" style="font-size:15px;">${item.addr}</p>
                            </div>
                        </a>
                    </li>
                </c:when>
                <c:when test="${item.bkind == 'F' || item.bkind eq 'F'}">
                    <li>
                        <a href="food_view.do?no=${item.bno}" style="text-decoration: none;">
                            <div id="mp1">
                                <img id="im1" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/upload/${item.bpname}">
                                <h2>
                                    <p class="text1">${item.bname != null && item.bname != '' ? item.bname : '제목없음'}</p>
                                </h2>
                                <p class="text2" style="font-size:15px;">${item.addr}</p>
                                <c:choose>
                                    <c:when test="${empty item.tel}">
                                        <p class="text3">&nbsp;</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text3" style="font-size:12px;">${item.tel} ${item.tel1} ${item.tel2}</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </a>
                    </li>
                </c:when>
            </c:choose>
            <c:set var="count" value="${count + 1}" scope="page" />
        </c:forEach>
    </ul>
</c:if>

<!-- 데이터가 없는 경우 -->
<c:if test="${empty list}">
    <c:forEach begin="0" end="1">
        <li>
            <div id="mp1">
                <h2>
                    <p class="text1">조회된 자료가 없습니다.</p>
                </h2>
                <p class="text2">&nbsp;</p>
            </div>
        </li>
    </c:forEach>
</c:if>
