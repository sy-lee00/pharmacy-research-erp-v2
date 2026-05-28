<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8" />
   <title>Chemical</title>
   <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
   <link rel="stylesheet" href="../../resource/css/reset.css">
   <link rel="stylesheet" href="../../resource/css/boot.css">
   <link rel="stylesheet" href="../../resource/css/chemical.css">
   <link rel="stylesheet" href="../../resource/css/layout.css">
   <link rel="stylesheet" href="../../resource/css/erp.css">
<meta charset="UTF-8">
<style>
	.imgbar {
	width: 80%;
	background-image: url(../../resource/static/lab1.jpg);
	gap: 0;
    }
      
    .searchBtn, .stockBtn, .usageBtn, #deleteChem {
	font-size: 14px;
	font-family: sans-serif;
	}
	
	.erp-table-chem th:nth child(9), .erp-table-chem th:nth child(10) {
	max-width: 60px;
	}
	.stockOfChemical-modal {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: rgba(0, 0, 0, 0.5);
		z-index: 1000;
		display: none;
		justify-content: center;
		align-items: center;
	}
/*
	.stockOfChemical-modal {
		background: #ffffff;
		color: #333;
		width: 450px;
		border-radius: 8px;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
		display: flex;
		flex-direction: column;
	}*/

	/* 모달 내용 부분 */
	.stockOfChemical-modal-header {
	  background-color: white;
	  padding: 2rem;
	  border-radius: 8px;
	  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	}
	.stockOfChemical-modal-body {
	    background-color: white;
	    padding: 2rem;
	    border-radius: 8px;
	    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	}
	.stockOfChemical-modal-footer {
	  background-color: white;
	  padding: 2rem;
	  border-radius: 8px;
	  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	}
  .storageUrl {
  	color: rgb(0, 0, 128);
  	text-decoration: none;
  }
  .storageUrl:hover {
  	color: rgb(100, 149, 237);
  	text-decoration: underline;
  }
</style>
</head>
	<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../side.jsp"></jsp:include>
	
	<div class="customer-log">
		<div class="imgbar">
  			<h1><a href="/chemical/list">시약/보관소 관리</a></h1>
			<form action="/chemical/list" method="get" class="form-container">
				<select name="select" class="form-select w-auto">
					<option value="name">시약명</option>
					<option value="cas_no">CAS번호</option>
				</select>
				<input type="text" name="search" />
				<div class="button-group">
				<button type="submit" class="btn btn-danger searchBtn">검색</button>
				<c:if test="${param.storageId} != null">
					<input type="hidden" name="storageId" value="${param.storageId}"/>
				</c:if>
				<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
					<div class="footer-button">
						<button id ="add-open" class="btn btn-primary">추가</button>
						
					</div>
				</sec:authorize>
				</div>
			</form>
			<div class="chemical-link" style="margin:0;">
			<button type="button" class="btn btn-outline-warning stockBtn" style="width:85px;" onclick="stockOfChemicalModal()">재고 현황</button>
			<button type="button" id="openRequestModal" class="btn btn-outline-warning usageBtn" style="width:85px;">시약 사용</button>
			</div>
		</div>
	<form id="tableForm">
		<table class="erp-table erp-table-chem">
		<tr>
			<th>번호</th>
			<th>시약명</th>
			<th>CAS 번호</th>
			<th>보관소</th>
			<th>단위</th>
			<th>경고기준 수량</th>
			<th colspan="2">현재 재고 수량</th>
			<th>등록일</th>
			<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
				<th>수정</th>
				<th><button id ="deleteChem" class="btn btn-outline-danger">삭제</button></th>
			</sec:authorize>
		</tr>
		<c:set var="num" value="${(paging.page - 1) * 10 + 1}" />
		<c:forEach items="${list}" var="chemical" varStatus="status">
			<tr>
				<td>${num}</td>
				<td>${chemical.chemicalName}</td>
				<td>${chemical.casNo}</td>
				<td>${chemical.storageName}</td>
				<td>${chemical.storageUnit}</td>
				<td class="thresholdQtyValue">${chemical.thresholdQty}</td>
				<td class="stockQtyValue">${chemical.stockQty}</td>
				<td class="stockStatus"></td>
				<td>${chemical.createdAt}</td>
				<sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
					<td><button class="btn btn-outline-danger modifyChem" 
						 data-id="${chemical.chemicalId}" 
						 data-name="${chemical.chemicalName}" 
						 data-stock="${chemical.stockQty}"
						 data-casno="${chemical.casNo}"><i class="bi bi-pencil"></i></button></td>
					<td><input type="checkbox" class="chemCheckBox" name="chemList" value="${chemical.chemicalId}" /></td>
					
				</sec:authorize>
				<c:set var="num" value="${num + 1}" />
			</tr>
		</c:forEach>
		</table>
	</form>
	
	<div class="add-modal-bg">
	    <div class="add-modal">
	        <div class="modal-header">
	            <h3>시약 추가</h3>
	            <button id="add-close">&times;</button>
	        </div>
	        <form action="/chemical/manage" method="post">
	            <input type="hidden" name="type" value="add" />
	            <div class="modal-body">
	                <table class="modal-table">
	                    <tr>
	                        <th>시약명</th>
	                        <td><input type="text" name="chemicalName" class="form-control" required /></td>
	                    </tr>
	                    <tr>
	                        <th>CAS 번호</th>
	                        <td><input type="text" name="CasNo" class="form-control" required /></td>
	                    </tr>
	                    <tr>
	                        <th>보관 단위</th>
	                        <td><input type="text" name="storageUnit" class="form-control" required /></td>
	                    </tr>
	                    <tr>
	                        <th>보관 위치</th>
	                        <td>
	                            <select name="storageName" class="form-control">
	                                <c:forEach items="${StorageNameList}" var="storage">
	                                    <option value="${storage}">${storage}</option>
	                                </c:forEach>
	                            </select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>재고 수량</th>
	                        <td><input type="text" name="stockQty" class="form-control" required /></td>
	                    </tr>
	                    <tr>
	                        <th>경고 기준 수량</th>
	                        <td><input type="text" name="thresholdQty" class="form-control" required /></td>
	                    </tr>
	                </table>
	            </div>
	            <div class="modal-footer">
	                <button type="submit" class="btn btn-primary">추가</button>
					<button type="reset" class="btn btn-secondary">초기화</button>
	            </div>
	        </form>
	    </div>
	</div>
	
	<div class="modify-modal-bg">
	    <div class="modify-modal">
	        <div class="modal-header">
	            <h3>시약 수량 변경</h3>
	            <button id="modify-close">&times;</button>
	        </div>
	        <form action="/chemical/manage" method="post">
	            <input type="hidden" id="chemicalId" name="chemicalId" />
	            <input type="hidden" name="type" value="modify" />
	            <div class="modal-body">
	                <table id="modifyChemicalTable" class="modal-table">
	                    <tr>
	                        <th>시약명</th>
	                        <td id="chemicalName"></td> 
						</tr>
	                    <tr>
	                        <th>현재 보유 수량</th>
	                        <td id="stockQty"></td> 
						</tr>
	                    <tr>
	                        <th>변경할 수량</th>
	                        <td><input type="number" id="modifyStock" name="stockQty" class="form-control" /></td>
	                    </tr>
	                </table>
	            </div>
	            <div class="modal-footer">
	                <button type="submit" class="btn btn-primary">변경</button>
	            </div>
	        </form>
	    </div>
	</div>
	
	<div class="request-modal">
		<div class="request-modal-body">
			<jsp:include page="request.jsp"></jsp:include>
		</div>
	</div>
	
	<div class="stockOfChemical-modal">
		<div class="stockOfChemical-modal-body">
		<h3>시약 재고 현황</h3>
			<table class="erp-table stockOfChemical-modal-table"></table>
			<button type="button" class="erp-btn stockOfChemical-modal-close">닫기</button>
		</div>
	</div>
	
	<c:choose>
		<c:when test="${not empty param.storageId}">
			<nav>
				<ul class="erp-pagination">
					<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/chemical/list?page=${paging.startPage - 1}&search=${param.search}&select=${param.select}&storageId=${param.storageId}">이전</a></li>
								
					<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
						<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/chemical/list?page=${page}&search=${param.search}&select=${param.select}&storageId=${param.storageId}">${page}</a></li>
					</c:forEach>
								
					<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/chemical/list?page=${paging.endPage + 1}&search=${param.search}&select=${param.select}&storageId=${param.storageId}">다음</a></li>
				</ul>
			</nav>
		</c:when>
		<c:otherwise>
			<nav>
				<ul class="erp-pagination">
					<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/chemical/list?page=${paging.startPage - 1}&search=${param.search}&select=${param.select}">이전</a></li>
								
					<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
						<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/chemical/list?page=${page}&search=${param.search}&select=${param.select}">${page}</a></li>
					</c:forEach>
								
					<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/chemical/list?page=${paging.endPage + 1}&search=${param.search}&select=${param.select}">다음</a></li>
				</ul>
			</nav>
		</c:otherwise>
	</c:choose>
	</div>
	<script>
		$(window).on('load', () => {
			const stockQtyValue = document.querySelectorAll(".stockQtyValue");
			const thresholdQtyValue = document.querySelectorAll(".thresholdQtyValue");
			const stockStatus = document.querySelectorAll(".stockStatus");
			
			for(let i=0; i<stockQtyValue.length; i++) {
				for(let j=0; j<thresholdQtyValue.length; j++) {
					if(i==j && parseInt(stockQtyValue[i].textContent) < parseInt(thresholdQtyValue[j].textContent) * 1.2
							&& parseInt(stockQtyValue[i].textContent) >= parseInt(thresholdQtyValue[j].textContent)) {
						$(stockStatus[j]).css({
						  "color": "#DD6B20",
						  "text-shadow": "0 0 1px #DD6B20"
						});
						stockStatus[j].textContent = '임박';
					} else if(i==j && parseInt(stockQtyValue[i].textContent) > parseInt(thresholdQtyValue[j].textContent)) {
						$(stockStatus[j]).css({
						  "color": "#2F855A",
						  "text-shadow": "0 0 1px #2F855A"
						});
						stockStatus[j].textContent = '정상';
					} else if(i==j && parseInt(stockQtyValue[i].textContent) < parseInt(thresholdQtyValue[j].textContent)) {
						$(stockStatus[j]).css({
						  "color": "#E53E3E",
						  "font-weight": "bold",
						  "background-color": "#E53E3E30"
						});
						stockStatus[j].textContent = '부족';
					}
				}
			}
			
			$.ajax({
				type: 'get',
				url: '/chemical/stock',
				success: function(response) {
					const stockOfChemicalTable = document.querySelector(".stockOfChemical-modal-table");
					const trTitle = document.createElement('tr');
					const thStorageId = document.createElement('th');
					thStorageId.textContent = '보관소 ID';
					
					const thStorageName = document.createElement('th');
					thStorageName.textContent = '보관소 이름';

					const thLocation = document.createElement('th');
					thLocation.textContent = '보관 위치';

					const thType = document.createElement('th');
					thType.textContent = '보관 방식';

					const thDescription = document.createElement('th');
					thDescription.textContent = '기타 설명';

					const thStock = document.createElement('th');
					thStock.textContent = '재고';
					
					trTitle.appendChild(thStorageId);
					trTitle.appendChild(thStorageName);
					trTitle.appendChild(thLocation);
					trTitle.appendChild(thType);
					trTitle.appendChild(thDescription);
					trTitle.appendChild(thStock);
					stockOfChemicalTable.appendChild(trTitle);
					
					response.forEach(function(storage) {
						const tr = document.createElement('tr');
						const tdStorageId = document.createElement('td');
						tdStorageId.textContent = storage.storageId;
						
						const tdStorageName = document.createElement('td');
						tdStorageName.textContent = storage.storageName;

						const tdLocation = document.createElement('td');
						tdLocation.textContent = storage.location;

						const tdType = document.createElement('td');
						tdType.textContent = storage.type;

						const tdDescription = document.createElement('td');
						tdDescription.textContent = storage.description;

						const tdStock = document.createElement('td');

						const aCheck = document.createElement('a');
						aCheck.classList.add('storageUrl');
						aCheck.textContent = storage.stock;
						aCheck.href = '/chemical/list?storageId=' + storage.storageId;
						
						tdStock.appendChild(aCheck);
						tr.appendChild(tdStorageId);
						tr.appendChild(tdStorageName);
						tr.appendChild(tdLocation);
						tr.appendChild(tdType);
						tr.appendChild(tdDescription);
						tr.appendChild(tdStock);

						stockOfChemicalTable.appendChild(tr);
					});
					
				}
			});

		});
		
		const chemCheckBox = document.querySelectorAll(".chemCheckBox");
		const chemDeleteAll = document.querySelector("#deleteAll");
		if(chemDeleteAll != null) {
			chemDeleteAll.addEventListener("click", () => {
			if(chemDeleteAll.checked) {
				for(const checkBox of chemCheckBox) {
					checkBox.checked = true;
				}
			} else {
				for(const checkBox of chemCheckBox) {
					checkBox.checked = false;
				}
			}
		});
		}
		
		$("#add-open").click((e) => {
			e.preventDefault();
			$(".add-modal-bg").css("display", "flex");
		});
		$("#add-close").click(() => {
			$(".add-modal-bg").css("display", "none");
		});
		$(".add-modal-bg").click((e) => {
			if (e.target === e.currentTarget) {
				$(".add-modal-bg").css("display", "none");
			}
		});

		$(".modifyChem").click((e) => {
			e.preventDefault();
			const id = $(e.currentTarget).data("id");
			const name = $(e.currentTarget).data("name");
			const stock = $(e.currentTarget).data("stock");
			const casNo = $(e.currentTarget).data("casno");
			$("#chemicalId").val(id);
			$("#stockQty").text(stock);
			$("#chemicalName").text(name);
			$("#casNo").text(casNo);
			$(".modify-modal-bg").css("display", "flex");
		});
		$("#modify-close").click(() => {
			$(".modify-modal-bg").css("display", "none");
		});
		$(".modify-modal-bg").click((e) => {
			if (e.target === e.currentTarget) {
				$(".modify-modal-bg").css("display", "none");
			}
		});

		$("#deleteChem").click((e) => {
			e.preventDefault();
			const checkedBoxes = document.querySelectorAll(".chemCheckBox:checked");

			if (checkedBoxes.length === 0) {
			    alert("삭제할 항목을 선택해주세요.");
			    return;
			}
			if (confirm("선택한 항목을 삭제하시겠습니까?")) {
				$.ajax({
					type: "post",
					url: "/chemical/delete",
					data: $("#tableForm").serialize(),
					success: function(response) {
						location.href = '/chemical/list';
					}
				});
			};
		});
		$("#closeRequestBtn").click((e) => {
			$('.request-modal').css('display', 'none');
		});
		// '시약 사용' 버튼 클릭 시
		$('#openRequestModal').on('click', function() {
		    $('.request-modal').css('display', 'flex');
		});

		// 모달 배경 클릭 시 닫기
		$('.request-modal').on('click', function(e) {
		    // 클릭된 대상이 배경 자신일 경우에만
		    if (e.target === this) {
		        $(this).hide();
		    }
		});

		const stockOfChemicalModal = function() {
			// '시약 사용' 버튼 클릭 시
			$('.stockOfChemical-modal').css('display', 'flex');
			
		};
		// 모달 배경 클릭 시 닫기
		$('.stockOfChemical-modal').on('click', function(e) {
		    // 클릭된 대상이 배경 자신일 경우에만
		    if (e.target === this) {
		        $(this).hide();
		    }
		});
		$(".stockOfChemical-modal-close").click((e) => {
			$('.stockOfChemical-modal').css('display', 'none');
		});
	</script>
  </body>
</html>
