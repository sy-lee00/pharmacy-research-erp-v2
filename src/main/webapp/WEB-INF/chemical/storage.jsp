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
    <link rel="stylesheet" href="../../resource/css/layout.css">
    <link rel="stylesheet" href="../../resource/css/user.css">
	<meta charset="UTF-8">
	<style>
		body {
		    height: 100vh;
		    display: flex;
			flex-direction: column;
		    align-items: center;
		    justify-content: flex-start; /* 상단 정렬로 변경 */
		    padding-top: 50px;
		    margin: 0;
		    font-family: Arial, sans-serif;
		    color: black; /* 흰색 계열 폰트 색상 */
		}
		.header {
			display: flex;
			flex-direction: row;
		}
		table {
			color: white;
			background-image: url(../../resource/static/storage.jpg);
		    background-size: cover;
		    background-position: center;
		    background-blend-mode: color;
		    background-color: rgba(0, 0, 0, 0.5);
		}
	</style>
	</head>
	<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../side.jsp"></jsp:include>
	
  	<h1 style="color: #ddd;">시약 재고 현황</h1>
	<form id="tableForm">
		<table border="1">
		<tr>
			<th>보관소 ID</th>
			<th>보관소 이름</th>
			<th>(연구소)위치</th>
			<th>보관 방식</th>
			<th>기타 설명</th>
			<th>재고</th>
			<th>확인</th>
		</tr>
		<c:forEach items="${list}" var="storage">
			<tr>
				<td>${storage.storageId}</td>
				<td>${storage.storageName}</td>
				<td>${storage.location}</td>
				<td>${storage.type}</td>
				<td>${storage.description}</td>
				<td>${storage.stock}</td>
				<td><button class="chemicalStock"
							data-id="${storage.storageId}"
							data-stock="${storage.stock}">확인</button></td>
			</tr>
		</c:forEach>
		</table>
		
		<input type="hidden" id="storageId" name="storageId" />
	</form>
	<script>
		$(".chemicalStock").click((e) => {
			e.preventDefault();
			const id = $(e.currentTarget).data("id");
			const stock = $(e.currentTarget).data("stock");
			if(stock == 0) {
				alert('재고가 존재하지 않아 열람이 불가합니다');
				location.href = '/chemical/stock';
			} else if (stock != 0) {
				$.ajax({
					type: 'get',
					url: '/chemical/list',
					data: { storageId: id },
					success: function(response) {
						location.href = '/chemical/list?storageId=' + id;
					}
				});
			} 
		});
	</script>
  </body>
</html>
