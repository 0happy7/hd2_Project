<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
   <title>마이페이지</title>
   <link href="resources/css/title.css" type="text/css" rel="stylesheet">
   <link rel="stylesheet" href="resources/css/mypage.css"/>
<!-- 헤더 부분  끝-->
<jsp:include page="../include/user_head.jsp" flush="true"/>
                    <!-- 메인 내용 -->
                    <!-- 상단 페이지, 검색창 -->
                    <div class="mypage_table_topbox">
                        <div class="mypage_table_topbox_ordertext">주문상세내역</div>
                    </div>

                    <div class="mypage_table_topbox_order_list">주문정보</div>
                    <table border="1" class="spage_order_table">
                        <tr>
                            <th>주문상태</th>
                            <td><span>${ order.status }</span></td>
                        </tr>
                        <tr>
                            <th>운송장 정보</th>
                            <td>
                                <span>${order.deliveryc}(${ order.trackingno })</span>
                            </td>
                        </tr>
                        <tr>
                            <th>주문번호</th>
                            <td><span>${ order.ordernum }</span></td>
                        </tr>
                        <tr>
                            <th>주문일시</th>
                            <td><span>${ order.odate }</span></td>
                        </tr>
                    </table>
                    <br>
                    <div class="mypage_table_topbox_order_list">결제정보</div>
                        <table border="1" class="spage_pay_table">
                            <tr>
                                <th>상품금액</th>
                                <td><span>${ item.price }</span></td>
                            </tr>
                            <tr>
                                <th>배송비</th>
                                <td><span>${ item.shippingfee }</span></td>
                            </tr>
                            <tr>
                                <th>총 결제 금액</th>
                                <td><span>${ pay.payprice }</span></td>
                            </tr>
                            <tr>
                                <th>결제수단</th>
                                <td><span>${ pay.payment }</span></td>
                            </tr>
                            <tr>
                                <th>결제일시</th>
                                <td><span>${ pay.paydate }</span></td>
                            </tr>
                        </table>
                    <br>
                    <div class="mypage_table_topbox_order_list">상품정보</div>
                        <table border="1" class="spage_product_table">
                            <tr>
                                <th style="width: 5%;">번호</th>
                                <th>이미지</th>
                                <th style="width: 50%;">상품 정보</th>
                                <th>가격</th>
                                <th style="width: 5%;">수량</th>
                                <th>총구매금액</th>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>
                                    <img src="down.do?name=${ item.thumbnailF }&file=${item.thumbnailP}" alt="${item.thumbnailF}" style="width: 100px; height: 100px;">
                                </td>
                                <td>${ item.iname }</td>
                                <td>${ item.price }</td>
                                <td>${ order.oitemcnt }</td>
                                <td>${ order.tprice }</td>
                            </tr>
                        </table>
                        <br>
                    <div class="mypage_table_topbox_order_list">주문자 및 배송지정보</div>
                        <div class="spage_user_table_box">
                            <table border="1" class="spage_user_table">
                                <tr>
                                    <th colspan="2">주문자정보</th>
                                </tr>
                                <tr>
                                    <th>주문자명</th>
                                    <td><span>${ user.uname }</span></td>
                                </tr>
                                <tr>
                                    <th>회원아이디</th>
                                    <td><span>${ user.userid }</span></td>
                                </tr>

                                <tr>
                                    <th>이메일주소</th>
                                    <td><span>${ user.email }</span></td>
                                </tr>
                            </table>

                            <table border="1" class="spage_user_table">
                                <tr>
                                    <th colspan="2">배송지 정보</th>
                                </tr>
                                <tr>
                                    <th>수취인명</th>
                                    <td><span>${ order.oaddrname }</span></td>
                                </tr>
                                <tr>
                                    <th>수취인번호</th>
                                    <td><span>${ order.oaddrtel }</span></td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td><span>${ order.oaddr } ${ order.oaddrdetail }</span></td>
                                </tr>
                                <tr>
                                    <th>요청사항</th>
                                    <td><span>${ order.oreq }</span></td>
                                </tr>
                            </table>
                        </div>
                        <div class="spage_button_box">
                            <input type="button" value="목록" class="spage_button" onclick="location.href='user_order_list.do'">
                        </div>
                    <!-- 메인 내용 끝 -->
                </td>
            </tr>

        </table>

    </div>


    <!-- 메인 영역 끝 -->
<jsp:include page="../include/tail.jsp" flush="true"/>