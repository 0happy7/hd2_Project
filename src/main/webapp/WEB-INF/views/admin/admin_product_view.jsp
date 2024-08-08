<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<title>관리자페이지</title>
<jsp:include page="../include/admin_head.jsp" flush="true"/>
                    <!-- 메인 내용 -->
                    <!-- 상단 -->
                    <div class="mypage_table_topbox">
                        <div class="mypage_table_topbox_writetext">상품정보</div>
                    </div>
                    
                    <div class="mypage_table_topbox_write_list">상품분류</div>
                    <table border="1"  class="spage_product_write_group_table">
                        <tr>
                            <th>선택한 상품 분류</th>
                            <td>
                                <c:if test="${ item.category == 'F' }">
									<span>댕댕이음식</span>
								</c:if>
								<c:if test="${ item.category == 'I' }">
									<span>댕댕이용품</span>
								</c:if>
								<c:if test="${ item.category == 'C' }">
									<span>댕댕이옷</span>
								</c:if>
                            </td>
                        </tr>

                    </table>
                    <br>
                    <div class="mypage_table_topbox_write_list">상품정보 / 가격 / 재고</div>
                    <table border="1"  class="spage_product_write_table">
                        <tr>
                            <th>상품코드</th>
                            <td>
                                <input type="text" placeholder="상품코드입력" value="${item.icode}" readonly>
                            </td>
                            <th>제조사</th>
                            <td><input type="text" placeholder="제조사입력" value="${item.maker}" readonly></td>
                        </tr>
                        <tr>
                            <th>상품명</th>
                            <td colspan="3">
                                <input type="text" style="width: 535px;" placeholder="상품명입력" value="${item.iname}" readonly>
                            </td>
                        </tr>
                        <tr>
                            <th>배송비</th>
                            <td><input type="text" placeholder="배송비입력" value="${item.shippingfee}" readonly></td>
                            <th>판매가격</th>
                            <td><input type="number" placeholder="가격입력" value="${item.price}" readonly></td>
                        </tr>
                        <tr>
                            <th>재고설정</th>
                            <td>
                            	<c:if test="${ item.stockSet == 'N' }">
									<label for=""><input type="radio" name="stock" onclick="return(false);">재고있음</label>
	                                <label for=""><input type="radio" name="stock" onclick="return(false);" checked>품절</label>
								</c:if>
								<c:if test="${ item.stockSet == 'Y' }">
									<label for=""><input type="radio" name="stock" onclick="return(false);" checked>재고있음</label>
	                                <label for=""><input type="radio" name="stock" onclick="return(false);">품절</label>
								</c:if>

                            </td>
                            <th>재고량</th>
                            <td><input type="number" placeholder="재고량입력" value="${item.stock}" readonly></td>
                        </tr>

                    </table>
                    <br>
                    <div class="mypage_table_topbox_write_list">상품 이미지</div>
                    <table border="1" class="spage_product_write_table_image">
                        <tr>
                            <th>대표 이미지</th>
                            <td>
                                <img src="down.do?name=${ item.thumbnailF }&file=${item.thumbnailP}" alt="${item.thumbnailF}" width="100" height="100">
                            </td>
                        </tr>
                        <tr>
                            <th>상품 이미지</th>
                            <td>
                                <c:forEach var="filelist" items="${ filelist }">
                                <img src="down.do?name=${ filelist.bfname }&file=${filelist.bpname}" alt="${filelist.bpname}" width="100" height="100">
                                </c:forEach>
                            </td>
                        </tr>
                    </table>
                    <br>
                    <div class="mypage_table_topbox_write_list">상품 상세정보</div>
					<div class="admin_view_icontent">${item.icontent}</div>
                   
                    <div class="spage_button_box">
                        <input type="button" value="수정" class="spage_button" onclick="location.href='admin_product_update.do?itemno=${item.itemno}'">
                        <input type="button" value="목록" class="spage_button" onclick="location.href='admin_productAll.do'">
                    </div>
                    <!-- 메인 내용 끝 -->
                </td>
            </tr>
        </table>

    </div>

    <!-- 메인 영역 끝 -->
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>