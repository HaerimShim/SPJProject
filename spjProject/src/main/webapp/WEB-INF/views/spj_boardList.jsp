<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">

<!--
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
-->
 
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<!-- 페이지 처리 js라이브러리 -->
<script src="js/jquery.twbsPagination.js"></script>
<title>spj_boardList</title>
<style>
html {
    position: relative;
    min-height: 100%;
    margin: 0;
}

body {
    min-height: 100%;
}

ul, li {
	list-style: none;
}

a {
	text-decoration: none;
	color: inherit;
}

.board-table {
	width: 70%;
	height: 90%;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	font-size: 16px;
}

.board_title {
	margin-bottom: 30px;
}

.board_title strong {
	font-size: 32px;
}

.board_title p {
	margin-top: 5px;
	font-size: 16px;
}

.board_list {
	width: 100%;
	border-top: 2px solid #000;
	border-bottom: 2px solid #000;
}

.board_list>thead.top {
	border-bottom: 1px solid #999;
}

.board_list .num {
	width: 10%;
}

.board_list .title {
	width: 50%;
	text-align: left;
}

.board_list .top .title {
	text-align: center;
}

.board_list .writer {
	width: 15%;
	height : 40px;
}

.board_list .date {
	width: 15%;
}

.board_list .count {
	width: 10%;
}

.board-btn {
	justify-content: right;
	width: 140px;
	margin-bottom: 10px;
}

.pagination a {
	color: black;
	border: 0px;
	padding: 8px 16px;
	text-decoration: none;
}

.pagination {
	margin-top: 10px;
	justify-content: center;
}

form {
	width: 80%;
	margin: 0 auto;
}

.search-wrap {
	text-align: center;
	width: 60%;
	margin: 0 auto;
}

.bt_wrap {
	text-align: right;
	font-size: 0;
}

.bt_wrap a {
	display: inline-block;
	min-width: 80px;
	margin-left: 10px;
	padding: 10px;
	border: 1px solid #000;
	font-size: 16px;
}

.bt_wrap a:first-child {
	margin-left: 0;
}

.bt_wrap a.on {
	background: #000;
	color: #fff;
}

.btn a {
	display: inline-block;
	min-width: 80px;
	margin-left: 10px;
	padding: 10px;
	border: 1px solid #000;
	font-size: 16px;
}
</style>


</head>
<body>
	

	<%@ include file="spj_nav.jsp"%>

	<div id="main" class="board-table mt-5">
		<div class="board_title">
			<strong> 게시판 </strong>
		</div>

		<span class="bt_wrap">
			<a href="spj_boardWrite" class="btn btn-dark mb-2">게시글 작성</a>
		</span>
		
	<table class="board_list">
		<thead class="top">
			<tr>
				<th class="num">번호</th>
				<th class="title">제목</th>
				<th class="writer">작성자</th>
				<th class="date">작성일</th>
				<th class="count">조회</th>
			</tr>
		</thead>
		<tbody id="searchTable" >
			<c:forEach items="${listContent}" var="dto">
				<tr>
					<td class="num" id="bid">${dto.bid}</td>
					<td class="title">
						<a class="spj_boardView" href="spj_boardView?bid=${dto.bid}">${dto.btitle}</a>
					</td>
					<td class="writer">${dto.buser}</td>
					<td class="date">${dto.bdate}</td>
					<td class="count">${dto.bhit}</td>
				</tr>
			</c:forEach>
		</tbody>			
	</table>
	<br/><br/>
	<!-- 검색창 -->
	<div class="search-wrap">	
		<form action="" > 
			<div class="input-group">
				<input type="text" class="form-control search-input" id="searchInput" placeholder="제목/작성자와 같은 검색어를 입력하세요" 
					aria-label="검색어를 입력하세요." aria-describedby="basic-addon2"/>
			</div>
		</form>
	</div>	
</div>		

<!-- 페이징 -->
<!-- #boardOnly는 페이지  -->
<div class="container" id="boardOnly">
	<nav aria-label="Page navigation"> <!-- aria-label은 라벨표시가 안되는것 예방 -->
		<ul class="pagination justify-content-center" id="pagination" style="margin:20px 0">
		</ul>
	</nav>
</div>

<%@ include file="spj_footer.jsp"%>
<script>
$(document).ready(function(){
	//검색창
	$("#searchInput").on("keyup",function(){
		var value = $(this).val().toLowerCase(); //입력창값을 소문자로 변환
		$("#searchTable tr").filter(function(){
			$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
			//일치하지 않는 tr은 제거를 하고 일치하는 것이 있는 tr만 남겨두는 것이 toggle메서드임
		});
	});
});

</script>


<script>
//pagination만들기
$(function(){
	window.pagObj = $('#pagination').twbsPagination({		
		totalPages: 35, //총 페이지 수
		visiblePages: 10, //가시 페이지 수
		onPageClick : function (event, page) {
			console.info(page + ' (from options)');
			$(".page-link").on("click",function(event){
				event.preventDefault();
				var peo = event.target; //이벤트 발생 자바스크립트 객체
				var pageNo = peo.innerHTML;	//페이지 번호
				var purl;
				if(pageNo != "First" && pageNo != "Previous" && pageNo != "Next" && pageNo != "Last"){
					purl = "plist?pageNo=" + pageNo;
				}
				else {
					return;
				}
				$.ajax({
					url : purl,
					type : "get",
					success : function(data) {
						$("#main").html(data);
					},
					error : function() {
						alert("plist시 에러 발생");
					}
				}); //.ajax
			}); //".page-link"
		} //onPageClick
	}) //window.pagObj
	.on('page', function(event, page){ //chaining
		console.info(page + ' (from event listening)');
	}); //on
}); //function()

</script>
 

</body>
</html>