<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="project-schedule-section">
	<div class="tab-title">
	<h2>일정</h2>
</div>
	
	<button type="button" class="erp-btn erp-btn-proj project-show-sche-add-modal">일정
		등록</button>
	<input type="hidden" id="projectId" name="projectId"
		value="${param.projectId}" />

	<table class="erp-table">
		<thead>
			<tr>
				<th>일정명</th>
				<th>참여자</th>
				<th>내용</th>
				<th>시작</th>
				<th>종료</th>
				<sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
				<th>수정</th>
				<th>삭제</th>
				</sec:authorize>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${memberSchedule}" var="schedule">
				<tr>
					<td>${schedule.title}</td>
					<td>${schedule.name}</td>
					<td><textarea class="erp-description">${schedule.scheDescription}</textarea></td>
					<td><input type="datetime-local"
						class="erp-input project-start"
						value="<fmt:formatDate value='${schedule.scheStartDatetime}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
						min="<fmt:formatDate value='${project.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
						max="<fmt:formatDate value='${project.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />">
					</td>
					<td><input type="datetime-local" class="erp-input project-end"
						value="<fmt:formatDate value='${schedule.scheEndDatetime}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
						min="<fmt:formatDate value='${project.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />"
						max="<fmt:formatDate value='${project.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm' />">
					</td>
					<sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
					<td><button type="button"
							class="erp-btn project-schedule-update-btn"
							data-id="${schedule.scheduleId}">수정</button></td>
					<td><button type="button"
							class="erp-btn project-schedule-delete-btn"
							data-id="${schedule.scheduleId}"
							data-project="${param.projectId}">삭제</button></td>
					</sec:authorize>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="erp-open-modal project-sche-add-modal">
    <div class="erp-modal-body">
        <form action="/project/scheAdd" method="post" class="erp-form">
			<h2>일정 등록</h2>
			<input type="hidden" id="projectId" name="projectId"
				value="${param.projectId}" /> <input type="hidden"
				id="projectStart" value="${project.startDate.time}"> <input
				type="hidden" id="projectEnd" value="${project.endDate.time}">

			   <p>일정명 <input type="text" id="project-title" name="title" class="erp-input"></p>
			<p>
				참여자   <select id="project-user" name="userId" class="erp-select">
					<c:forEach items="${projectUserList}" var="psUser">
						<option value="${psUser.userUserId}">${psUser.name}</option>
					</c:forEach>
				</select>
			</p>
			<p>
				 <p>내용 <textarea id="project-desc" name="description" placeholder="내용을 입력해주세요" class="erp-textarea"></textarea></p>
			</p>
			<p>
				시작 <input type="datetime-local" id="project-start-dt"
					name="startDatetime"
					min="<fmt:formatDate value='${project.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
					max="<fmt:formatDate value='${project.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
					  value="<fmt:formatDate value='${project.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
                       class="erp-input">
			</p>
			<p>
				종료 <input type="datetime-local" id="project-end-dt"
					name="endDatetime"
					min="<fmt:formatDate value='${project.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
					max="<fmt:formatDate value='${project.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
					  value="<fmt:formatDate value='${project.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>"
                       class="erp-input">
			</p>
			<p id="project-check-date">모든 값을 입력해주세요</p>
			            <button type="submit" id="project-schedule-insert" class="erp-btn" disabled>등록</button>
            <button type="button" class="erp-btn project-close-modal">닫기</button>
		</form>
	</div>
</div>

<script>
$(function() {
    $(".project-show-sche-add-modal").click(()=>$(".project-sche-add-modal").css("display","flex"));
    $(".project-close-modal").click(()=>$(".project-sche-add-modal").hide());

   

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
        const description = row.find(".erp-description").val();
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

    function projectInsertSchedule() {
        const projectStart = new Date(Number($("#projectStart").val()));
        const projectEnd = new Date(Number($("#projectEnd").val()));

        const title = $("#project-title").val().trim();
        const desc = $("#project-desc").val().trim();
        const user = $("#project-user").val();

        const scheStart = new Date($("#project-start-dt").val());
        const scheEnd = new Date($("#project-end-dt").val());

        let valid = true;
        let msg = "";

        if(!title || !desc || !user || !scheStart || !scheEnd){
            valid = false;
            msg = "모든 값을 입력해주세요";
        } else if(scheStart < projectStart){
            valid = false;
            msg = "일정 시작일은 프로젝트 시작일보다 이전일 수 없습니다.";
        } else if(scheStart > projectEnd){
            valid = false;
            msg = "일정 시작일은 프로젝트 종료일보다 이후일 수 없습니다.";
        } else if(scheEnd > projectEnd){
            valid = false;
            msg = "일정 종료일은 프로젝트 종료일보다 이후일 수 없습니다.";
        } else if(scheEnd < scheStart){
            valid = false;
            msg = "일정 종료일은 일정 시작일보다 이전일 수 없습니다.";
        }

        $("#project-check-date").text(msg);
        $("#project-schedule-insert").prop("disabled", !valid);
    }

    $("#project-title, #project-desc, #project-user, #project-start-dt, #project-end-dt").on("input change", projectInsertSchedule);
});
</script>
