<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 추가 -->           
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" 
 integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" 
 crossorigin="anonymous">
 <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Jua&display=swap" rel="stylesheet">

<!--
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>spj_main</title>
<style>
html {
    position: relative;
    min-height: 100%;
    margin: 0;
}

body {
    min-height: 100%;
}

h1, h4{
	font-weight: 900;
	}

.hd {
    background-size: cover;
    }

.card {
	text-align: center;
}

.card-body {
	font-size: 20px;
	font-family: 'Jua', sans-serif;
}
</style>
</head>
<body>

<%@ include file="spj_nav.jsp" %>
<%@ include file="spj_header.jsp" %>
	    
	<div class="card-group justify-content-center mb-5 mt-4">
		<div class="card">
			<div class="card-body text-center">
				<a href="spj_record" style="text-decoration:none;" >
					<img src="images/main1.png" style="width: 80px;" class="card-img-top mt-4 mb-4" alt="...">
				</a>
				<p>
					▶ 알바비 계산/기록 <br/><br/> 매일 근무 내역을 기록하고, <br/> 알바비 명세서로 간편하게 확인하세요
				</p>
			</div>
		</div>

		<div class="card">
			<div class="card-body text-center">
				<a href="spj_boardList" style="text-decoration:none;" >
					<img src="images/main2.png" style="width: 80px;" class="card-img-top mt-4 mb-4" alt="...">
				</a>
				<p>
					▶ 게시판 <br/><br/> 아르바이트 관련 궁금증이나 꿀팁을, <br/> 여러 사람들과 공유하세요 
				</p>
			</div>
		</div>

		<div class="card">
			<div class="card-body text-center">
				<a href="spj_about" style="text-decoration:none;" >
					<img src="images/main3.png" style="width: 80px;" class="card-img-top mt-4 mb-4" alt="...">
				</a>
				<p>
					▶ About 알바's <br/><br/> 알바's 의 프로젝트 개요 <br/> 제작 목적, 구현 기능 및 개발환경
				</p>
			</div>
		</div>
	</div>
        
<div class="mb-5"></div>
      
<%@ include file="spj_footer.jsp" %>

	
</body>
</html>