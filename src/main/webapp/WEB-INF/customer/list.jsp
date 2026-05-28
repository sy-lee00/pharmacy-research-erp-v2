<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="../../resource/css/boot.css">
<link rel="stylesheet" href="../../resource/css/layout.css">
<link rel="stylesheet" href="../../resource/css/erp.css">
<meta charset="UTF-8">
<title>Customer</title>
<style>
.imgbar {
	width: 80%;
	background-image: url(../../resource/static/people.jpg);
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../side.jsp"></jsp:include>
	
	<div class="customer-log">
		<div class=imgbar>
			<h1>
				<a href="/customer">고객 리스트 조회</a>
			</h1>
			<form action="/customer" method="get" class="form-container">
				<select name="select" id="select" class="form-select w-auto">
					<option value="고객명">고객명</option>
					<option value="담당자명">담당자명</option>
					<option value="상담일자">상담일자</option>
				</select> <span class="search-flex-container">
				<input id="searchName" type="text" class="form-control" name="search"
					value="${param.search}" placeholder="검색어를 입력하세요."> <i class="bi bi-eraser-fill clear-icon"></i>
				</span>
				<div class="button-group">
					<button id="searchCs" class="btn btn-danger">검색</button>
					<button type="button" id="modal-open" class="btn btn-primary">등록</button>
					<sec:authorize access="hasAnyRole('RESEARCHER','MANAGER')">
					<a href="/" class="btn"	style="background-color: #000; border-color: #000; color: #FFF;"><i
						class="bi bi-house-door-fill"></i></a>
					</sec:authorize>
					<sec:authorize access="hasRole('ADMIN')">
					<a href="/statistics" class="btn"	style="background-color: #000; border-color: #000; color: #FFF;"><i
						class="bi bi-house-door-fill"></i></a>
					</sec:authorize>
					
				</div>
			</form>
		</div>
		<table class="erp-table list-table">
			<tr>
				<th>번호</th>
				<th>고객명(소속)</th>
				<th>연락처</th>
				<th>이메일</th>
				<th>등록일</th>
				<th>최근상담일</th>
				<th>담당자명</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<c:forEach items="${list}" var="cs">
				<tr>
					<td>${cs.customerId}</td>
					<td>
						<div class="customer-info">
							<a href="/customer/board?select=uploadedBy&keyword=${cs.name}"><b>${cs.name}</b></a>
							/ <input type="text" class="cs-department"
								value="${cs.department}">
						</div>
					</td>
					<td><input type="text" class="cs-phone" value="${cs.phone}"></td>
					<td>
						<div class="customer-info">
							<input type="text" class="cs-email" value="${cs.email}"><a
								href="mailto:${cs.email}" class="email-link"><i
								class="bi bi-envelope-fill"></i></a>
						</div>
					</td>

					<td><fmt:formatDate value="${cs.createdAt}"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${cs.logDate}" pattern="yyyy-MM-dd" /></td>
					<td><select class="form-select cs-assignId">
							<option value="" selected disabled>-- 선택해주세요 --</option>
							<c:forEach items="${userList}" var="user">
								<option value="${user.userId}"
									${cs.assignId == user.userId ? 'selected' : ''}>${user.name}</option>
							</c:forEach>
					</select></td>
					<td><button class="btn btn-danger updateCs"
							data-customerid="${cs.customerId}">
							<i class="bi bi-pencil"></i>
						</button></td>
					<td><button class="btn btn-outline-danger delCustomer"
							data-customerid="${cs.customerId}">
							<i class="bi bi-trash"></i>
						</button></td>
				</tr>
			</c:forEach>
		</table>


		<nav>
			<ul class="erp-pagination">
				<li class="page-item ${paging.prev ? '' : 'disabled'}"><a
					class="page-link" href="/customer?page=${paging.startPage - 1}">이전</a></li>

				<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
					var="page">
					<li class="page-item ${paging.page == page ? 'active' : ''}"><a
						class="page-link" href="/customer?page=${page}">${page}</a></li>
				</c:forEach>

				<li class="page-item ${paging.next ? '' : 'disabled'}"><a
					class="page-link" href="/customer?page=${paging.endPage + 1}">다음</a></li>
			</ul>
		</nav>

	</div>
	<div class="open-modal delete-modal" id="deleteModal">
		<div class="modal-body">
			<h4>해당 고객 정보를 삭제하시겠습니까?</h4>
			<button type="submit" id="delBtn" data-customerid="${cs.customerId}"
				class="btn btn-warning">삭제</button>
			<button class="close-modal btn btn-secondary">닫기</button>
		</div>
	</div>

	<div class="modal-back">
		<div class="write-modal">
			<button id="modal-close">
				<i class="bi bi-x"></i>
			</button>
			<form action="/customer/addCustomer" method="post"
				enctype="multipart/form-data">
				<div class="modal-body2">
					<h3>고객 등록하기</h3>
					<label class="form-label">이름</label> <input type="text"
						class="form-control" name="name" placeholder="이름을 입력해주세요.">
					<label class="form-label">소속</label> <input type="text"
						class="form-control" name="department" placeholder="소속을 입력해주세요.">
					<label class="form-label">연락처</label> <input type="text"
						class="form-control" name="phone" placeholder="연락처를 입력해주세요.">
					<label class="form-label">이메일</label> <input type="text"
						class="form-control" name="email" placeholder="이메일 주소를 입력해주세요.">
				</div>
				<button type="submit" class="btn btn-outline-primary mt-2" style="width: 90px;">등록하기</button>
			</form>
		</div>
	</div>

	<script>
	$("#select").change(()=>{
		if($("#select").val() === "상담일자"){
			$("#searchName").attr("type","date");
		} else {
			$("#searchName").attr("type","text");
		}
	});
	
	$('.updateCs').click(function(e) {
		e.preventDefault();
        const row = $(this).closest('tr');
        const updateList = {
       		customerId: $(this).data('customerid'),
            department: row.find('.cs-department').val(),
            phone: row.find('.cs-phone').val(),
            email: row.find('.cs-email').val(),
            assignId: row.find('.cs-assignId').val(),
        };
        
		$.ajax({
			type : "post",
			url : "/customer/updateList",
			data : updateList,
			success : function(result) {
				//console.log(updateList);
				alert("수정이 완료되었습니다!");
				location.reload();
			},
			error : function(xhr, status, error) {
				alert("처리 중 오류가 발생하였습니다.");
			}
		});
	});
	
	let customerDelId = null;
	// 삭제 Modal창
    $(".delCustomer").click(function() {
    	customerDelId = $(this).data("customerid");
        $(".delete-modal").css("display","flex");
    });
	
	
	// 삭제 버튼
    $("#delBtn").click(function(e) {
    	if(customerDelId){
	        $.ajax({
	            type : "get",
	            url : "/customer/delCustomer",
	            data : { customerId: customerDelId },
	            success : function(result) {
	                alert("삭제에 성공하였습니다.");
	                location.reload();
	            },
	            error : function(xhr, status, error) {
	                alert("error : " + error);
	                $(".delete-modal").hide();
	            }
	        });
    	}
    });
	
    $(".delete-modal .close-modal").click(function() {
    	$(".delete-modal").hide();
        customerDelId = null;
    });
    
    $(".delete-modal").click(function(e){
        if(e.target === this){
            $(this).hide();
            customerDelId = null;
        }
    });
    
	// 등록 Modal
	$("#modal-open").click(() => {
        $(".modal-back").css("display", "flex");       
     });
	
	$("#modal-close").click(() => {
       $(".modal-back").css("display", "none");       
    });
	
	/*
	$(".modal-back").click((e) => {
       if(e.target === e.currentTarget) {
			$(".modal-back").css("display", "none");
       }
    });
	*/

	// 인풋 입력 시 초기화 아이콘 노출
	const searchInput = $('input[name="search"]');
	const clearIcon = $('.clear-icon');

	if (searchInput.val().length > 0) {
		clearIcon.show();
	}

	searchInput.on('input', function() {
		if ($(this).val().length > 0) {
			clearIcon.show();
		} else {
			clearIcon.hide();
		}
	});

	clearIcon.on('click', function() {
		searchInput.val('');
		$(this).hide();
		searchInput.focus();
	});
	document.body.appendChild(logoutModal);
	logoutModal.style.zIndex = '9999';
	</script>
</body>