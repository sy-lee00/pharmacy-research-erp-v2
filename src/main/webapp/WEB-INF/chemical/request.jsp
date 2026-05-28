<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8" />
	    <title>Request</title>
		<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
		
<style>
/* ======= 페이지 고유 스타일 ======== */
.chemical-selector-container {
    position: relative;
}

.chemical-selector {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.chemical-name-display {
    flex-grow: 1;
    padding: 0.6rem 0.75rem;
    background-color: #e9ecef;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    min-height: 38px;
    box-sizing: border-box;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    border: 1px solid #dee2e6;
    border-radius: 0.25rem;
    overflow: hidden;
}

.info-item {
    padding: 1rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background-color: #f8f9fa;
}

.info-item:not(:last-child) {
    border-right: 1px solid #dee2e6;
}

.info-label {
    font-size: 0.9rem;
    color: #6c757d;
    margin-bottom: 0.25rem;
}

.info-value {
    font-size: 1.25rem;
    font-weight: 600;
    color: #c82333;
}

/* =========== 드롭다운/모달 =========== */
.dropdown-panel,
.searchChemical-modal-bg {
    display: none;
}

.dropdown-panel {
    position: absolute;
    top: 100%;
    left: 0;
    z-index: 100;
    margin-top: 5px;
    width: 100%;
    background-color: #fff;
    border: 1px solid #dee2e6;
    border-radius: 0.25rem;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

#chemTableWindow {
    max-height: 300px;
    overflow-y: auto;
}

#chemListTable {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.95rem;
}

#chemListTable th,
#chemListTable td {
    padding: 0.75rem 0.5rem;
    border-bottom: 1px solid #e9ecef;
    text-align: left;
    vertical-align: middle;
}

#chemListTable th {
    background-color: #f8f9fa;
    font-weight: 600;
}

#chemListTable tr:hover {
    background-color: #f1f3f5;
}

#chemListTable td:last-child {
    text-align: center;
}

.requestUsage-form-control {
	width: 100%;
	padding: 0.5rem 0.75rem;
	font-size: 1rem;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	box-sizing: border-box;
}
.request-form {
	display: flex;
	flex-direction: column;
	width: 380px;
	gap: 1.5rem;
}
.requestUsage-form-label {
	font-size: 1rem;
	font-weight: 600;
	margin-bottom: 0.5rem;
	color: #495057;
} 
</style>
</head>
	<body>
		<div class="content-container">
		    <h2>시약 사용 승인 요청</h2>
	
		    <form id="requestForm" class="request-form" method="post" action="/chemical/approval">
		        
		        <input type="hidden" name="approvalType" value="chemical" />
		        <input type="hidden" name="approvalContent" value="Usage" />
				<input type="hidden" id="projectIdHolder" ${param.projectId == '' || param.projectId == null ? '' : 'name="projectId"'} value="${param.projectId}" />
	
		        <div id="chooseProject" class="requestUsage-form-group">
		            <label for="selectProject" class="requestUsage-form-label">프로젝트 선택</label>
		            <select id="selectProject" name="projectId" class="requestUsage-form-control">
		                <option value="" disabled selected>프로젝트를 선택하세요</option>
		                <c:forEach items="${projectsOfUser}" var="project">
		                    <option value="${project.projectId}">${project.projectName}</option>
		                </c:forEach>
		            </select>
		        </div>
	
				<div class="requestUsage-form-group">
				    <label class="requestUsage-form-label">사용 시약</label>
				    
				    <div class="chemical-selector-container">
				        <div class="chemical-selector">
				            <span id="selectedChemical" class="chemical-name-display">선택된 시약 없음</span>
				            <button type="button" id="searchChemical-open" class="btn btn-secondary">선택</button>
				        </div>

				        <div id="chemicalDropdown" class="dropdown-panel">
				            <div id="chemTableWindow"></div>
				            <div class="modal-footer"> <button type="button" id="selectChemical" class="btn btn-primary">확인</button>
				            </div>
				        </div>
				    </div>
				</div>
		        
		        <div class="info-grid">
		            <div class="info-item">
		                <span class="info-label">현재 재고</span>
		                <span id="stockOfChemical" class="info-value">-</span>
		            </div>
		            <div class="info-item">
		                <span class="info-label">경고 기준</span>
		                <span id="thresholdQtyOfChemical" class="info-value">-</span>
		            </div>
		             <div class="info-item">
		                <span class="info-label">단위</span>
		                <span class="storageUnitOfChemical info-value">-</span>
		            </div>
		        </div>
	
		        <div class="requestUsage-form-group">
		            <label for="usedQtyInput" class="form-label">사용할 용량</label>
		            <input type="number" id="usedQtyInput" name="usedQty" class="requestUsage-form-control" placeholder="사용할 용량을 숫자로 입력하세요" required />
		        </div>
				
		        <div class="form-actions">
					<button type="submit" id="requestBtn" class="btn btn-primary">요청</button>
					<button type="button" id="resetRequestBtn" class="btn btn-secondary" style="width:75px;">초기화</button>
					<button type="button" id="closeRequestBtn" class="btn btn-secondary">닫기</button>
		        </div>
		    </form>
		</div>
	
		<div class="searchChemical-modal-bg">
		    <div class="searchChemical-modal"> 
				<div class="modal-header">
		            <h3>시약 선택</h3>
		            <button id="searchChemical-close">&times;</button>
		        </div>
		        <div class="modal-body">
		            <div id="chemTableWindow"></div>
		        </div>
		        <div class="modal-footer">
		            <button type="button" id="selectChemical" class="btn btn-primary">선택</button>
		        </div>
		    </div>
		</div>
	
	<script>
		const chemicalDropdown = $('#chemicalDropdown');
		const projectIdHolder = document.querySelector("#projectIdHolder");
		const chooseProject = document.querySelector("#chooseProject");

	    $('#searchChemical-open').on('click', function(e) {
	        e.preventDefault();
	        
	        if (!$('#selectProject').val() && projectIdHolder.value == '') {
	            alert("프로젝트를 먼저 선택해주세요.");
	            return;
	        }
	        chemicalDropdown.toggle();
	    });

	    $(document).on('click', function(e) {
	        const container = $('.chemical-selector-container');
	        if (!container.is(e.target) && container.has(e.target).length === 0) {
	            chemicalDropdown.hide();
	        }
	    });
		
		if(projectIdHolder.value == '') {
			$("#selectProject").change(() => {
				$.ajax({
					type: 'get',
					url: '/getChemicals',
					data: {
						projectId: $("#selectProject").val()
					},
					success: function(response) {
						const chemTableWindow = document.querySelector("#chemTableWindow");
					    chemTableWindow.innerHTML = ''; // 미리 비우기
	
					    const table = document.createElement('table');
					    table.id = 'chemListTable';
	
					    // --- 이 부분 추가: 테이블 헤더 생성 ---
					    const thead = document.createElement('thead');
					    const headerRow = document.createElement('tr');
					    headerRow.innerHTML = `
					        <th>시약명</th>
					        <th>CAS 번호</th>
					        <th>선택</th>
					    `;
					    thead.appendChild(headerRow);
					    table.appendChild(thead);
					    // --- 헤더 생성 끝 ---
	
					    const tbody = document.createElement('tbody');
					    response.forEach(chemical => {
					        const tr = document.createElement('tr');
					        
					        const nameTd = document.createElement('td');
					        nameTd.textContent = chemical.chemicalName;
					        
					        const casNoTd = document.createElement('td');
					        casNoTd.textContent = chemical.casNo;
	
					        const radioTd = document.createElement('td');
					        const radioInput = document.createElement('input');
					        radioInput.type = 'radio';
					        radioInput.name = 'chemicalId';
					        radioInput.value = chemical.chemicalId;
					        radioInput.dataset.projectChemicalId = chemical.projectChemicalId; // 데이터 저장
					        radioInput.dataset.chemicalName = chemical.chemicalName; // 데이터 저장
					        
					        radioTd.appendChild(radioInput);
					        tr.appendChild(nameTd);
					        tr.appendChild(casNoTd);
					        tr.appendChild(radioTd);
					        tbody.appendChild(tr);
					    });
					    table.appendChild(tbody);
					    
					    chemTableWindow.appendChild(table);
					}
				});
			});
		} else {
			$(document).ready(() => {
				chooseProject.innerHTML = "";
				$.ajax({
					type: 'get',
					url: '/getChemicals',
					data: {
						projectId: parseInt(projectIdHolder.value)
					},
					success: function(response) {
						const chemTableWindow = document.querySelector("#chemTableWindow");
					    chemTableWindow.innerHTML = ''; // 미리 비우기

					    const table = document.createElement('table');
					    table.id = 'chemListTable';

					    // --- 이 부분 추가: 테이블 헤더 생성 ---
					    const thead = document.createElement('thead');
					    const headerRow = document.createElement('tr');
					    headerRow.innerHTML = `
					        <th>시약명</th>
					        <th>CAS 번호</th>
					        <th>선택</th>
					    `;
					    thead.appendChild(headerRow);
					    table.appendChild(thead);
					    // --- 헤더 생성 끝 ---

					    const tbody = document.createElement('tbody');
					    response.forEach(chemical => {
					        const tr = document.createElement('tr');
					        
					        const nameTd = document.createElement('td');
					        nameTd.textContent = chemical.chemicalName;
					        
					        const casNoTd = document.createElement('td');
					        casNoTd.textContent = chemical.casNo;

					        const radioTd = document.createElement('td');
					        const radioInput = document.createElement('input');
					        radioInput.type = 'radio';
					        radioInput.name = 'chemicalId';
					        radioInput.value = chemical.chemicalId;
					        radioInput.dataset.projectChemicalId = chemical.projectChemicalId; // 데이터 저장
					        radioInput.dataset.chemicalName = chemical.chemicalName; // 데이터 저장
					        
					        radioTd.appendChild(radioInput);
					        tr.appendChild(nameTd);
					        tr.appendChild(casNoTd);
					        tr.appendChild(radioTd);
					        tbody.appendChild(tr);
					    });
					    table.appendChild(tbody);
					    
					    chemTableWindow.appendChild(table);
					}
				});
			});
		}
		
		$("#selectChemical").click((e) => {
			e.preventDefault();
			if($('input[name="chemicalId"]:checked').val() == null) {
				chemicalDropdown.hide();
				return;
			}
			$.ajax({
				type: 'get',
				url: '/getStockOfChemical',
				data: {
					chemicalId: $('input[name="chemicalId"]:checked').val()
				},
				success: function(response) {
					const requestForm = document.querySelector("#requestForm");
					const chemical = document.querySelector("#selectedChemical");
					const stock = document.querySelector("#stockOfChemical");
					const thresholdQty = document.querySelector("#thresholdQtyOfChemical");
					const storageUnit = document.querySelector(".storageUnitOfChemical");
					
					let pcIdInput = document.querySelector("#projectChemicalId"); // radio 생성
					
					if(pcIdInput == null) {
						pcIdInput = document.createElement('input');
						
						pcIdInput.type = 'hidden';
						pcIdInput.id = 'projectChemicalId';
						pcIdInput.name = 'projectChemicalId';
						pcIdInput.value = response.projectChemicalId;
						
						requestForm.appendChild(pcIdInput);
					} else {
						pcIdInput.value = response.projectChemicalId;
					}
					
					chemical.textContent = response.chemicalName;
					stock.textContent = response.stockQty;
					thresholdQty.textContent = response.thresholdQty;
					storageUnit.textContent = response.storageUnit;
				}
			});
			chemicalDropdown.hide();
		});
		
		$("#usedQtyInput").on('input', function() {
			const stock = document.querySelector("#stockOfChemical");
			const thresholdQty = document.querySelector("#thresholdQtyOfChemical");
			const usedQtyInput = document.querySelector("#usedQtyInput");
			
			if(usedQtyInput.value > (stock.textContent - thresholdQty.textContent)) {
				alert('경고 기준 수량을 넘었습니다. 계속 진행하시겠습니까?');
			};
		});

		$("#requestBtn").click((e) => {		
			e.preventDefault();

			const stock = document.querySelector("#stockOfChemical");
			const usedQtyInput = document.querySelector("#usedQtyInput");
			if(usedQtyInput.value <= 0) {
				alert('사용할 용량을 다시 확인 해주세요.');
				return;
			}
			if(parseInt(usedQtyInput.value) > parseInt(stock.textContent)) {
				alert('작성된 시약 사용량이 현재 재고량보다 많습니다.');
				return;
			}
			$.ajax({
				type: 'post',
				url: '/chemical/approval',
				data: $("#requestForm").serialize(),
				success: function(response) {
					alert('요청 완료되었습니다.');
					location.reload();
				}
			});
		});
		
		$("#resetRequestBtn").click((e) => {
			if(projectIdHolder.value == '') {
		    	document.querySelector('#selectProject').selectedIndex = 0;
			}

		    document.querySelector('#selectedChemical').textContent = '선택된 시약 없음';
		    document.querySelector('#stockOfChemical').textContent = '-';
		    document.querySelector('#thresholdQtyOfChemical').textContent = '-';
		    
		    document.querySelectorAll('.storageUnitOfChemical').forEach(element => {
		        element.textContent = '-';
		    });

		    document.querySelector('#usedQtyInput').value = '';

		    const hiddenInput = document.querySelector('#projectChemicalId');
		    if (hiddenInput) {
		        hiddenInput.remove();
		    }
		    
		    document.querySelector('#chemicalDropdown').style.display = 'none';
		});
		
	</script>
  </body>
</html>
