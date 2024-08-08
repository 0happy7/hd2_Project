<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<jsp:include page="../include/admin_head.jsp" flush="true"/>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">
<style>

.img_div {
    float:left;
    /* width:100px;
    height:70px; */
    margin-right: 5px;
    margin-bottom:5px;
    background-color: black;
    height: 95px;
}
.img_div_img {
    width: 100px;
    height: 70px;
}
</style>
<!-- 헤더 부분  끝-->
<script>
window.onload = function(){
	$("#icode").focus();
	
	// 재고량 설정
    $('input[name="stockSet"]').change(function() {
        if ($(this).val() === 'N') { // 품절 선택 시
            $('#stock').val(0).prop('readonly', true);
        } else { // 재고 있음 선택 시
            $('#stock').prop('readonly', false);
            $("#stock").focus();
        }
    });
	
 // 대표 이미지 미리보기 및 삭제
    $("#thumbnail").change(function() {
        $("#preview_thumbnail").empty();
        var input = document.getElementById("thumbnail");
        var files = input.files;
        for (var i = 0; i < files.length; i++) {
            (function(file) {
                var fReader = new FileReader();
                fReader.readAsDataURL(file);
                fReader.onloadend = function(event){
                    var lastModified = file.lastModified;
                    $("#preview_thumbnail").append('<div class="img_div" id="'+lastModified+'"><div class="i_div"><i class="bi bi-x-square-fill" style="color:white;float:right;" key="'+lastModified+'"></i></div><img id="view" src="'+event.target.result+'" class="img_div_img"/></div>');
                };
            })(files[i]);
        }
    });

    // 대표 이미지 삭제 처리
    $(document).on("click", "#preview_thumbnail .i_div", function(e){
        var target = e.currentTarget;
        var removeId = $(target).find("i").attr("key");
        var input = $("#thumbnail").prop('files');
        const dataTransfer = new DataTransfer();
        Array.from(input).filter(file => file.lastModified != removeId)
            .forEach(file => {
                dataTransfer.items.add(file);
            });
        $('#thumbnail')[0].files = dataTransfer.files;
        $(target).closest('.img_div').remove();
    });

	

 // 상품 이미지 미리보기 및 삭제
    $("#files").change(function() {
        $("#preview_img").empty();
        var input = document.getElementById("files");
        var files = input.files;
        for (var i = 0; i < files.length; i++) {
            (function(file) {
                var fReader = new FileReader();
                fReader.readAsDataURL(file);
                fReader.onloadend = function(event){
                    var lastModified = file.lastModified;
                    $("#preview_img").append('<div class="img_div" id="'+lastModified+'"><div class="i_div"><i class="bi bi-x-square-fill" style="color:white;float:right;" key="'+lastModified+'"></i></div><img id="view" src="'+event.target.result+'" class="img_div_img"/></div>');
                };
            })(files[i]);
        }
    });

    // 상품 이미지 삭제 처리
    $(document).on("click", "#preview_img .i_div", function(e){
        var target = e.currentTarget;
        var removeId = $(target).find("i").attr("key");
        var input = $("#files").prop('files');
        const dataTransfer = new DataTransfer();
        Array.from(input).filter(file => file.lastModified != removeId)
            .forEach(file => {
                dataTransfer.items.add(file);
            });
        $('#files')[0].files = dataTransfer.files;
        $(target).closest('.img_div').remove();
    });
	
	
	
	$("#product_update_form").submit(function(){
		/* 스마트 에디터 검증 및 submit 값 얻기 */
		oEditors.getById["icontent"].exec("UPDATE_CONTENTS_FIELD", []);
		
		// 상품코드 입력안하면
		if($("#icode").val() == "")
		{
			alert("상품코드를 입력하세요.");
			$("#icode").focus();
			return false;
		}
		
		if($("#iname").val() == "")
		{
			alert("상품명을 입력하세요.");
			$("#iname").focus();
			return false;
		}
		
		if($("#price").val() == "")
		{
			alert("가격을 입력하세요.");
			$("#price").focus();
			return false;
		}
		
		if($("#stock").val() == "")
		{
			alert("재고량을 입력하세요.");
			$("#stock").focus();
			return false;
		}
		
		
		let contentok = document.getElementById("icontent").value;
		
		/* 		alert(contentok); */
		if(contentok == "" || contentok == null || contentok == '&nbsp;' || contentok == '<br>' || contentok == '<br/>' || contentok == '<p>&nbsp;</p>'){
			alert("내용을 입력하세요.");
			$("#icontent").focus();
			return false;
		}
		if(confirm("상품을 수정하시겠습니까?") == false){
			return false;
		}
		

		
	});
}

</script>
                    <!-- 메인 내용 -->
                    <!-- 상단 -->
                    <div class="mypage_table_topbox">
                        <div class="mypage_table_topbox_writetext">상품등록</div>
                    </div>
                    
                    <div class="mypage_table_topbox_write_list">상품분류</div>
                    <form id="product_update_form" name="product_update_form" action="admin_product_update_ok.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="itemno" name="itemno" value="${ item.itemno }">
                    <table border="1"  class="spage_product_write_group_table">
                        <tr>
                            <th>선택한 상품 분류</th>
                            <td>
                                <select name="category" id="category" class="spage_product_write_group_table_select">
                                <c:if test="${ item.category == 'F' }">
                                    <option value="F" selected>댕댕이음식</option>
                                    <option value="I">댕댕이용품</option>
                                    <option value="C">댕댕이옷</option>
                                </c:if>
                                <c:if test="${ item.category == 'I' }">
                                    <option value="F">댕댕이음식</option>
                                    <option value="I" selected>댕댕이용품</option>
                                    <option value="C">댕댕이옷</option>
                                </c:if>
                                <c:if test="${ item.category == 'C' }">
                                    <option value="F">댕댕이음식</option>
                                    <option value="I">댕댕이용품</option>
                                    <option value="C" selected>댕댕이옷</option>
                                </c:if>

                                </select>
                            </td>
                        </tr>

                    </table>
                    <br>
                    <div class="mypage_table_topbox_write_list">상품정보 / 가격 / 재고</div>
                    <table border="1"  class="spage_product_write_table">
                        <tr>
                            <th>상품코드</th>
                            <td colspan="3">
                                <input type="text" id="icode" name="icode" placeholder="상품코드입력" value="${item.icode}">
                            </td>
                        </tr>
                        <tr>
                            <th>상품명</th>
                            <td colspan="3">
                                <input type="text" id="iname" name="iname" placeholder="상품명입력" value="${item.iname}">
                            </td>
                        </tr>
                        <tr>
                            <th>제조사</th>
                            <td><input type="text" id="maker" name="maker" placeholder="제조사입력" value="${item.maker}"></td>
                            <th>판매가격</th>
                            <td><input type="number" id="price" name="price" placeholder="가격입력" value="${item.price}"></td>
                        </tr>
                        <tr>
                            <th>재고설정</th>
                            <td>
                            	<c:if test="${ item.stockSet == 'N' }">
									<label for=""><input type="radio" id="stockSet" name="stockSet" value="Y">재고있음</label>
	                                <label for=""><input type="radio" id="stockSet" name="stockSet" value="N" checked>품절</label>
								</c:if>
								<c:if test="${ item.stockSet == 'Y' }">
									<label for=""><input type="radio" id="stockSet" name="stockSet" value="Y" checked>재고있음</label>
	                                <label for=""><input type="radio" id="stockSet" name="stockSet" value="N">품절</label>
								</c:if>
                            </td>
                            <th>재고량</th>
                            <td>
                            <c:if test="${ item.stockSet == 'N' }">
                            <input type="number" id="stock" name="stock" placeholder="재고량입력" value="${item.stock}" readonly>
                            </c:if>
                            <c:if test="${ item.stockSet == 'Y' }">
                            <input type="number" id="stock" name="stock" placeholder="재고량입력" value="${item.stock}">
                            </c:if>     
                            </td>
                        </tr>

                    </table>
                    <br>
                    <div class="mypage_table_topbox_write_list">상품 이미지</div>
                    <table border="1" class="spage_product_write_table_image">
                        <tr>
                            <th>대표 이미지</th>
                            <td>
                                <input type="file" id="thumbnail" name="thumbnail">
                                    <div style="margin-left: 5px; font-size: 12px; color: gray;">
					                    <label for="subject">
					                        이미지 미리보기
					                    </label>
					                </div>
					 
					                <div class="form-group" style="display:flex;">
					 					<div id='preview_thumbnail' style="text-align:left;">
					                    	<img id="view" src="down.do?name=${ item.thumbnailF }&file=${item.thumbnailP}" alt="${item.thumbnailF}" class="img_div_img"/>
					                    </div>
					                </div>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="3">상품 이미지</th>
                            <td>
                                <input type="file" multiple="multiple" id="files" name="files">
                               	<div style="margin-left: 5px; font-size: 12px; color: gray;">
				                    <label for="subject">
				                        이미지 미리보기
				                    </label>
				                </div>
				 
				                <div class="form-group" style="display:flex;">
				 
				                    <div id='preview_img' style="text-align:left;">

				                    	<c:forEach var="filelist" items="${ filelist }">
				                    		<img id="view" src="down.do?name=${ filelist.bfname }&file=${filelist.bpname}" alt="${filelist.bpname}" class="img_div_img"/>
				                    	</c:forEach>

				                    </div>
				                </div>
                            </td>
                        </tr>

                    </table>
                    <br>
                    <div class="mypage_table_topbox_write_list">상품 상세정보</div>
                    <textarea name="icontent" id="icontent" cols="100" rows="35" class="spage_product_write_table_textarea">
                    ${item.icontent}
                    </textarea>
                    
                    <div class="spage_button_box">
                        <input type="submit" value="저장" class="spage_button">
                        <input type="button" value="목록" class="spage_button" onclick="location.href='admin_productAll.do'">
                    </div>
                    </form>
                    <!-- 메인 내용 끝 -->
                </td>
            </tr>
        </table>

    </div>


    <!-- 메인 영역 끝 -->
<!-- 꼬릿말 부분 -->
<jsp:include page="../include/tail.jsp" flush="true"/>
<script type="text/javascript">
        var oEditors = [];
        nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "icontent",
        sSkinURI: "resources/smarteditor2/SmartEditor2Skin.html",
        fCreator: "createSEditor2"
        });
</script>