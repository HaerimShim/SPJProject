<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>   
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>             
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" 
 integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" 
 crossorigin="anonymous">

<!--
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>socialLogin</title>
<style>
h3 {
  color: white;
  text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;
}
</style>
</head>
<body onload="init()">

<div class="container">
	<form id="frm1" name="frm1" method="post" action="login">
		<!-- csrf를 방지하기 위한 헤더 부분 추가 -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		
		<div class="form-group">
 		 	<label for="uId"></label>
 		 	<input type="hidden" class="form-control" name="pid" id="uId" value="1111@aaa.com"/>
 		</div>
 		
 		<div class="form-group">
 		 	<label for="uPw"></label>
 		 	<input type="hidden" class="form-control" name="ppw" id="uPw" value="1111"/>
 		 </div> 
 		 
 		 <button id="subm" type="submit" class="btn btn-success">로그인</button>&nbsp;&nbsp; 		 
	</form>
</div>

<script>
function init() {
	$("#subm").css("visibility","hidden");
	$("#subm").trigger("click");
}
</script>
</body>
</html>