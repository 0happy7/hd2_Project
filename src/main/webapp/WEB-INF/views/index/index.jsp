<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="../include/head.jsp" flush="true"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<title>힐링독</title>
<style>
    @import url("resources/css/project.css");
    @import url("resources/css/area.css");
    @import url("resources/css/button.css");
    @import url("resources/css/title.css");
</style>

<!-- CSS -->
<style>
#img {
	display: inline-block;
	text-align: center;
	margin-left: 30px;
	margin-right: 30px;
	margin-top: 3%;
}


.swiper-container {
	margin-top:80px;
	height:220px;
	border:5px solid silver;
	border-radius:7px;
	box-shadow:0 0 20px #ccc inset;
}
.swiper-slide {
	text-align:center;
	display:flex; /* 내용을 중앙정렬 하기위해 flex 사용 */
	align-items:center; /* 위아래 기준 중앙정렬 */
	justify-content:center; /* 좌우 기준 중앙정렬 */
}
.swiper-slide img {
	box-shadow:0 0 5px #555;
	max-width:100%; /* 이미지 최대너비를 제한, 슬라이드에 이미지가 여러개가 보여질때 필요 */
	/* 이 예제에서 필요해서 설정했습니다. 상황에따라 다를 수 있습니다. */
}

#fdimg {
	display: inline-block;
	text-align: center;
	margin-left: 30px;
	margin-right: 30px;
	margin-top: 7%;
	border-radius: 100%;
	}
	
	
.swiper-container {
	margin-top:140px;
	height:220px;
	border:5px solid silver;
	border-radius:7px;
	box-shadow:0 0 20px #ccc inset;
}
.swiper-slide {
	text-align:center;
	display:flex; /* 내용을 중앙정렬 하기위해 flex 사용 */
	align-items:center; /* 위아래 기준 중앙정렬 */
	justify-content:center; /* 좌우 기준 중앙정렬 */
}
.swiper-slide img {
	box-shadow:0 0 5px #555;
	max-width:100%; /* 이미지 최대너비를 제한, 슬라이드에 이미지가 여러개가 보여질때 필요 */
	/* 이 예제에서 필요해서 설정했습니다. 상황에따라 다를 수 있습니다. */
}
</style>
<!-- CSS 끝 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<!-- JS부분 시작 -->
<script>
//페이지 로드 시 초기 설정
$(document).ready(function()
{
	ItemList("T", "전주시");	    
});

var choiceKind = '';

//T 또는 F를 선택하는 함수
function ChoiceList(kind)
{
    toggle(kind);
    choiceKind = kind; // 전역 변수에 선택된 종류 저장
}

//지역을 선택하고 데이터를 가져오는 함수
function AreaList(area)
{
    if (choiceKind === '')
    {
        console.error("종류(T 또는 F)를 먼저 선택해야 합니다.");
        return;
    }

    // 선택된 종류와 지역을 이용하여 ItemList 함수 호출
    ItemList(choiceKind, area);
}

//데이터를 가져오는 함수
function ItemList(kind, area)
{
    $.ajax({
        type: "get",
        url: "index_list.do",
        data: {
            kind: kind,
            area: area
        },
        dataType: "html",
        success: function(result) {
            result = result.trim();
            $("#item_list").html(result);
        },
        error: function(xhr, status, error) {
            console.error("ItemList 오류", error);
        }
    });
}

//데이터를 가져오는 함수
function ShopFood(kind)
{
	kind = "F";
    $.ajax({
        type: "get",
        url: "index_food_list.do",
        data: {
            kind: kind
        },
        dataType: "html",
        success: function(result) {
            result = result.trim();
            $(".shop_food").html(result);
        },
        error: function(xhr, status, error) {
            console.error("shop_food 오류", error);
        }
    });
}
</script>
<!-- 헤더 부분  끝-->

<!-- 컨텐츠 출력 되는곳 -->
<div id="logo">
	<h1>
		댕댕이와 함께 즐겁<span class="tc">개!</span> 신나<span class="tc">개!</span>
		행복하<span class="tc">개!</span><br> 펫팸족을 위한 반려견 동반 여행지와 맛집을
		소개합니다.
	</h1>
</div>
	
	<!-- 지도 부분 -->
<div id="upimg">
	<img id="dog" src="resources/img/backgr.jpg" alt="">
	<div class="point-area"
		style="background-image: url(resources/img/jb-removebg-preview.png); background-repeat: no-repeat; background-size: 50%; background-position: left; margin-left: 30px;">
			<a href="javascript:AreaList('군산시');" alt="area" class="gunsan position"></a> 
			<a href="javascript:AreaList('익산시');" alt="area" class="iksan position"></a> 
			<a href="javascript:AreaList('완주군');" alt="area" class="wanjoo position"></a> 
			<a href="javascript:AreaList('진안군');" alt="area" class="jinan position"></a> 
			<a href="javascript:AreaList('무주군');" alt="area" class="muju position"></a> 
			<a href="javascript:AreaList('장수군');" alt="area" class="jangsu position"></a> 
			<a href="javascript:AreaList('남원시');" alt="area" class="namwon position"></a> 
			<a href="javascript:AreaList('순창군');" alt="area" class="sunchang position"></a> 
			<a href="javascript:AreaList('임실군');" alt="area" class="imsil position"></a> 
			<a href="javascript:AreaList('정읍시');" alt="area" class="jeongeup position"></a> 
			<a href="javascript:AreaList('김제시');" alt="area" class="kimje position"></a> 
			<a href="javascript:AreaList('전주시');" alt="area" class="jeonju position"></a> 
			<a href="javascript:AreaList('부안군');" alt="area" class="buan position"></a> 
			<a href="javascript:AreaList('고창군');" alt="area" class="gochang position"></a>
	</div>

	<!-- 지도 옆 최신 글 -->
	<div id="links">
		<ul style="list-style-type: none;">
			<li>
				<a href="#" onclick="ChoiceList('T'); toggle('t'); return false;" style="text-decoration: none;" >
				<span id="quick-icon2" >여행</span>
				</a>
			</li>
			<li>
				<a href="#" onclick="ChoiceList('F'); toggle('f'); return false;" style="text-decoration: none;">
					<span id="quick-icon1" >음식</span>
				</a>
			</li>
		</ul>
	</div>
	
	<div id="mini">
		<ul style="list-style-type: none;" id="item_list">
			<!-- 여행 또는 음식 목록이 표시 되는 곳 -->
			</ul>
	</div>
</div>

<!-- 댕댕이 음식 -->
<div id="food"><a href="trip.do" style="text-decoration-line: none;">댕댕이음식</a> </div>

<div style="display: flex; justify-content: center;">
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<c:forEach var="flist" items="${flist}">
			<div class="swiper-slide"><img onclick="ViewFood(${flist.itemno});" src="down.do?name=${flist.thumbnailF}&file=${flist.thumbnailP}" alt="${flist.thumbnailF}" style="width:400px;height:200px;"></div>
			</c:forEach>
		</div>
		
		<!-- 네비게이션 -->
		<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		
		<!-- 페이징 -->
		<div class="swiper-pagination"></div>
	</div>
</div>

	<!-- 댕댕이물품 -->
<div id="things"><a href="food.do" style="text-decoration-line: none;">댕댕이물품</a></div>
<!-- <button id="prev2">&lang;</button>
<button id="next2">&rang;</button> -->


<div style="display: flex; justify-content: center;">
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<c:forEach var="ilist" items="${ilist}">
				<div class="swiper-slide"><img onclick="ViewThings(${ilist.itemno});" src="down.do?name=${ilist.thumbnailF}&file=${ilist.thumbnailP}" alt="${ilist.thumbnailF}" style="width:400px;height:200px;"></div>
			</c:forEach>
		</div>
		
		<!-- 네비게이션 -->
		<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		
		<!-- 페이징 -->
		<div class="swiper-pagination"></div>
	</div>
</div>

<!-- 댕댕이옷 -->
<div id="clothes"><a href="trip.do" style="text-decoration-line: none;">댕댕이옷</a> </div>

<div style="display: flex; justify-content: center;">
	<div class="swiper-container">
		<div class="swiper-wrapper">
				<c:forEach var="clist" items="${clist}">
					<div class="swiper-slide"><img onclick="ViewClothes(${clist.itemno});" src="down.do?name=${clist.thumbnailF}&file=${clist.thumbnailP}" alt="${clist.thumbnailF}" style="width:400px;height:200px;"></div>
				</c:forEach>
		</div>
		
		<!-- 네비게이션 -->
		<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		
		<!-- 페이징 -->
		<div class="swiper-pagination"></div>
	</div>
</div>


<!-- 꼬릿말 부분 시작 -->
<%@ include file="../include/tail.jsp" %>
<!-- 꼬릿말 부분 끝 -->
</body>
</html>


<!-- 클래스명은 변경하면 안 됨 -->
<script>
	function toggle(target)
	{
		if(target == "t")
		{
			document.getElementById('quick-icon2').style.backgroundImage= "url(resources/img/bag2.PNG)"
			document.getElementById('quick-icon1').style.backgroundImage= "url(resources/img/food.png)"
			document.getElementById('quick-icon2').style.color = "orangered";
			document.getElementById('quick-icon1').style.color = "blue";
		}else
		{
			document.getElementById('quick-icon2').style.backgroundImage= "url(resources/img/bag.png)"
			document.getElementById('quick-icon1').style.backgroundImage= "url(resources/img/food2.PNG)"
			document.getElementById('quick-icon1').style.color = "orangered";
			document.getElementById('quick-icon2').style.color = "blue";
		}
	
	}
	
	function ViewFood(itemno)
	{
		document.location = "shop_food_view.do?keyword=&kind=T&itemno="+itemno;
	}
	
	function ViewThings(itemno)
	{
		document.location = "shop_things_view.do?keyword=&kind=T&itemno="+itemno;
	}

	<!-- 클래스명은 변경하면 안 됨 -->

	function ViewClothes(itemno)
	{
		document.location = "shop_clothes_view.do?keyword=&kind=F&itemno="+itemno;
	}

new Swiper('.swiper-container', {

	slidesPerView : 4, // 동시에 보여줄 슬라이드 갯수
	spaceBetween : 30, // 슬라이드간 간격
	slidesPerGroup : 4, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음

	// 그룹수가 맞지 않을 경우 빈칸으로 메우기
	// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
	loopFillGroupWithBlank : true,

	loop : true, // 무한 반복

	pagination : { // 페이징
		el : '.swiper-pagination',
		clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
	},
	navigation : { // 네비게이션
		nextEl : '.swiper-button-next', // 다음 버튼 클래스명
		prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
	},
});
</script>