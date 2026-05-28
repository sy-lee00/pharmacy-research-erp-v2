<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>ERP</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../../resource/css/boot.css">
<link rel="stylesheet" href="../../resource/css/layout.css">
<link rel="stylesheet" href="../resource/css/erp.css">
<style>
.imgbar {
	width: 80%;
	background-image: url(../../resource/static/project.jpg);
	margin-top: 30px;
	background-size: cover;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../side.jsp"></jsp:include>
	<div class="project-container">
		<div class="imgbar">
			<h1>
				<a href="#">나의 프로젝트</a>
			</h1>
			<form action="/project/my" method="get" class="erp-search-form">
				<select name="select" id="projectSelect" class="erp-select">
					<option value="status">상태</option>
					<option value="code">프로젝트 코드</option>
					<option value="name">프로젝트 명</option>
					<option value="date">진행일정</option>
				</select> <input type="text" name="search" id="projectSearch"
					class="erp-input" /> <input type="submit" value="검색"
					class="erp-btn" />
			</form>
		</div>
		<div class="erp-container">
			<span class="erp-simpleStatus">계획 : ${count1} 건</span> <span
				class="erp-simpleStatus">진행 : ${count2} 건 </span> <span
				class="erp-simpleStatus">완료 : ${count3} 건 </span>

			<table class="erp-table">
				<thead>
					<tr>
						<th>No</th>
						<th>코드</th>
						<th>프로젝트명</th>
						<th>타입</th>
						<th>진행상태</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>상세</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userProject}" var="list" varStatus="status">
						<tr>
							<td>${list.projectId}</td>
							<td>${list.projectCode}</td>
							<td><b>${list.projectName}</b></td>
							<td>${list.projectType}</td>
							<td>${list.status}</td>
							<td><fmt:formatDate value="${list.startDate}"
									pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${list.endDate}"
									pattern="yyyy-MM-dd" /></td>
							<td>
								<button type="button" class="erp-btn project-detail-btn"
									data-id="${list.projectId}">details</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<nav>
			<ul class="erp-pagination">
				<li class="page-item ${paging.prev ? '' : 'disabled'}"><a
					class="page-link"
					href="/project/my?page=${paging.startPage - 1}&search=${param.search}&select=${param.select}">이전</a>
				</li>

				<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
					var="page">
					<li class="page-item ${paging.page == page ? 'active' : ''}"><a
						class="page-link "
						href="/project/my?page=${page}&search=${param.search}&select=${param.select}">${page}</a>
					</li>
				</c:forEach>

				<li class="page-item ${paging.next ? '' : 'disabled'}"><a
					class="page-link"
					href="/project/my?page=${paging.endPage + 1}&search=${param.search}&select=${param.select}">다음</a>
				</li>
			</ul>
		</nav>
	</div>
	<script>
$(function(){
    $("#projectSelect").change(()=> {
        $("#projectSearch").attr("type", $("#projectSelect").val() === "date" ? "date" : "text");
    });

    $(".project-detail-btn").click((e)=>{
        const projectId = $(e.target).data("id");
        console.log(projectId);
        location.href = "/project/detail?projectId=" + projectId;
    });

});
document.body.appendChild(logoutModal); 
logoutModal.style.zIndex = '99999'; 
</script>

</body>
</html>
