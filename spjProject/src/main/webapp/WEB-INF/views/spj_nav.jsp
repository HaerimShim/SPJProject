<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!-- 추가 -->

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<!--
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>spj_nav</title>
<style>
html {
	position: relative;
	min-height: 100%;
	margin: 0;
}

body {
	min-height: 100%;
}

nav{
	height: 80px;
	z-index: 5;
}

.nav-link {
	font-size: 14px;
}

.nav-login {
	margin-left: auto;
}

a.navbar-brand {
	font-family: 'Black Han Sans';
	font-size: 40px;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="spj_main">알바's</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"	data-target="#collapsibleNavbar">
					<span class="navbar-toggler-icon"></span>
				</button>

		<div class="collapse navbar-collapse bg-dark" id="collapsibleNavbar">
			<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
			
				<li class="nav-item">
					<a class="nav-link active" href="spj_record">
						&nbsp; <span class="badge rounded-pill bg-primary">Primary</span>
						&nbsp;알바비 계산/기록
					</a>
				</li> 

				<li class="nav-item">
					<a class="nav-link" href="spj_boardList">
						&nbsp; 게시판
					</a>
				</li>

				<li class="nav-item">
					<a class="nav-link" href="spj_about">
						&nbsp; About 알바's 
					</a>
				</li>
				</ul>
				
				<ul class="navbar-nav nav-login ms-auto mb-2 mb-lg-0">
				<sec:authorize access="isAnonymous()">
					<li class="nav-item">
						<a class="nav-link" href="spj_login">
							&nbsp; 로그인 
						</a>
					</li>
					
					<li class="nav-item">
						<a class="nav-link" href="spj_join">
							&nbsp; 회원가입 
						</a>
					</li>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<div class="collapse navbar-collapse" id="navbarNavDropdown">
   						 <ul class="navbar-nav">
						 	<li class="nav-item dropdown">
       							 <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         						 마이페이지
        						 </a>
        					
        						<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
         							 <a class="dropdown-item" href="myWageBill">나의 명세서</a>
         						 	 <a class="dropdown-item" href="#">나의 게시글</a>
      							</div>
    						</li>
   						</ul>
 					</div>
					<!-- nav에 있는 '로그아웃'을 누르면 바로 로그아웃처리되게 함. -->
					<!-- '로그아웃'을 누르면 id가 logout-form인 form을 submit처리하게 하여 로그아웃 처리 (action="logout") -->
					<!-- form태그는 숨김처리해서 화면에는 나오지 않고, '로그아웃'을 누르면 form이 실행되게끔만 처리함. -->
				 
					<li class="nav-item">
						<a class="nav-link" href="#" onclick="document.getElementById('logout-form').submit();">
							&nbsp; 로그아웃 
						</a>
					</li>
					
					<form id="logout-form" style="display: none" action="logout" method="POST">
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					</form>
					
				</sec:authorize>
			</ul>
		</div>
	</div>
</nav>
	
<script>
	$("button").click(unction(){
		$("ul").toggle();
	});
</script>

</body>
</html>