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
	
<title>spj_boardModify</title>
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

.board_title p {
	margin-top: 5px;
	font-size: 16px;
}

.board_write {
	border-top: 2px solid #000;
}

.board_write .title, .board_write .info {
	padding: 10px;
}

.board_write .info {
	border-top: 1px dashed #ddd;
	border-bottom: 1px solid #000;
	font-size: 0;
}

.board_write .title dl {
	font-size: 0;
}

.board_write .info dl {
	display: inline-block;
	width: 50%;
	vertical-align: middle;
}

.board_write .title dt, .board_write .title dd, .board_write .info dt,
	.board_write .info dd {
	display: inline-block;
	vertical-align: middle;
	font-size: 16px;
}

.board_write .title dt, .board_write .info dt {
	width: 100px;
}

.board_write .title dd {
	width: calc(100% - 100px);
}

.board_write .title input[type="text"], .board_write .info input[type="text"],
	.board_write .info input[type="password"] {
	padding: 10px;
	box-sizing: border-box;
}

.board_write .title input[type="text"] {
	width: 77%;
}

.board_write .cont {
	border-bottom: 1px solid #000;
}

.board_write .cont textarea {
	display: block;
	width: 100%;
	height: 300px;
	padding: 15px;
	box-sizing: border-box;
	border: 0;
	resize: vertical;
}


.bt_wrap {
    margin-top: 30px;
    text-align: center;
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

button {
	display: inline-block;
    min-width: 80px;
    min-height: 46px;
    margin-left: 10px;
    padding: 10px;
    border: 1px solid #000;
    font-size: 16px;
}

</style>
</head>
<body>


	<%@ include file="spj_nav.jsp"%>

	<div class="board-table mt-5 mb-5">
		<div class="board_title">
			<strong>게시글 수정</strong>
		</div>

		<form action="modify" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="board_write">
				<div class="title">
					<dl>
						<dt>제목</dt>
						<dd>
							<input type="hidden" height="80" class="form-control" id="uid" 
							name="bid" required value="${content_view.bid}" required>
							<input type="text" height="80" class="form-control" id="utitle" placeholder="Title" 
							name="btitle" required value="${content_view.btitle}" required>
						</dd>
					</dl>
				</div>
			
				<div class="info">
					<dl>
						<dt>작성자</dt>
						<dd>
							<input type="text" class="form-control" id="uname" placeholder="Enter email" 
							name="buser" required value="${content_view.buser}" readonly>	
						</dd>
					</dl>
				</div>
			
				<div class="cont">
					<textarea class="form-control" id="content" placeholder="내용 입력" name="bcontent">
						${content_view.bcontent}
					</textarea>
				</div>
			</div>
	
			<div class="bt_wrap mb-5">
				<button type="submit" id="modi" class="btn btn-dark">수정 완료</button> 
				<a href="spj_boardList" class="btn btn-dark">취소</a>
			</div>	
		</form>
	</div>

	<%@ include file="spj_footer.jsp"%>

</body>
</html>