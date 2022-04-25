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
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">

<!--
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
-->
<!--  
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
-->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>spj_boardView</title>
<style>
* {
	margin: 0;
	padding: 0;
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

.board_view {
	width: 100%;
	border-top: 2px solid #000;
}

.board_view .title {
	padding: 20px 15px;
	border-bottom: 1px dashed #ddd;
	font-size: 16px;
}

.board_view .info {
	padding: 15px;
	border-bottom: 1px solid #999;
	font-size: 0;
}

.board_view .info dl {
	position: relative;
	display: inline-block;
	padding: 0 20px;
}

.board_view .info dl:first-child {
	padding-left: 0;
}

.board_view .info dl::before {
	content: "";
	position: absolute;
	top: 1px;
	left: 0;
	display: block;
	width: 1px;
	height: 13px;
	background: #ddd;
}

.board_view .info dl:first-child::before {
	display: none;
}

.board_view .info dl dt, .board_view .info dl dd {
	display: inline-block;
	font-size: 16px;
}

.board_view .info dl dt {
	
}

.board_view .info dl dd {
	margin-left: 10px;
	color: #777;
}

.board_view .cont {
	padding: 15px;
	border-bottom: 1px solid #000;
	line-height: 160%;
	font-size: 16px;
}

.bt_wrap {
    margin-top: 30px;
    text-align: center;
    font-size: 0;
}

.bt_wrap a {
    display: inline-block;
    margin-left: 10px;
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
</style>
</head>
<body>
	

	<%@ include file="spj_nav.jsp"%>

<div class="board-table mt-5">
	<div class="board_title">
	<strong>게시판</strong>
	</div>

		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />		    
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                    <label for="title">제목:</label>
					${content_view.btitle}
                </div>
                <div class="info">
                    <dl>
                       <dt>번호</dt>
					   <dd>
					   <input type="hidden" class="form-control" value="${content_view.bid}" />	
					   ${content_view.bid}</dd>
                    </dl>
                    <dl>
                        <dt>작성자</dt>
						<dd>${content_view.buser}</dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd>${content_view.bdate}</dd>
                    </dl>
                    <dl>
                        <dt>조회</dt>
						<dd>${content_view.bhit}</dd>
                    </dl>
                </div>
                <div class="cont">
                    ${content_view.bcontent}
                </div>
            </div>
            <div class="bt_wrap">
            	<a href="spj_boardModify?bid=${content_view.bid}" id="modi" class="btn btn-dark">수정</a>
				<a href="delete?bid=${content_view.bid}" id="del" class="btn btn-dark">삭제</a>
                <a href="spj_boardList" class="btn btn-dark">목록</a>
            </div>
        </div>

</div>

	<%@ include file="spj_footer.jsp"%>

<script>
$(document).ready(function(){
	//수정버튼 클릭시 buser과 username(이용자) 비교해서 다르면 수정 못하게 함
	//삭제 버튼클릭시 buser과 username(이용자) 비교해서 다르면 삭제 못하게 함
	
	var username = '<c:out value="${user}"/>';	//로그인 이용자, 주화면인 board.jsp에 있음
	var bnic = '<c:out value="${content_view.buser}" />';	//작성자 아이디
	//modify
	$("#modi").click(function(){
		if(username != buser) {
			alert("권한이 없습니다.");
			return false; //클릭동작 해제
		}
	});
	
	//delete
	$("#del").click(function(){
		if(username != buser) {
			alert("권한이 없습니다.");
			return false; //클릭동작 해제
		}
	});
});
</script>


</body>
</html>