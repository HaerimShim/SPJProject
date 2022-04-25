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

<!--
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>spj_login</title>
<style>
html {
	position: relative;
	min-height: 100%;
	margin: 0;
}

body {
	min-height: 100%;
}

h1 {
	font-weight: 900;
}

.social-logo {
	width: 34px;
	height: 34px;
}

span {
	font-size: 14px;
	text-aling: center;
}

.login-text1 {
	font-weight: bolder;
	font-size: 26px;
}

form {
	width: 60%;
	margin: 0 auto;
}
</style>

</head>
<body>

	<%@ include file="spj_nav.jsp"%>
	<%@ include file="spj_header.jsp"%>

	<div id="main" class="container mb-5">
		<form id="frm1" name="frm1" method="post" action="login">
			<p class="login-text1 mt-3">로그인</p>
			<hr />
			<!-- login결과를 ajax에서 출력 -->
			<div id="div1" class="text-danger"></div>
			<!-- spring security에서는 form을 이용하여 로그인해야 하며 action의 login은 시큐리티에서
	        사용하는 기본값으로 controller의 login으로 요청하는 것이 아니고 스프링시큐리트로 요청 -->
			<!-- csrf를 방지하기 위한 헤더 부분 추가 -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			
			<div class="form-group">
				<label for="uid">아이디</label> 
				<input type="email"	class="form-control" name="pid" placeholder="E-Mail주소 입력" id="uid"	required />
			</div>
			
			<div class="form-group">
				<label for="upw">비밀번호</label> 
				<input type="password" class="form-control" name="ppw" id="upw" placeholder="비밀번호 입력" required />
			</div>
			
			<div class="form-group form-check">
				<input type="checkbox" class="form-check-input" id="rememberMe"	name="remember-me" checked> 
				<label class="form-check-label" for="rememberMe" aria-describedby="rememberMeHelp">로그인 유지</label>
				<!-- aria-describedby는 스크린리더에서 사용하며 좀 더 상세한 정보 표시 -->
			</div>

			<button type="submit" class="btn btn-outline-dark">로그인</button> &nbsp;&nbsp;
			<a href="spj_join" class="btn btn-outline-dark">회원가입</a> <br />

			<a id="glog" href="${google_url}" class="btn btn-md btn-outline-dark mt-2">
				<img src="images/gg.png" class="social-logo"> &nbsp; Google+ 로그인
			</a>&nbsp;
			
			<a id="glog" href="${kakao_url}" class="btn btn-md btn-outline-dark mt-2">
				<img src="images/kk.png" class="social-logo"> &nbsp; Kakaotalk 로그인
			</a>&nbsp;
			
			<a id="glog" href="${naver_url}" class="btn btn-md btn-outline-dark mt-2">
				<img src="images/nn.png" class="social-logo"> &nbsp; Naver 로그인
			</a>&nbsp;

		</form>
	</div>

	<br/>

	<%@ include file="spj_footer.jsp"%>
	
<script>
	$(document).ready(function() {
		//로그인 결과에 따른 안내문을 #div1에 출력하는 처리	
		//if~else if~else의 JSTL에서 처리
		<c:choose>
		<c:when test="${not empty log}">
		$("#div1").text("Welcome 성공");
		</c:when>
		
		<c:when test="${not empty logout}"> 
		$("#div1").text("로그아웃 성공");
		</c:when>
		
		<c:when test="${not empty error}">
		$("#div1").text("로그인 실패 (아이디 혹은 패스워드를 다시 확인하세요.)");
		</c:when>
		
		<c:otherwise>
		$("#div1").text("환영합니다.");
		</c:otherwise>
		</c:choose>
	});
</script>
</body>
</html>