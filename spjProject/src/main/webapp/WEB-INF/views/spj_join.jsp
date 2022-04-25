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
	<title>spj_join</title>
<style>

html {
    position: relative;
    min-height: 100%;
    margin: 0;
}

body {
    min-height: 100%;
}

.join-text1 {
	font-weight: bolder;
	font-size: 26px;
}

form {
	width: 50%;
	margin: 0 auto;
}
</style>
</head>
<body>

	<%@ include file="spj_nav.jsp"%>
	
	<div id ="main" class="container mt-5 mb-5"> <!-- modal창 + 회원가입화면을 감싸는 영역 div -->
	
		<!-- 모달은 회원가입 성공 여부에 따른 메세지 출력, 서버에서 응답 도착시 자동 모달버튼 클릭 -->
		<!-- 모달창 관련하여, 부트스트랩 및 https://zzznara2.tistory.com/588 블로그 참고 -->
		<input type="hidden" class="btn btn-lg" id="modalBtn" data-toggle="modal" data-target="#myModal" value="modal">
	
		<!-- modal창 -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog  modal-dialog-centered modal-sm text-center">
				<div class="modal-content">
					<div class="modal-header bg-light">
						<h4 class="modal-title">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;회원가입</h4>
					</div>
					
					<div class="modal-body bg-light">
						<h4>회원 가입을 축하 합니다.</h4>
					</div>
					
					<div class="modal-footer bg-light">
						<button type="button" class="btn btn-default btn-outline-dark" id="closeBtn" data-dismiss="modal"> close</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 회원 가입 창 -->
		<p class="join-text1 text-center mt-5">회원가입</p>


		<form action="join" method="post" id="frm1" name="frm1">
			<hr/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			
			<div class="form-group">
				<label for="uid">아이디</label> 
				<input type="email" class="form-control" name="pid" placeholder="E-Mail주소 입력" id="uid" required />
			</div>
			
			<div class="form-group">
				<label for="upw">비밀번호</label> 
				<input type="password" class="form-control" name="ppw" id="upw" placeholder="비밀번호 입력" required />
			</div>

			<div class="form-group mt-2">
				<label for="uname">이름</label> 
				<input type="text" class="form-control"	name="pname" id="uname" placeholder="이름 입력" required />
			</div>
			
			<div class="form-group">
				<label for="ubirth">생년월일</label> 
				<input type="text" class="form-control" name="pbirth" id="ubirth" placeholder="생년월일 입력 (yyyy/mm/dd)" required />
			</div>
			
			<div class="form-group">
				<label for="uprofile">프로필</label>
				<textarea class="form-control" name="pprofile" id="uprofile" rows="5" placeholder="자기소개를 작성하세요" required></textarea>
			</div>
			
			<div class="mb-5">
				<button type="submit" class="btn btn-outline-dark">회원가입</button> &nbsp;&nbsp;
				<button type="reset" class="btn btn-outline-dark">취 소</button>
			</div>
		</form>
	</div>

	<%@ include file="spj_footer.jsp"%>


	<!--  회원가입이 되면, 회원가입을 축하합니다가 뜨고 로그인 페이지로 이동해야 함. -->
<script>
$(document).ready(function(){
	$("#frm1").submit(function(event){
		event.preventDefault(); //html의 submit이벤트 처리를 중단
		$.ajax({
			type : $("#frm1").attr("method"), // post
			url :  $("#frm1").attr("action"), // "join"
			data : $("#frm1").serialize(),    //form의 입력 내용을 문자열로 변환
			success : function(data) {
				if(data.search("join-success") > -1) {
					$(".modal-body").text("회원가입을 축하합니다");
					//$("#modalBtn")[0].click();	//자동클릭
					$("#modalBtn").trigger("click");//자동클릭
					$("#closeBtn").click(function(event){
						event.preventDefault();
						location.href = "spj_login";
						// alert("완료");
					});
				}
				else {
					$(".modal-body").text("동일한 아이디가 존재합니다");
					$("#modalBtn").trigger("click");
					// alert("전송된 값 없음");
				}
			},
			error : function(data) {
				$(".modal-body").text("동일한 아이디가 존재하거나 전송 실패입니다. 다시 시도해 주세요");
				$("#modalBtn").trigger("click");
				// alert("에러 발생");
			}
		});
	});
});
</script>
</body>
</html>