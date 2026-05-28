<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<div class="project-chemical-section">
	<div class="tab-title">
		<h2>사용 시약</h2>
	</div>

	<button type="button" class="erp-btn erp-btn-proj project-show-chemical-modal">시약 추가</button>
	<button type="button" onclick="requestModal()" class="erp-btn" style="width: 130px;">시약 사용 요청</button>
	<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
		<a href="/approval"><button type="button" class="erp-btn" style="width: 130px;">승인 페이지로</button></a>
	</sec:authorize>
	<sec:authorize access="hasRole('RESEARCHER')">
		<a href="/approval/my"><button type="button" class="erp-btn" style="width: 130px;">승인 페이지로</button></a>
	</sec:authorize>

	<form action="/project/pcDelete" method="post" class="erp-form project-chemical-delete">
		<input type="hidden" name="projectId" value="${param.projectId}" />

		<table class="erp-table project-chemical-table">
			<thead>
				<tr>
					<th>시약명</th>
					<th>CAS 번호</th>
					<th>총 사용량</th>
					<th>보유 단위</th>
					<%--
					<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
						<th>수정</th>
					</sec:authorize>
					--%>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${projectChemical}" var="pc">
					<tr>
						<td>${pc.chemicalName}</td>
						<td>${pc.casNo}</td>
						<td>${pc.usedQty}</td>
						<td>${pc.storageUnit}</td>
						<%--
						<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
							<td>
								<button type="button" class="erp-btn project-pc-update"
									data-id="${pc.projectChemicalId}">수정</button>
							</td>
						</sec:authorize>
						--%>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</div>

<div class="erp-open-modal project-chemical-insert-modal">
	<div class="erp-modal-body">
		<form action="/project/pcAdd" method="post" class="erp-form">
			<h2>시약 추가</h2>
			<input type="hidden" id="projectId" name="projectId"
				value="${param.projectId}" /> <input type="hidden"
				name="approvalType" value="chemical" /> <input type="hidden"
				name="approvalContent" value="Addition" />

			<div>
				<label>시약명</label> <select name="chemicalId" required
					class="erp-select" style="margin:10px 0;">
					<option value="" disabled selected>선택</option>
					<c:forEach items="${chemicalList}" var="chemical">
						<option value="${chemical.chemicalId}">${chemical.chemicalName}</option>
					</c:forEach>
				</select>
			</div>

			<div>
				<label>요청자</label> <select name="userId" required
					class="project-select" style="margin:0 0 25px 0;">
					<option value="" disabled selected>선택</option>
					<c:forEach items="${projectUserList}" var="pcUser">
						<option value="${pcUser.userUserId}">${pcUser.name}</option>
					</c:forEach>
				</select>
			</div>
			
			<button type="submit" class="erp-btn">등록</button>
			<button type="button" class="erp-btn project-close-chemical-modal">닫기</button>
		</form>
	</div>
</div>
<%-- 사용 요청 모달 --%>
<div class="request-modal">
	<div class="request-modal-body">
		<jsp:include page="../chemical/request.jsp"></jsp:include>
	</div>
</div>

<script>
$(function() {
		$(".project-show-chemical-modal").click(function() {
			$(".project-chemical-insert-modal").css("display", "flex");
		});

		$(".project-close-chemical-modal").click(function() {
			$(".project-chemical-insert-modal").hide();
		});

		$(".project-chemical-insert-modal").click(function(e) {
			if (e.target === this) {
				$(this).hide();
			}
		});

	});
	
	const requestModal = function() {
		$('.request-modal').css('display', 'flex');
	};
	$('.request-modal').on('click', function(e) {
	    if (e.target === this) {
	        $(this).hide();
	    }
	});
	$("#closeRequestBtn").click((e) => {
		$('.request-modal').css('display', 'none');
	});
	
</script>
