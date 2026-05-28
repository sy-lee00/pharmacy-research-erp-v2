<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="../../resource/css/boot.css">
<link rel="stylesheet" href="../../resource/css/erp.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap');
</style>
</head>


<div class="board-view">
<h1 id="board-title">Contents</h1>
	<div class="board-container">
		<div class="row">
			<div class="col-md-8">
				<form action="/customer/update" method="post" enctype="multipart/form-data">
					<input type="hidden" name="boardNo" value="${board.boardNo} ">
					<input type="hidden" name="url" value="${board.url}">
				<div class="form-group">
					<label>제목</label>
					<input class="form-control" name="title" value="${board.title}">
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" name="content">${board.content}</textarea>
				</div>
				<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
				<div class="form-group">
					<label>파일을 첨부해주세요</label>
					<input class="form-control" name="file" type="file">	
				</div>
				<button id="updateBoard" type="submit" class="btn btn-warning mt-3">수정</button>
				</sec:authorize>
				<a href="../../resource/upload/${board.url}" download="image.jpg" class="btn btn-danger mt-3">다운로드</a>
				<sec:authorize access="hasAnyRole('MANAGER','ADMIN','RESEARCHER')">
				<a href="javascript:window.close()" class="btn btn-secondary mt-3"> 닫기</a>
				</sec:authorize>
				</form>
			</div>
			<div class="col-md-4 text-center">
				<img src="../../resource/upload/${board.url}" class="img-fluid rounded mt-3" alt="게시판 이미지" /> 
			</div>
		</div>
	</div>
</div>	
	<script>
	 $("#updateBoard").click(()=>{
			alert("수정이 완료되었습니다.");
			location.reload();
	</script>
	
</html>
