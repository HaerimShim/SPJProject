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

<!--  
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>

html {
    position: relative;
    min-height: 100%;
    margin: 0;
}

body {
    min-height: 100%;
}

.record-text1 {
	font-weight: bolder;
	font-size: 26px;
}

form {
	width: 40%;
	margin: 0 auto;
}


</style>
</head>
<title>main</title>
<body>


<%@ include file="spj_nav.jsp" %>

	<p class="record-text1 text-center mt-5">알바비 계산/기록</p>
	<form action="record" method="POST" id="frm1" name="frm1">
		<hr/>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		
		<div class="form-group">
			<label for="ucompany">회사명(매장명): </label>
				<input type="text" class="form-control" name="rcompany" placeholder="회사명(매장명) 입력" id="ucompany" required />
		</div>
		<div class="form-group">
			<label for="uuser">아이디</label> 
			<input type="text" class="form-control" name="ruser" id="uuser" required value="${user}" placeholder="닉네임 입력" readonly />
		</div>
		<div class="form-group">
			<label for="utime_from">시작 시간</label> 
			<input type="datetime-local" class="form-control" name="rtime_from" id="utime_from" placeholder="시간 입력" required />
		</div>
		<div class="form-group">
			<label for="utime_to">종료 시간</label> 
			<input type="datetime-local" class="form-control" name="rtime_to" id="utime_to" placeholder="시간 입력" required />
		</div>
		<div class="form-group">
			<label for="utime_day">근무 시간 (종료시간 - 시작시간)</label> 
			<input type="text" class="form-control" name="rtime_day" id="utime_day" placeholder="근무시간 입력" value="" readonly  />
		</div>
		
		<div class="form-group">
			<label for="uwage_hour">시급 </label> 
			<input type="text" class="form-control" name="rwage_hour" id="uwage_hour" placeholder="시급 입력" required />
		</div>
			<div class="form-group">
			<label for="uwage_day">일급 (근무시간 * 시급) </label> 
			<input type="text" class="form-control" name="rwage_day" id="uwage_day" placeholder="일급 입력"  value="" readonly  />
		</div>
		
		<div class="mb-5">
			<button type="submit" class="btn btn-outline-dark">저 장</button> &nbsp;&nbsp;
			<a href="spj_main" class="btn btn-outline-dark">취 소</a>
		</div>
	</form>
 
	<script>
		$(document).ready(function(){
			$("#utime_from").change(function(){
				var f = $("#utime_from").val();
				var from = new Date(f);         
				console.log(from);
				var milfrom = from.getTime();
				console.log(milfrom);

			// 근무시간 계산 (종료시간 - 시작시간)		
			$("#utime_to").change(function(){
				var t = $("#utime_to").val();
				var to = new Date(t);
				console.log(to);
				var milto = to.getTime();
				console.log(milto);
				// 밀리세컨드를 1시간으로 변환 -> 1000*60*60
				var timeDiff = (milto - milfrom)/(1000*60*60); 
				// .toFixed(2); 근무시간 계산을 소수점 2자리에서 반올림
				var timeDiff = timeDiff.toFixed(2);
				$('input[name=rtime_day]').attr('value',timeDiff);

			// 일급 계산 (근무시간 * 시급)
			// 알바 기록을 하는 form에 변화가 생기면, 시급을 다시 계산할 수 있도록  $("#frm1").change(function(){ 로 설정함.
			// 그렇지 않을 경우, 근무시간이나 시급을 수정했을 때 수정사항이 반영되지 않음.
			$("#frm1").change(function(){
				var wage_hour = $("#uwage_hour").val();
				console.log(wage_hour);
				
				var wage_day = timeDiff * wage_hour;
				// .toFixed(2); 일급계산을 소수점 2자리에서 반올림
				var wage_day = wage_day.toFixed(2);
					$('input[name=rwage_day]').attr('value',wage_day);
						
						});	
					});
				});
			});
		
	</script>

<%@ include file="spj_footer.jsp" %>

	
</body>
</html>