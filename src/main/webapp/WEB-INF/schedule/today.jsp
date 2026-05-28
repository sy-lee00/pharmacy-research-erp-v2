<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="../../resource/css/boot.css">
<link rel="stylesheet" href="../../resource/css/layout.css">
<link rel="stylesheet" href="../../resource/css/erp.css">

<title>Today's</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap');
.imgbar {
	width: 80%;
	background-image: url(../../resource/static/calendar.jpg);
}

</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../side.jsp"></jsp:include>

	<div class="schedule-container my-page">
		<div class="imgbar">
			<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
				<h1>
					<a href="/today/my">전체 일정 목록</a>
				</h1>
			</sec:authorize>
			<sec:authorize access="hasRole('RESEARCHER')">
				<h1>
					<a href="/today/my">'<sec:authentication property="principal.name" />'
					<span style="font-size: 2rem;">님의 오늘 일정</span></a>
				</h1>
			</sec:authorize>
			<form class="erp-search-form" action="/today/my" method="get">
				<input type="text" name="keyword" class="erp-input" style="width:250px; margin-right:10px;"/>
				<button class="erp-btn">검색</button>
			</form>
		</div>

		<div class="today-wrap">
			<table class="erp-today-table today-table">
				<thead>
					<tr>
						<th>No</th>
						<th>일정명</th>
						<th>프로젝트명</th>

						<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
							<th>업무 담당자</th>
						</sec:authorize>

						<th>내용</th>
						<th>일정 시작</th>
						<th>일정 종료</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${todayUser}" var="today" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td>${today.title}</td>
							<td><a
								href="/project/detail?projectId=${today.projectId}#schedule"
								style="text-decoration: none; font-weight:bold;">${today.projectName}
								</a></td>

							<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
								<td>${today.name}</td>
							</sec:authorize>

							<td><textarea class="project-description">${today.scheDescription}</textarea></td>
							<td><input type="datetime-local" class="project-start"
								value="<fmt:formatDate value='${today.scheStartDatetime}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
								min="<fmt:formatDate value='${today.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
								max="<fmt:formatDate value='${today.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />">
							</td>
							<td><input type="datetime-local" class="project-end"
								value="<fmt:formatDate value='${today.scheEndDatetime}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
								min="<fmt:formatDate value='${today.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
								max="<fmt:formatDate value='${today.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />">
							</td>
							<td><button type="button"
									class="project-btn project-schedule-update-btn"
									data-id="${today.scheduleId}">수정</button></td>
							<td><button type="button"
									class="project-btn project-schedule-delete-btn"
									data-id="${today.scheduleId}" data-project="${today.projectId}">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<nav>
			<ul class="erp-pagination">
				<li class="page-item ${paging.prev ? '' : 'disabled'}"><a
					class="page-link"
					href="/today/my?page=${paging.startPage - 1}&keyword=${paging.keyword}">이전</a>
				</li>

				<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
					var="page">
					<li class="page-item ${paging.page == page ? 'active' : ''}">
						<a class="page-link"
						href="/today/my?page=${page}&keyword=${paging.keyword}">${page}</a>
					</li>
				</c:forEach>

				<li class="page-item ${paging.next ? '' : 'disabled'}"><a
					class="page-link"
					href="/today/my?page=${paging.endPage + 1}&keyword=${paging.keyword}">다음</a>
				</li>
			</ul>
		</nav>
	</div>
</body>
<script>

$(".project-schedule-delete-btn").click(function(){
    const scheduleId = $(this).data("id");
    const projectId = $(this).data("project");

    $.ajax({
        url: "/schedule/proScheDel",
        type: "post",
        data: { scheduleId, projectId },
        success: function(response){
        	alert("삭제되었습니다.");
        	location.reload();
        }
    });
});

$(".project-start").each(function() {
    const row = $(this).closest("tr");
    const startInput = $(this);
    const endInput = row.find(".project-end");

    endInput.attr("min", startInput.val());

    if (endInput.val() < startInput.val()) {
        endInput.val(startInput.val());
    }
});

$(".project-start").on("change", function() {
    const row = $(this).closest("tr");
    const startInput = $(this);
    const endInput = row.find(".project-end");

    endInput.attr("min", startInput.val());

    if (endInput.val() < startInput.val()) {
        endInput.val(startInput.val());
    }
});

$(".project-schedule-update-btn").click(function() {
    const row = $(this).closest("tr");
    const scheduleId = $(this).data("id");
    const description = row.find(".project-description").val();
    const startDatetime = row.find(".project-start").val();
    const endDatetime = row.find(".project-end").val();

    if (endDatetime < startDatetime) {
        alert("종료일은 시작일 이후여야 합니다.");
        return;
    }

    $.ajax({
        url: "/project/proSche",
        type: "post",
        data: { scheduleId, description, startDatetime, endDatetime },
        success: function(response){
            alert("수정되었습니다.");
        }
    });
});

document.body.appendChild(logoutModal);
logoutModal.style.zIndex = '99999';
</script>
</html>
