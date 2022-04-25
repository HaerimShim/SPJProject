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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" 
 integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" 
 crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
</head>

<body>
<div class="board_title">
		<strong>게시판</strong>
	</div>
		<span class="bt_wrap">
			<a href="spj_freeboardWrite" class="btn btn-dark mb-2">게시글 작성</a>
			<!--<a href="#">수정</a>-->
		</span>
		
		<table id="searchTable" class="board_list">
			<thead class="top">
				<tr>
					<th class="num">번호</th>
					<th class="title">제목</th>
					<th class="writer">작성자</th>
					<th class="date">작성일</th>
					<th class="count">조회</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listContent}" var="dto">
					<tr>
						<td class="num" id="bid">${dto.bid}</td>
						<td class="title">
							<a class="spj_freeboardView" href="spj_freeboardView?bId=${dto.bid}">${dto.btitle}</a>
						</td>
						<td class="writer">${dto.buser}</td>
						<td class="date">${dto.bdate}</td>
						<td class="count">${dto.bhit}</td>
					</tr>
				</c:forEach>
			</tbody>			
		</table>
		<br/><br/>
	<!-- 검색창 -->
	<div class="search-wrap">	
		<form action="" > 
			<div class="input-group">
				<select name="type">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>
				<input type="text" class="form-control search-input" id="searchInput" placeholder="검색어를 입력하세요" 
					aria-label="검색어를 입력하세요." aria-describedby="basic-addon2"/>
				<button class="btn btn-outline-dark serch-btn" type="submit"
					style="width: 100px">검색</button>	
					
			</div>
		</form>
	</div>	
	

</body>
</html>