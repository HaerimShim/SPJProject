<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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

<!-- 글씨체 변경 (1) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap">
<!-- 글씨체 변경 (2) -->
<!-- css부분에 'font-family: 'Nanum Pen Script', cursive;' 추가 -->
<!-- 글씨체 변경 관련 참고 사이트: https://mjmjmj98.tistory.com/17 -->


<!--
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>spj_about</title>
<style>

html {
    position: relative;
    min-height: 100%;
    margin: 0;
}

body {
    min-height: 100%;
}

.about1 {
	width: 70%;
	background-size: cover;
	background-image: url('images/notepad.png');
	font-family: 'Nanum Pen Script', cursive;
	background-size: 1000px contain;
	background-image: url('images/notepad.png');
}

.about2 {
	width: 70%;
	font-family: 'Nanum Pen Script', cursive;
}

.about3 {
	width: 70%;
	font-family: 'Nanum Pen Script', cursive;
}

.about-text1 {
	font-weight: bolder;
	font-size: 36px;
}

.about-text2 {
	font-weight: bolder;
	font-size: 22px;
}

.about-text3 {
	font-size: 20px;
}

</style> 


</head>
<body>

	<%@ include file="spj_nav.jsp"%>

	<div class="row justify-content-center">
		<div class="about1 p-2 mt-5 mb-2 ">
			<div class="text-center py-2">
				<p class="about-text1 mt-2">알바's 제작 목적</p>
				<p class="about-text2">1. 파트 타임 근로자(아르바이트생)들이 급여를 체계적으로 관리 및 확인할 수 있는 서비스 제공</p>
				<p class="about-text2">2. 파트 타임 근무 관련 의견이나 리뷰를 공유할 수 있는 소통 공간 제공</p>
				<br/>
				
				<p class="about-text1 mt-2">알바's 구현 기능</p>
				<p class="about-text2">1. 회원가입 및 로그인 (일반 / 소셜 로그인) </p>
				<p class="about-text2">2. 게시판 CRUD, 페이징, 검색, 댓글</p>
				<p class="about-text2">3. 아르바이트 근무 내역 저장 및 명세서 출력</p>
			</div>
		</div>
	</div>
	
<hr/>

	<div class="row justify-content-center">
			<div class="about2 p-2 mb-2 ">
				<div class="text-center py-2">
					<p class="about-text1">개발 환경</p>
				<img src="images/devenvironment.jpg" width="600px">
			</div>
		</div>
	</div>
	
	<div class="mb-5"></div>
	
	<%@ include file="spj_footer.jsp"%>
	
</body>
</html>