<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<div class="project-member-section">

<div class="tab-title">
	<h2>참여자 목록</h2>
</div>
	<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
		<button type="button"
			class="erp-btn erp-btn-proj project-show-member-modal member-insert-btn">참여자
			등록</button>
	</sec:authorize>

	<form action="/project/memberDelete" method="post"
		class="erp-form project-member-delete">
		<input type="hidden" name="projectId" value="${project.projectId}" />

		<table class="erp-table erp-member-table">
			<thead>
				<tr>
					<th>역할</th>
					<th>이름</th>
					<sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
					<th>선택</th>
					</sec:authorize>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${projectMember}" var="projectMember"
					varStatus="status">
					<tr>
						<td>${projectMember.memberRole}</td>
						<td>${projectMember.name}</td>
						<sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
						<td><input type="checkbox" class="project-idList" name="idList" value="${projectMember.memberId}"></td>
						</sec:authorize>	
					</tr>
				</c:forEach>
			</tbody>
		</table>
			<sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
			<button type="submit" id="project-member-delete-btn"
			class="erp-btn erp-btn-proj member-delete-btn" disabled>참여자 제거</button>
			</sec:authorize>
	</form>
</div>

<!-- 참여자 등록 모달 -->
<div
	class="erp-open-modal project-member-modal project-member-insert-modal">
	<div class="erp-modal-body">
		<form action="/project/memberInsert" method="post" class="erp-form">
			<h1>참여자 등록</h1>

			<input type="hidden" name="projectId" value="${project.projectId}" />
			<div>
				<label>역 할</label>
				<c:set var="manager" value="${false}" />
				<c:forEach var="pm" items="${projectMember}">
					<c:if test="${not empty pm.memberRole and pm.memberRole eq '담당자'}">
						<c:set var="manager" value="${true}" />
					</c:if>
				</c:forEach>

				<select name="memberRole" required class="erp-select">
					<option value="" disabled selected>선택</option>
					<c:choose>
						<c:when test="${manager}">
							<option value="연구원">연구원</option>
						</c:when>
						<c:otherwise>
							<option value="담당자">담당자</option>
						</c:otherwise>
					</c:choose>
				</select>
			</div>
			<div>
				<label>참여자</label> 
				<select name="memberUserId" required class="erp-select">
					<option value="" disabled selected>선택</option>
					<c:forEach items="${projectUser}" var="user">
						<c:set var="sign" value="false" />
						<c:forEach items="${projectMember}" var="pm">
							<c:if test="${pm.memberUserId eq user.userUserId}">
								<c:set var="sign" value="true" />
							</c:if>
						</c:forEach>
						<c:if test="${!sign}">
							<option value="${user.userUserId}">${user.name}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<div class="member-btn-group">
				<button type="submit" class="erp-btn">등록</button>
				<button type="button" class="erp-btn project-close-member-modal">닫기</button>
			</div>
		</form>
	</div>
</div>

<script>
	$(function() {
		$(".project-show-member-modal").click(function() {
			$(".project-member-insert-modal").css("display", "flex");
		});

		$(".project-close-member-modal").click(function() {
			$(".project-member-insert-modal").hide();
		});

		$(".project-idList").change(function() {
			let check = $(".project-idList:checked").length;
			$("#project-member-delete-btn").prop("disabled", check === 0);
		});

		function deleteManager() {
			var researcher = false;
			$('.project-idList').each(function() {
				if ($(this).closest("tr").find("td:first").text() === '연구원')
					researcher = true;
			});
			$('.project-idList').each(function() {
				if ($(this).closest("tr").find("td:first").text() === '담당자') {
					$(this).prop('disabled', researcher);
				}
			});
		}
		deleteManager(); 
		
		$('.project-idList').change(deleteManager); 
	});
</script>
