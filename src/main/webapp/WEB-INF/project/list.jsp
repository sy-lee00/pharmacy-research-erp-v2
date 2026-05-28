<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="../../resource/css/boot.css">
<link rel="stylesheet" href="../../resource/css/layout.css">
<link rel="stylesheet" href="../resource/css/erp.css">
<title>Projects</title>
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
				<a href="#">프로젝트 목록</a>
			</h1>
			<form action="/project/list" method="get" class="erp-search-form">
				<select name="select" id="projectSelect" class="erp-select">
					<option value="status">상태</option>
					<option value="code">프로젝트 코드</option>
					<option value="name">프로젝트 명</option>
					<option value="date">진행일정</option>
					<option value="manager">담당자</option>
				</select> <input type="text" name="search" id="projectSearch"
					class="erp-input" /> <input type="submit" value="검색"
					class="erp-btn" />
			</form>
		</div>
		<div class="erp-container">
			<span class="erp-simpleStatus">계획 : ${count1} 건</span> <span
				class="erp-simpleStatus">진행 : ${count2} 건 </span> <span
				class="erp-simpleStatus">완료 : ${count3} 건 </span>
			<button class="erp-btn erp-insert-modal" style="width: 15%;">프로젝트 추가</button>

			<form action="/project/selectDelete" method="post"
				class="erp-select-delete">
				<table class="erp-table">
					<thead>
						<tr>
							<th>No</th>
							<th>코드</th>
							<th>프로젝트명</th>
							<th>담당자</th>
							<th>타입</th>
							<th>진행상태</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>상세보기</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="list" varStatus="status">
							<tr>
								<td>${list.projectId}</td>
								<td>${list.projectCode}</td>
								<td><b>${list.projectName}</b></td>
								<td><c:choose>
										<c:when test="${list.userId != 0 && list.memberRole=='담당자'}">
                            ${list.name}
                        </c:when>
										<c:when test="${list.userId == 0}">미배정</c:when>
									</c:choose></td>
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
								<td><input type="checkbox" class="project-idList"
									name="idList" value="${list.projectId}"
									data-code="${list.projectCode}" data-name="${list.projectName}">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button type="button" class="erp-btn erp-show-modal-btn">삭제</button>
			</form>

		</div>

		<!-- 삭제 모달 -->
		<div class="erp-open-modal project-modal" id="selectDeleteModal">
			<div class="erp-modal-body">
				<h2>경고</h2>
				<div id="projectModalList"></div>
				<p>삭제하시겠습니까?</p>
				<button type="button" id="projectSelectDeleteBtn" class="erp-btn">삭제</button>
				<button type="button" class="erp-btn project-close-modal-btn">닫기</button>
			</div>
		</div>

		<nav>
			<ul class="erp-pagination">
				<li class="page-item ${paging.prev ? '' : 'disabled'}"><a
					class="page-link"
					href="/project/list?page=${paging.startPage - 1}&search=${param.search}&select=${param.select}">이전</a>
				</li>

				<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
					var="page">
					<li class="page-item ${paging.page == page ? 'active' : ''}"><a
						class="page-link"
						href="<c:choose>
                    <c:when test='${not empty param.select}'>
                        /project/list?page=${page}&search=${param.search}&select=${param.select}
                    </c:when>
                    <c:otherwise>
                        /project/searchBar?page=${page}&search=${param.search}
                    </c:otherwise>
                </c:choose>">
							${page} </a></li>
				</c:forEach>

				<li class="page-item ${paging.next ? '' : 'disabled'}"><a
					class="page-link"
					href="/project/list?page=${paging.endPage + 1}&search=${param.search}&select=${param.select}">다음</a>
				</li>
			</ul>
		</nav>
	</div>
	<div class="insert-modal erp-open-modal">
		<div class="insert-modal-body erp-modal-body">
			<jsp:include page="insert.jsp"></jsp:include>
		</div>
	</div>
	<script>
$(function(){
    $("#projectSelect").change(()=> {
        $("#projectSearch").attr("type", $("#projectSelect").val() === "date" ? "date" : "text");
    });

    $(".project-detail-btn").click((e)=>{
        const projectId = $(e.target).data("id");
        location.href = "/project/detail?projectId=" + projectId;
    });

    $(".erp-show-modal-btn").prop("disabled", true);
    $(".project-idList").change(()=>{
        const check = $(".project-idList:checked").length;
        $(".erp-show-modal-btn").prop("disabled", check === 0);
    });

    $(".erp-show-modal-btn").click(function() {
        $(".project-open-modal").hide();
        const checkList = $(".project-idList:checked").map(function() {
            return $(this).data("code") + " : " + $(this).data("name");
        }).get();
        $("#projectModalList").html(checkList.join("<br>"));
        $("#selectDeleteModal").css("display","flex");
    });

    $(".project-close-modal-btn").click(()=>$("#selectDeleteModal").hide());
    $("#selectDeleteModal").click((e)=>{
        if(e.target === e.currentTarget) $(e.currentTarget).hide();
    });

    $(".erp-insert-modal").click(function() {
        $(".insert-modal").css("display", "flex"); 
    });
  
    
    $(".close-modal").click(function() {
        $(this).closest(".insert-modal").css("display", "none");
    });
    
    $("#projectSelectDeleteBtn").click(()=>$(".erp-select-delete").submit());

    $(".erp-insertPage").click(()=>location.href = "/project/insert");
});
document.body.appendChild(logoutModal); 
logoutModal.style.zIndex = '99999'; 
</script>

</body>
</html>
