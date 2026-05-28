<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Project Detail</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="../../resource/css/boot.css">
<link rel="stylesheet" href="../../resource/css/layout.css">
<link rel="stylesheet" href="../resource/css/erp.css">
<style>
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../side.jsp"></jsp:include>
	<div class="erp-detail-header">
		<span class="detail-title">상세 보기</span>
	</div>
	<div id="allDetailMenu">
		<div id="leftDetailMenu">
			<div>
				<form action="/project/update" method="post" id="updateForm">
					<input type="hidden" id="projectId" name="projectId"
						value="${project.projectId}" />

					<p>
						<span class="erp-field-name">코 드 :</span> <span
							class="erp-field-value">${project.projectCode}</span>
					</p>
					<p>
						<span class="erp-field-name">프로젝트 명 :</span> <span
							class="erp-field-value">${project.projectName}</span>
					</p>
					<p>
						<span class="erp-field-name">타 입 :</span> <span
							class="erp-field-value">${project.projectType}</span>
					</p>
					<p>
						<span class="erp-field-name">내 용 :</span> <span
							class="erp-field-value">${project.description}</span>
					</p>
					<p>
						<span class="erp-field-name">생성일 :</span> <span
							class="erp-field-value"><fmt:formatDate
								value='${project.createdAt}' pattern='yyyy-MM-dd' /></span>
					</p>

					<p>
						<span class="erp-field-name">진행상태 :</span> <select name="status"
							id="status" class="erp-select">
							<option value="계획중"
								<c:if test="${project.status == '계획중'}">selected</c:if>>계획중</option>
							<option value="진행중"
								<c:if test="${project.status == '진행중'}">selected</c:if>>진행중</option>
							<option value="완료"
								<c:if test="${project.status == '완료'}">selected</c:if>>완료</option>
						</select>
					</p>

					<p>
						<span class="erp-field-name">담당자 :</span> <span
							class="erp-field-value">${project.name}</span>
					</p>
					<input type="hidden" name="userId"
						value="${project.userId != null ? project.userId : 0}">

					<p>
						<span class="erp-field-name">시작일 :</span> <input type="date"
							name="startDate" id="startDate"
							value="<fmt:formatDate value='${project.startDate}' pattern='yyyy-MM-dd' />"
							class="erp-input" />
					</p>
					<p>
						<span class="erp-field-name">종료일 :</span> <input type="date"
							name="endDate" id="endDate"
							value="<fmt:formatDate value='${project.endDate}' pattern='yyyy-MM-dd' />"
							class="erp-input" />
					</p>

					<p id="updateError" class="erp-error"></p>

					<p>
						<span class="field-name">최종 수정일 :</span> <span class="field-value"><fmt:formatDate
								value="${project.updatedAt}" pattern="yyyy년 MM월 dd일 HH:mm:ss" /></span>
					</p>
					
						<div class="erp-button-container">
						<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
							<button type="submit" id="projectUpdate" class="erp-btn">수정</button>
							<button type="button" class="erp-btn project-show-modal"
								id="projectDeleteBtn">삭제</button>
								</sec:authorize>
						
						<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
							<button type="button" id="listPage" class="erp-btn erp-list-btn" style="width: 150px;">목록으로
								돌아가기</button>
						</sec:authorize>
						<sec:authorize access="hasRole('RESEARCHER')">
							<button type="button" id="myListPage"
								class="erp-btn erp-list-btn" style="width: 150px;">목록으로 돌아가기</button>
						</sec:authorize>
					</div>

				</form>
			</div>
		</div>

		<div id="rightDetailMenu">
		<div class="tab-container">
			<a href="#member" class="erp-detail-tab active" id="memberTab">member</a>
			<a href="#chemical" class="erp-detail-tab" id="chemicalTab">chemical</a>
			<a href="#document" class="erp-detail-tab" id="documentTab">document</a>
			<a href="#schedule" class="erp-detail-tab" id="scheduleTab">schedule</a>
			<a href="#claim" class="erp-detail-tab" id="claimTab">claim</a>
		</div>
			<div id="detailContent">
				<div id="memberContent">
					<jsp:include page="member.jsp"></jsp:include>
				</div>
				<div id="chemicalContent">
					<jsp:include page="chemical.jsp">
						<jsp:param name="projectId" value="${project.projectId}" />
					</jsp:include>
				</div>
				<div id="documentContent">
					<jsp:include page="document.jsp"></jsp:include>
				</div>
				<div id="scheduleContent">
					<jsp:include page="projectSchedule.jsp"></jsp:include>
				</div>
				<div id="claimContent">
					<jsp:include page="claim.jsp"></jsp:include>
				</div>
			</div>
		</div>

		<div class="erp-open-modal project-delete-modal" id="deleteModal">
			<div class="erp-modal-body">
				<h3>삭제하시겠습니까?</h3>
				<button type="submit" id="projectDelete"
					data-id="${project.projectId}" class="erp-btn">삭제</button>
				<button class="erp-btn project-close-modal">닫기</button>
			</div>
		</div>
		
	</div>
<script>
$(function(){
    $("#projectDeleteBtn").click(function() {
        $(".project-delete-modal").css("display","flex");
    });
    $(".project-delete-modal .project-close-modal").click(function() {
        $(".project-delete-modal").hide();
    });
    $(".project-delete-modal").click(function(e){
        if(e.target === this){
            $(this).hide();
        }
    });

    $("#projectDelete").click(function(e) {
        const projectId = $(this).data("id");
        $.ajax({
            type : "get",
            url : "/project/delete",
            data : "projectId=" + projectId,
            success : function(result) {
                alert("삭제 성공");
                location.href = "/project/list";
            },
            error : function(xhr, status, error) {
                alert("오류로 인해 삭제에 실패했습니다.");
                $(".project-delete-modal").hide();
            }
        });
    });
    $("#listPage").click(()=> location.href = "/project/list");
    $("#myListPage").click(()=> location.href = "/project/my");

    function showTab(tabName){
        $(".erp-detail-tab").removeClass("active");
        $("#" + tabName + "Tab").addClass("active");
        $("#detailContent > div").hide();
        $("#" + tabName + "Content").show();
    }

    let hash = location.hash.replace("#", "");
    if(hash) showTab(hash);
    else showTab("member");

    $(".erp-detail-tab").click(function(e){
        e.preventDefault();
        let tabName = $(this).attr("id").replace("Tab","");
        showTab(tabName);
        location.hash = tabName;
    });

    $(window).on("hashchange", function(){
        let hash = location.hash.replace("#", "");
        if(hash) showTab(hash); else showTab("member");
    });

    const updateBtn = $("#projectUpdate");
    const startDate = $("#startDate");
    const endDate = $("#endDate");
    const updateError = $("#updateError");
    const userId = $("input[name='userId']").val();

    function check() {
        let start = startDate.val();
        let end = endDate.val();
        let errorMsg = "";

        if(!userId || userId == 0){
            errorMsg = "담당자를 배정해주세요.";
        } else if(start && end && new Date(start) > new Date(end)){
            errorMsg = "종료일은 시작일 이후로 지정해주세요.";
        }

        if(errorMsg){
           	updateBtn.prop("disabled", true).css("opacity", 0.5);
            updateError.text(errorMsg).css("color","red");
        } else {
            updateBtn.prop("disabled", false).css("opacity", 1);
            updateError.text("");
        }
    }

    check();

    startDate.on("change", check);
    endDate.on("change", check);

    $("#updateForm").on("submit", function(e) {
        check();
        if($updateBtn.prop("disabled")) e.preventDefault();
    });
});
</script>
</body>
</html>
