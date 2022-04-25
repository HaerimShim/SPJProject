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


<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>

<!--  
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
-->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>main</title>
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

.wageBill-table {
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
	position: relative;
	width: 1100px;
	border-top: 2px solid #999;
}

.board_list>div {
	border-bottom: 1px solid #999;
	font-size: 0;
}

.board_list>div.top {
	border-bottom: 1px solid #999;
	background-color:#e9ecef;
}

.board_list>div:last-child {
	border-bottom: 2px solid #999;
}

.board_list>div>div {
	display: inline-block;
	padding: 15px 0;
	text-align: center;
	font-size: 14px;
	width: 170px;
}

.board_list>div.top>div {
	font-weight: 600;
}

.board_list .title {
	width: 60%;
	text-align: left;
}

.board_list .top .title {
	text-align: center;
}



</style>
</head>
<body>
	

	<%@ include file="spj_nav.jsp"%>

	<div id="main" class="wageBill-table mt-5 mb-5">
		<div class="board_title">
			<strong>알바비 명세서</strong>
		</div>
	
		<div class="board_list">
			<div class="top">
				<div class="id" id="uid">아이디</div>
			</div>
			<div>
				<div class="id" name="rid" id="uid">${user}</div>
			</div>
			
			<div class="top">
				<div class="company">회사명(매장명)</div>
				<div class="time_from">시작 시간</div>
				<div class="time_to">종료 시간</div>
				<div class="time_day">근무 시간</div>
				<div class="wage_hour">시급</div>
				<div class="wage_day">일급</div>
			</div>
			<div>
			<c:forEach items="${wageBill}" var="dto">
				<div class="company">${dto.rcompany}</div>
				<div class="time_from">${dto.rtime_from}</div>
				<div class="time_to">${dto.rtime_to}</div>
				<div class="time_day">${dto.rtime_day}</div>
				<div class="wage_hour">${dto.rwage_hour}</div>
				<div class="wage_day">${dto.rwage_day}</div>
				<br/>
			</c:forEach>		
			</div>		
			
			<div class="top">
				<div class="time_total">총 근무시간</div> <br/>
				<div class="wage_total">급여 합계</div>
			</div>
			<div>
				<div class="time_total">${dto.rtime_sum}</div>
				<div class="wage_total">${dto.rwage_sum}</div>
			</div>
		</div>
	</div>
	
	<%@ include file="spj_footer.jsp"%>

</body>
</html>