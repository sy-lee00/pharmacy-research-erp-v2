<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Approval</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="../../resource/css/boot.css">
    <link rel="stylesheet" href="../../resource/css/layout.css">
	<style>
		.addition-modal-bg {
			position: fixed;
			top: 0; left: 0; right: 0; bottom: 0;
			background: rgba(0, 0, 0, 0.3);
			z-index: 1000;
			display: none;
			justify-content: center;
			align-items: center;
		}
	
		.addition-modal {
			background: rgb(52, 73, 94);
			color: white;
			position: relative;
			width: 350px;
			padding: 20px;
			border-radius: 8px;
		}
		.addition-modal #addition-close {
			position: absolute;
			top: 10px; right: 10px;
			cursor: pointer;
			font-size: 10px;
			border: none;
			background: none;
		}
		
		#commentId {
			display: none;
		}

		#approvalFilterTable {
			width: 500px;
		}
		
		#approvalFilterTable tr td {
			font-size: 13px;
		}
		
		#approvalFilterTable #filterApprovalType td {
			padding: 5px 0 5px 8px;
		}

		#approvalFilterTable #filterApprovalContent td {
			padding: 5px 0 5px 8px;
			border-top: 1px solid rgba(0, 0, 0, 0.5);
			border-bottom: 1px solid rgba(0, 0, 0, 0.5);
		}
		
		#approvalFilterTable #filterStatus td {
			padding: 5px 0 5px 8px;
		}

		#filterStatus {
			padding: 5px 0 5px 8px;
		}
		
		.filterRadio {
			margin-right: 6px;
		}
		.projectDetailUrl {
			color: #337AB7;
		}
		.projectDetailUrl:hover {
			color: #0056b3;
		}
	</style>
    <link rel="stylesheet" href="../../resource/css/erp.css">
<style>	
	.imgbar {
	width: 80%;
	display: flex;
	flex-direction: column;
	height: 250px;
	background-image: url(../../resource/static/approval.jpg);
	gap: 0;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../side.jsp"></jsp:include>
	
	<div class="customer-log">
	<div class="imgbar">
	<div class="search-bar">
	<h1><a href="/approval">승인 요청 관리</a></h1>
	<form id="additionForm" class="form-container">
		<select name="select" class="form-select w-auto">	
			<option value="projectName">프로젝트 이름</option>
			<option value="projectCode">프로젝트 코드</option>
			<option value="chemicalName">시약명</option>
			<option value="casNo">CAS번호</option>
			<option value="pdTitle">문서명</option>
			<option value="version">버전</option>
		</select>
		<input type="text" name="search" />
			<button id="searchBtn" class="btn btn-danger">검색</button>
			<sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
				<button id="addition-open" class="btn btn-primary">처리</button>
			</sec:authorize>
		</div>
		<div class="filter-table">
		<table id="approvalFilterTable">
			<tr id="filterApprovalType">
				<td>
					<span><b>승인 타입: </b></span>
				</td>
				<td>
					<span>전체</span>
					<input type="radio" class="filterRadio" id="radioAllType" name="filterApprovalType" value="allType" 
						${param.filterApprovalType == null || param.filterApprovalType == '' || param.filterApprovalType == 'allType' ? 'checked' : ''} />
				</td>
				<td>
					<span>chemical</span>
					<input type="radio" class="filterRadio" id="radioChemical" name="filterApprovalType" value="chemical" 
						${param.filterApprovalType == 'chemical' ? 'checked' : ''} />
				</td>
				<td>
					<span>document</span>
					<input type="radio" class="filterRadio" id="radioDocument" name="filterApprovalType" value="document" 
						${param.filterApprovalType == 'document' ? 'checked' : ''} />
				</td>
			</tr>
			<tr id="filterApprovalContent">
				<td>
					<span><b>승인 내용: </b></span>
				</td>
				<td>
					<span>전체</span>
					<input type="radio" class="filterRadio" id="radioAllContent" name="filterApprovalContent" value="allContent" 
						${param.filterApprovalContent == null || param.filterApprovalContent == '' || param.filterApprovalContent == 'allContent' ? 'checked' : ''} />
				</td>
				<td>
					<span>Addition</span>
					<input type="radio" class="filterRadio" id="radioAddition" name="filterApprovalContent" value="Addition" 
						${param.filterApprovalContent == 'Addition' ? 'checked' : ''} />
				</td>
				<td>
					<span>Usage</span>
					<input type="radio" class="filterRadio" id="radioUsage" name="filterApprovalContent" value="Usage" 
						${param.filterApprovalContent == 'Usage' ? 'checked' : ''} />
				</td>
				<td>
					<span>Approval</span>
					<input type="radio" class="filterRadio" id="radioApproval" name="filterApprovalContent" value="Approval" 
						${param.filterApprovalContent == 'Approval' ? 'checked' : ''} />
				</td>
			</tr>
			<tr id="filterStatus">
				<td>
					<span><b>상태: </b></span>
				</td>
				<td>
					<span>전체</span>
					<input type="radio" class="filterRadio" id="radioAllStatus" name="filterStatus" value="allStatus" 
						${param.filterStatus == null || param.filterStatus == '' || param.filterStatus == 'allStatus' ? 'checked' : ''} />
				</td>
				<td>
					<span>대기</span>
					<input type="radio" class="filterRadio" id="radioPending" name="filterStatus" value="대기" 
						${param.filterStatus == '대기' ? 'checked' : ''} />
				</td>
				<td>
					<span>승인</span>
					<input type="radio" class="filterRadio" id="radioApproved" name="filterStatus" value="승인" 
						${param.filterStatus == '승인' ? 'checked' : ''} />
				</td>
				<td>
					<span>반려</span>
					<input type="radio" class="filterRadio" id="radioRejected" name="filterStatus" value="반려" 
						${param.filterStatus == '반려' ? 'checked' : ''} />
				</td>
			</tr>
		</table>
		</div>
		</div>
		
		<table class="erp-table app-table">
			<tr>
				<th>승인 요청 ID</th>
				<th>프로젝트 이름</th>
				<th>프로젝트 코드</th>
				<th>승인 타입</th>
				<th>승인 내용</th>
				<th>시약명(사용량) / 문서명</th>
				<th>CAS 번호 / 버전</th>
				<th>요청자</th>
				<th>상태</th>
				<sec:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
					<th>선택 <input type="checkbox" id="additionAllBtn"></th>
				</sec:authorize>
			</tr>
			<c:forEach items="${approvalList}" var="approval">
				<tr>
					<td>${approval.approvalId}</td>
					<td class="projectDetailUrl"><a href="/project/detail?projectId=${approval.projectId}" style="text-decoration: none; font-weight:bold;">${approval.projectName}</a></td>
					<td>${approval.projectCode}</td>
					<td>${approval.approvalType}</td>
					<td>${approval.approvalContent}</td>
					<c:choose>
						<c:when test="${approval.approvalType == 'chemical'}">
							<td>${approval.chemicalName}
								<c:if test="${approval.approvalContent == 'Usage'}">
									(${approval.usedQty}${approval.storageUnit})
								</c:if>
							</td>
							<td>${approval.casNo}</td>
						</c:when>
						<c:when test="${approval.approvalType == 'document'}">
							<td>${approval.pdTitle}</td>
							<td>${approval.version}</td>
						</c:when>
					</c:choose>
					<td><input type="hidden" value="${approval.requestedBy}">${approval.name}</td>
					<td>${approval.status}</td>
					<sec:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
						<c:choose>
							<c:when test="${approval.status == '승인'}">
								<td><input type="checkbox" disabled /></td>
							</c:when>
							<c:when test="${approval.status == '반려'}">
								<td><input type="checkbox" disabled /></td>
							</c:when>
							<c:otherwise>
								<td><input type="checkbox" class="additionBtn" id="approvalCheckbox" 
											value=""
											data-apprcnt="${approval.approvalContent}"
											data-apprid="${approval.approvalId}"
											data-projid="${approval.projectId}"
											data-chemid="${approval.chemicalId}"
											data-userid="${approval.userId}"
											data-usedqty="${approval.usedQty}"
											data-targetid="${approval.targetId}"
											data-reqby="${approval.requestedBy}" /></td>
							</c:otherwise>
						</c:choose>
					</sec:authorize>
				</tr>
			</c:forEach>
		</table>
		
		<sec:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
			<div class="addition-modal-bg" >
				<div class="addition-modal">
					<h3>승인 처리</h3>
					<div>
						<div>상태</div>
						<select id="status" name="status" style="margin-bottom: 15px;">
							<option value="승인">승인</option>
							<option value="반려">반려</option>
						</select>
					</div>
					<div id="commentId">
						<div>비고</div>
						<textarea name="comment" rows="4" cols="50" placeholder="참고사항 및 보충 설명을 입력하세요." style="width: 300px;"></textarea>
					</div>
					<button id="additionProcessing" class="btn btn-outline-warning">처리</button>
					<button id="addition-close" class="btn btn-outline-secondary">닫기</button>
				</div>
			</div>
		</sec:authorize>
		</form>
		
		<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
		<nav>
			<ul class="erp-pagination">
				<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/approval?select=${param.select}
																											&search=${param.search}
																											&filterApprovalType=${param.filterApprovalType}
																											&filterApprovalContent=${param.filterApprovalContent}
																											&filterStatus=${param.filterStatus}
																											&page=${paging.startPage - 1}">이전</a></li>
							
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
					<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/approval?select=${param.select}
																														&search=${param.search}
																														&filterApprovalType=${param.filterApprovalType}
																														&filterApprovalContent=${param.filterApprovalContent}
																														&filterStatus=${param.filterStatus}
																														&page=${page}">${page}</a></li>
				</c:forEach>
							
				<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/approval?select=${param.select}
																											&search=${param.search}
																											&filterApprovalType=${param.filterApprovalType}
																											&filterApprovalContent=${param.filterApprovalContent}
																											&filterStatus=${param.filterStatus}
																											&page=${paging.endPage + 1}">다음</a></li>
			</ul>
		</nav>
	</sec:authorize>
	
	<sec:authorize access="hasRole('RESEARCHER')">
		<nav>
			<ul class="erp-pagination">
				<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/approval/my?select=${param.select}
																												&search=${param.search}
																												&filterApprovalType=${param.filterApprovalType}
																												&filterApprovalContent=${param.filterApprovalContent}
																												&filterStatus=${param.filterStatus}
																												&page=${paging.startPage - 1}">이전</a></li>
							
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
					<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/approval/my?select=${param.select}
																															&search=${param.search}
																															&filterApprovalType=${param.filterApprovalType}
																															&filterApprovalContent=${param.filterApprovalContent}
																															&filterStatus=${param.filterStatus}
																															&page=${page}">${page}</a></li>
				</c:forEach>
							
				<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/approval/my?select=${param.select}
																												&search=${param.search}
																												&filterApprovalType=${param.filterApprovalType}
																												&filterApprovalContent=${param.filterApprovalContent}
																												&filterStatus=${param.filterStatus}
																												&page=${paging.endPage + 1}">다음</a></li>
			</ul>
		</nav>
	</sec:authorize>
	<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
		<input type="hidden" id="roleCheck" value="yes" />
	</sec:authorize>
	</div>
    <script>
		const additionBtn = document.querySelectorAll(".additionBtn");
		const additionAllBtn = document.querySelector("#additionAllBtn");
		
		if(additionAllBtn != null) {
			additionAllBtn.addEventListener("click", () => {
				if(additionAllBtn.checked) {
					for(const checkBox of additionBtn) {
						checkBox.checked = true;
					}
				} else {
					for(const checkBox of additionBtn) {
						checkBox.checked = false;
					}
				}
			});
		}

		$(".filterRadio").click((e) => {
			e.preventDefault();
			const additionForm = document.querySelector("#additionForm");
			const roleCheck = document.querySelector("#roleCheck");
			if(roleCheck != null) {
				additionForm.action = '/approval';
			} else {
				additionForm.action = '/approval/my';
			}
			
			additionForm.method = 'get';
			additionForm.submit();
		});
		
		$("#searchBtn").click((e) => {
			e.preventDefault();
			const additionForm = document.querySelector("#additionForm");
			const roleCheck = document.querySelector("#roleCheck");
			if(roleCheck != null) {
				additionForm.action = '/approval';
			} else {
				additionForm.action = '/approval/my';
			}
			additionForm.method = 'get';
			additionForm.submit();
		});

		$("#selectLimit").change(() => {
			const additionForm = document.querySelector("#additionForm");
			const roleCheck = document.querySelector("#roleCheck");
			if(roleCheck != null) {
				additionForm.action = '/approval';
			} else {
				additionForm.action = '/approval/my';
			}
			additionForm.method = 'get';
			additionForm.submit();
		});
		
		$("#status").change((e) => {
			const status = document.querySelector("#status").value;
			if(status === '반려') {
				$("#commentId").css("display", "block");
			} else $("#commentId").css("display", "none");
		});
		$("#addition-open").click((e) => {
			e.preventDefault();
			const checkBoxes = document.querySelectorAll('input.additionBtn:checked');
			if(checkBoxes.length === 0) {
				alert('처리할 항목을 선택해주세요.');
				return;
			}
			
			$(".addition-modal-bg").css("display", "flex");
		});
		$("#addition-close").click((e) => {
			e.preventDefault();
			$(".addition-modal-bg").css("display", "none");
		});
	
		$("#additionProcessing").click((e) => {
			e.preventDefault();
			const checkBoxes = document.querySelectorAll('input.additionBtn:checked');
			const additionForm = document.querySelector('#additionForm');
			
			const firstContent = checkBoxes[0].dataset.apprcnt;
			for(const checkbox of checkBoxes){
				if(firstContent !== checkbox.dataset.apprcnt) {
					alert('승인 내용이 동일한 항목들만 함께 처리할 수 있습니다.')
					return;
				}
			}
			
			function createHiddenInput(name, value, form) {
				const input = document.createElement('input');
				
				input.type = 'hidden';
				input.name = name;
				input.value = value;
				
				form.appendChild(input);
			};
			
			for (const checkbox of checkBoxes) {
				const approvalId = checkbox.dataset.apprid;
				const projectId = checkbox.dataset.projid;
				const chemicalId = checkbox.dataset.chemid;
				const userId = checkbox.dataset.userid;
				const usedQty = checkbox.dataset.usedqty;
				const targetId = checkbox.dataset.targetid;
				const requestedBy = checkbox.dataset.reqby;
				
				createHiddenInput('approvalIdList', approvalId, additionForm);
				createHiddenInput('projectIdList', projectId, additionForm);
				createHiddenInput('chemicalIdList', chemicalId, additionForm);
				createHiddenInput('userIdList', userId, additionForm);
				createHiddenInput('usedQtyList', usedQty, additionForm);
				createHiddenInput('targetIdList', targetId, additionForm);
				createHiddenInput('reqbyIdList', requestedBy, additionForm);
			};
			
			if(firstContent == 'Addition') {
				additionForm.action = '/approval/process/addition'
			} else if(firstContent == 'Usage'){
				additionForm.action = '/approval/process/usage'
			} else if(firstContent == 'Approval'){
				additionForm.action = '/approval/process/document'
			} else {
				alert('알 수 없는 승인 내용입니다.');
				return;
			}
			additionForm.method = 'post';
			additionForm.submit();
		});
    </script>
    
</body>
</html>