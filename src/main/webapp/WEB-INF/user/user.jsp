<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../../resource/css/boot.css">
    <link rel="stylesheet" href="../../resource/css/layout.css">
	<link rel="stylesheet" href="../../resource/css/erp.css">
	
<style>
	/* 정렬 기능이 있는 컬럼 헤더의 배경색 변경 */
	table th:nth-child(2), /* 이름 */
	table th:nth-child(4), /* 가입일 */
	table th:nth-child(5), /* 부서 */
	table th:nth-child(6)  /* 직급(권한) */
	{
	    background-color: rgba(240, 240, 240, 0.7);
	}
	
	.user-deptId, .user-gradeId {
		max-width: 40px !important;
	}
	
	.user-table {
		width: 1300px;
	}
	.user-table td {
		text-align: left;
	}
	
	.user-table td input {
		background: transparent;
	}
	
	.user-table td select {
		font-size: 14px;
	}
	
	.user-table th a {
		text-decoration: none;
		color: inherit;
	}
	.imgbar {
	width: 80%;
	background-image: url(../../resource/static/users.jpg);
}
</style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<jsp:include page="../side.jsp"></jsp:include>

<div class="user-container">
	<div class=imgbar>
    	<h1><a href="/user">회원관리 <span id="userCount" style="font-size:22px;">(등록된 사원: ${count1} 명 / 등록된 관리자: ${count2} 명)</span></a></h1>
   
    <form action="/user" method="get" class="form-container">
        <select name="select" class="form-select w-auto">
            <option value="name" ${param.select eq 'name' ? 'selected' : ''}>이름</option>
            <option value="email" ${param.select eq 'email' ? 'selected' : ''}>아이디(이메일)</option>
            <option value="gradeName" ${param.select eq 'gradeName' ? 'selected' : ''}>직급명</option>
            <option value="deptName" ${param.select eq 'deptName' ? 'selected' : ''}>부서명</option>
        </select>
        <input type="text" name="search" class="form-control" value="${param.search}" placeholder="검색어를 입력하세요." style="width:280px;">
        <button class="btn btn-danger">검색</button>
        <button type="button" id="openModalBtn" class="btn btn-primary" style="width:110px;">사원 등록 <i class="bi bi-person-plus"></i></button>
    </form>
	</div>
    
    <table class="erp-table user-table">
        <thead>
    	<tr>
        <th>번호</th>
        <th>
            <a href="?page=1&select=${param.select}&search=${param.search}&orderBy=name&orderDirection=${param.orderBy eq 'name' and param.orderDirection eq 'ASC' ? 'DESC' : 'ASC'}">
                이름
                <c:if test="${param.orderBy eq 'name' and param.orderDirection eq 'ASC'}"><span class="upArrow">▲</span></c:if>
                <c:if test="${param.orderBy eq 'name' and param.orderDirection eq 'DESC'}"><span class="downArrow">▼</span></c:if>
            </a>
        </th>
        <th>아이디(이메일)</th>
        <th>
            <a href="?page=1&select=${param.select}&search=${param.search}&orderBy=createdAt&orderDirection=${param.orderBy eq 'createdAt' and param.orderDirection eq 'ASC' ? 'DESC' : 'ASC'}">
                가입일
                <c:if test="${param.orderBy eq 'createdAt' and param.orderDirection eq 'ASC'}"><span class="upArrow">▲</span></c:if>
                <c:if test="${param.orderBy eq 'createdAt' and param.orderDirection eq 'DESC'}"><span class="downArrow">▼</span></c:if>
            </a>
        </th>
        <%-- <th>비밀번호</th>--%>
        <th>
            <a href="?page=1&select=${param.select}&search=${param.search}&orderBy=deptId&orderDirection=${param.orderBy eq 'deptId' and param.orderDirection eq 'ASC' ? 'DESC' : 'ASC'}">
                부서
                <c:if test="${param.orderBy eq 'deptId' and param.orderDirection eq 'ASC'}"><span class="upArrow">▲</span></c:if>
                <c:if test="${param.orderBy eq 'deptId' and param.orderDirection eq 'DESC'}"><span class="downArrow">▼</span></c:if>
            </a>
        </th>
        <th>
            <a href="?page=1&select=${param.select}&search=${param.search}&orderBy=gradeId&orderDirection=${param.orderBy eq 'gradeId' and param.orderDirection eq 'ASC' ? 'DESC' : 'ASC'}">
                직급(권한)
                <c:if test="${param.orderBy eq 'gradeId' and param.orderDirection eq 'ASC'}"><span class="upArrow">▲</span></c:if>
                <c:if test="${param.orderBy eq 'gradeId' and param.orderDirection eq 'DESC'}"><span class="downArrow">▼</span></c:if>
            </a>
        </th>
        <th>관리자</th>
        <th>수정</th>
        <th>삭제</th>
	    </tr>
		</thead>
            <tbody>
                <c:forEach items="${list}" var="user">
                    <tr>
                        <td>${user.userId}</td>
                        <input type="hidden" class="user-id" value="${user.userId}">
                        <td>${user.name}</td>
                        <td><input type="text" class="user-email" value="${user.email}"></td>
				        <td>
				        <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd" /> 가입
                        </td>
                        <%-- <td><input type="text" class="user-password" value="${user.password}"></td> --%>
                        <td>
                            <input type="text" class="user-deptId" value="${user.deptId}">
                            <span>${user.deptName}</span>
                        </td>
                        <td>
                            <input type="text" class="user-gradeId" value="${user.gradeId}">
                            <span>${user.gradeName} (${user.role})</span>
                        </td>
                        <td>
                        	<select class="form-select user-managerId" data-userid="${user.userId}" data-deptid="${user.deptId}" data-gradeid="${user.gradeId}">
							  <option value="" selected disabled>-- 선택 --</option>
							  <c:forEach items="${managerList}" var="manager">
							    <option value="${manager.userId}" ${user.managerId eq manager.userId ? 'selected' : ''}>${manager.name}</option>
							  </c:forEach>
							</select>
                        </td>
                        <td>
                            <button class="btn btn-danger updateBtn" data-userid="${user.userId}"><i class="bi bi-pencil"></i></button>
                        </td>
                        <td>
                            <button class="btn btn-outline-danger deleteModal" data-userid="${user.userId}"><i class="bi bi-trash"></i></button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    
    <nav aria-label="Page navigation">
    <ul class="erp-pagination">
        <li class="page-item ${paging.prev ? '' : 'disabled'}">
            <c:url var="prevLink" value="/user">
                <c:param name="page" value="${paging.startPage - 1}"/>
                <c:param name="search" value="${param.search}"/>
                <c:param name="select" value="${param.select}"/>
                <c:param name="orderBy" value="${param.orderBy}"/>
                <c:param name="orderDirection" value="${param.orderDirection}"/>
            </c:url>
            <a class="page-link" href="${prevLink}" aria-label="Previous">이전</a>
        </li>
        <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
            <li class="page-item ${paging.page == page ? 'active' : ''}">
                <c:url var="pageLink" value="/user">
                    <c:param name="page" value="${page}"/>
                    <c:param name="search" value="${param.search}"/>
                    <c:param name="select" value="${param.select}"/>
                    <c:param name="orderBy" value="${param.orderBy}"/>
                    <c:param name="orderDirection" value="${param.orderDirection}"/>
                </c:url>
                <a class="page-link" href="${pageLink}">${page}</a>
            </li>
        </c:forEach>
        <li class="page-item ${paging.next ? '' : 'disabled'}">
            <c:url var="nextLink" value="/user">
                <c:param name="page" value="${paging.endPage + 1}"/>
                <c:param name="search" value="${param.search}"/>
                <c:param name="select" value="${param.select}"/>
                <c:param name="orderBy" value="${param.orderBy}"/>
                <c:param name="orderDirection" value="${param.orderDirection}"/>
            </c:url>
            <a class="page-link" href="${nextLink}" aria-label="Next">다음</a>
        </li>
    </ul>
</nav>

    
 </div>
 
 <div class="open-modal delete-modal">
        <div class="modal-body">
            <h4>정말 삭제하시겠습니까?</h4>
            <button type="button" class="btn btn-warning" id="deleteBtn">삭제</button>
            <button type="button" class="btn btn-secondary closeModal">취소</button>
        </div>
    </div>
     	
       	<div id="registerModal" class="modal">
		  <div class="modal-dialog modal-dialog-centered" style="max-width: 600px; margin-left: 770px;">
		    <div class="modal-content" style="height: 330px; padding: 30px; line-height: 1.5;">
		      <jsp:include page="register.jsp" />
		    </div>
	      </div>
		</div>
    
    <script>
    $(document).ready(function() {
    	// register 모달
		const registerModal = document.getElementById('registerModal');
    	const openModalBtn = document.getElementById('openModalBtn');
    	const closeRegisterBtn = document.getElementById('closeRegisterBtn');

	    openModalBtn.onclick = function () {
	    	registerModal.style.display = "block";
	    }
	
	    closeRegisterBtn.onclick = function () {
	    	registerModal.style.display = "none";
	    }
	
	    window.addEventListener("click", function(event) {
	        if (event.target === registerModal) {
	            registerModal.style.display = "none";
	        }
	    });
    
    	// 모달 열기
        $(".deleteModal").click(function() {
            $(".open-modal").css("display","flex");
            const userId = $(this).data("userid");
            // 모달 내의 '삭제' 버튼에 userId를 저장합니다.
            $("#deleteBtn").data("userid", userId);
             //console.log("모달 열기 - userId: ", userId);
        });

        // 모달 닫기
        $(".closeModal").click(function() {
            $(".open-modal").css("display","none");
        });
        
        // 삭제 버튼 클릭
        $('#deleteBtn').click(function(e) {
            e.preventDefault();
            const userId = $(this).data("userid");
            // console.log("삭제 버튼 클릭 - userId: ", userId);

            if (userId) {
                $.ajax({
                    type: "post",
                    url: "/user/delete",
                    data: { userId: userId },
                    success: function(result){
                        alert("삭제가 완료되었습니다!");
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert("처리 중 오류가 발생하였습니다.");
                    }
                });
            } else {
                alert("사용자 정보를 찾을 수 없습니다.");
            }
        });

        // 유저 정보 수정 AJAX
        $('.updateBtn').click(function(e) {
            e.preventDefault();
            const row = $(this).closest('tr');
            
            const updateData = {
                userId: $(this).data('userid'),
                email: row.find('.user-email').val(),
                deptId: row.find('.user-deptId').val(),
                gradeId: row.find('.user-gradeId').val(),
                managerId: row.find('.user-managerId').val()
            };

            $.ajax({
                type: "post",
                url: "/user/update",
                data: updateData,
                success: function(result){
                    alert("수정이 완료되었습니다!");
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert("처리 중 오류가 발생하였습니다.");
                }
            });
        });
        
        /* $(".user-managerId").click(function(e) {
            const row = $(this).closest('tr');
            const userId = $(this).data('userid');
            const deptId = $(this).data("deptid");
            const gradeId = $(this).data("gradeid");
            const managerId = $(this).closest('tr').find('.user-managerId').val();

            $.ajax({
                type: "get",
                url: "/user/managerSelect",
                data: {
                    deptId: deptId,
                    gradeId: gradeId
                },
                success: function (data) {
                	$(this).empty();
                	$(this).append(`<option value="">-- 선택 --</option>`);
                    data.forEach(function (manager) {
                        const selected = manager.userId == managerId ? "selected" : "";
                        $(this).append(
                            `<option value="${manager.userId}" ${selected}>${manager.name}</option>`
                        );
                    });
                error: function() {
                    console.error("정보를 불러오지 못했습니다.");
                }
            });
        });*/
    });
    </script>
</body>
</html>