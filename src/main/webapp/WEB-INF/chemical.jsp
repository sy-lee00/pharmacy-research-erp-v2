<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Chemical</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <meta charset="UTF-8">
  </head>
  <body>
  	<h2>시약/보관소 관리</h2>
	<form action="/chemical/list" method="get">
		<select name="select">
			<option value="name">시약명</option>
			<option value="cas_no">CAS번호</option>
		</select>
		<input type="text" name="search" />
		<input type="submit" value="검색" />
	</form>
	<button id ="filter-open">필터링</button>
	<div class="filter-modal-bg" >
		<div class="filter-modal">
			<button id="filter-close">X</button>
			<h3>필터링</h3>
			<form action="/chemical/add" method="post">
				<table>
					<td><input type="checkbox" id="all" name="all" /> 전체선택</td>
					<td><input type="checkbox" id="all" name="all" /> 전체선택</td>
					<input type="submit" value="필터" />
					<input type="reset" value="취소" />
				</table>
			</form>
		</div>
	</div>
	<table border="1">
	<tr>
		<th>시약 ID</th>
		<th>시약명</th>
		<th>CAS 번호</th>
		<th>보관 단위</th>
		<th>보관소 ID</th>
		<th>현재 재고 수량</th>
		<th>경고 기준 재고 수량</th>
		<th>등록일</th>
	</tr>
	<c:forEach items="${list}" var="chem">
		<tr>
			<td>${chem.chemicalId}</td>
			<td>${chem.name}</td>
			<td>${chem.casNo}</td>
			<td>${chem.storageUnit}</td>
			<td>${chem.storageId}</td>
			<td>${chem.stockQty}</td>
			<td>${chem.thresholdQty}</td>
			<td>${chem.createdAt}</td>
		</tr>
	</c:forEach>
	</table>
	<button id ="addChemical">추가</button>
	<div class="modal-bg" >
		<div class="modal">
			<button id="close">X</button>
			<h3>시약 추가</h3>
			<form action="/chemical/add" method="post">
				<input type="text" name="file" /><br>
				<input type="submit" value="파일업로드" /><br>
			</form>
		</div>
	</div>
  
	<nav>
		<ul class="pagination">
			<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/chemical/list?page=${paging.startPage - 1}&search=${param.search}&select=${param.select}">이전</a></li>
						
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
				<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/chemical/list?page=${page}&search=${param.search}&select=${param.select}">${page}</a></li>
			</c:forEach>
						
			<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/chemical/list?page=${paging.endPage + 1}&search=${param.search}&select=${param.select}">다음</a></li>
		</ul>
	</nav>
	
	<style>
		.pagination {
			display: flex;
			justify-content: center;
			gap: 8px;
			list-style: none;
			padding: 0;
		}

		.pagination li a {
			display: block;
			padding: 8px 14px;
			border: 1px solid #ccc;
			border-radius: 4px;
			color: #333;
			text-decoration: none;
			transition: 0.2s;
		}

		.pagination li a:hover {
			background-color: #eee;
		}

		.pagination .active a {
			background-color: #3f51b5;
			color: white;
			font-weight: bold;
			border-color: #3f51b5;
		}

		.pagination .disabled a {
			pointer-events: none;
			opacity: 0.4;
		}
		.modal-bg {
			position: fixed;
			top: 0; left: 0; right: 0; bottom: 0;
			background: rgba(0, 0, 0, 0.3);
			z-index: 1000;
			display: none;
			justify-content: center;
			align-items: center;
		}
		.modal {
			background: white;
			position: relative;
			width: 350px;
			padding: 20px;
		}
		.modal #close {
			position: absolute;
			top: 10px; right: 10px;
			cursor: pointer;
			font-size: 10px;
			border: none;
			background: none;
		}
		.filter-modal-bg {
			position: fixed;
			top: 0; left: 0; right: 0; bottom: 0;
			background: rgba(0, 0, 0, 0.3);
			z-index: 1000;
			display: none;
			justify-content: center;
			align-items: center;
		}
		
		.filter-modal {
			background: white;
			position: relative;
			width: 350px;
			padding: 20px;
		}
		.filter-modal #filter-close {
			position: absolute;
			top: 10px; right: 10px;
			cursor: pointer;
			font-size: 10px;
			border: none;
			background: none;
		}
	</style>
	
	<script>
		$("#addChemical").click(() => {
			$(".modal-bg").css("display", "flex");
		});
		$("#close").click(() => {
			$(".modal-bg").css("display", "none");
		});
		$(".modal-bg").click((e) => {
			console.log(e.target);
			console.log(e.currentTarget);
			if (e.target === e.currentTarget) {
				$(".modal-bg").css("display", "none");
			}
		});
		
		$("#filter-open").click(() => {
			$(".filter-modal-bg").css("display", "flex");
		});
		$("#filter-close").click(() => {
			$(".filter-modal-bg").css("display", "none");
		});
		$(".filter-modal-bg").click((e) => {
			console.log(e.target);
			console.log(e.currentTarget);
			if (e.target === e.currentTarget) {
				$(".filter-modal-bg").css("display", "none");
			}
		});
	</script>
  </body>
</html>
