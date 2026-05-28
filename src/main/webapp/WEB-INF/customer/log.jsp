<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../../resource/css/boot.css">
<link rel="stylesheet" href="../../resource/css/layout.css">
<link rel="stylesheet" href="../../resource/css/erp.css">
<title>CSLog</title>
<style>
.imgbar {
	width: 80%;
	background-image: url(../../resource/static/client.jpg);
}

.project-cell-content select {
  width: 300px;
  font-size: 14px;
}
</style>
</head>
<body>
    <jsp:include page="../header.jsp"></jsp:include>
    <jsp:include page="../side.jsp"></jsp:include>
    
    <div class="customer-log">
	<div class=imgbar>
    <h1><a href="/customer/log">클레임 리스트</a></h1>
    
    <form action="/customer/log" method="get" class="form-container">
        <select name="select" id="select" class="form-select w-auto">
            <option value="고객명">고객명</option>
            <option value="담당자명">담당자명</option>
            <option value="상담일자">상담일자</option>
        </select>
        <span class="search-flex-container">
            <input id="searchName" type="text" class="form-control" name="search" value="${param.search}" placeholder="검색어를 입력하세요.">
            <i class="bi bi-eraser-fill clear-icon"></i>
        </span>
        <div class="button-group">
            <button id="searchLog" class="btn btn-danger">검색</button>
            <button type="button" id="modal-open" class="btn btn-primary">등록</button>
            <sec:authorize access="hasAnyRole('RESEARCHER','MANAGER')">
			<a href="/" class="btn btn-dark"><i class="bi bi-house-door-fill"></i></a>
			</sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
			<a href="/statistics" class="btn btn-dark"><i class="bi bi-house-door-fill"></i></a>
			</sec:authorize>
        </div>
    </form>
	</div>
	
    <table class="erp-table list-table">
        <tr>
            <th>번호</th>
            <th>고객명</th>
            <th>내용</th>
            <th>상담일자</th>
            <th>담당자명</th>
            <th>프로젝트명</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        <c:forEach items="${log}" var="cs">
            <tr>
                <td>${cs.logId}</td>
                <td>${cs.name}</td>
                <td><textarea class="cs-desc">${cs.clDescription}</textarea></td>
                <td><fmt:formatDate value="${cs.logDate}" pattern="yyyy-MM-dd" /></td>
                <td>${cs.userName}</td>
                <td>
                    <div class="project-cell-content">
                    <select class="form-select cs-projectId">
                    <option value="" selected disabled>-- 프로젝트명을 선택해주세요 --</option>
                    <c:forEach items="${projectList}" var="project">
                        <option value="${project.projectId}"
                            <c:if test="${project.projectId == cs.projectId}">selected</c:if>>
                            ${project.projectName}
                        </option>
                    </c:forEach>
                    </select>
                    <button class="btn btn-outline-primary" onclick="location.href='/project/detail?projectId=${cs.projectId}'" style="width:70px;">이동</button>
                    </div>
                </td>
                <td><button class="btn btn-danger updateLog" data-logid="${cs.logId}"><i class="bi bi-pencil"></i></button></td>
                <td><button class="btn btn-outline-danger delLog" data-logid="${cs.logId}"><i class="bi bi-trash"></i></button></td>
            </tr>
        </c:forEach>
    </table>
    <div class="open-modal delete-modal" id="deleteModal">
        <div class="modal-body">
            <h4>해당 클레임 내용을 삭제하시겠습니까?</h4>
            <button type="submit" id="delBtn" data-logid="${cs.logId}" class="btn btn-warning">삭제</button>
            <button class="close-modal btn btn-secondary">닫기</button>
        </div>
    </div>
    
       <nav>
        <ul class="erp-pagination">
            <li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/customer/log?page=${paging.startPage - 1}">이전</a></li>

            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
                <li class="page-item ${paging.page == page ? 'active' : ''}"><a class="page-link" href="/customer/log?page=${page}">${page}</a></li>
            </c:forEach>

            <li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/customer/log?page=${paging.endPage + 1}">다음</a></li>
        </ul>
    </nav>
</div>

    <div class="modal-back">
        <div class="write-modal">
            <button id="modal-close"><i class="bi bi-x"></i></button>
            <form action="/customer/addLog" method="post" enctype="multipart/form-data">
                <div class="modal-body2">
                    <h3>클레임 리포트 작성</h3>
                        <label class="form-label">고객명</label>
                            <select class="form-control" name="customerId" id="customerSelect">
                            <option value="customerId" selected disabled>--- 이름을 선택해주세요 ---</option>
                                <c:forEach items="${list}" var="cs">
                                <option value="${cs.customerId}">${cs.name}</option>
                                </c:forEach>
                        </select>
                        <label class="form-label">내용</label>
                        <textarea class="form-control" rows="3" name="description"></textarea>
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

    $('.updateLog').click(function(e) {
        e.preventDefault();
        const row = $(this).closest('tr');
        const updateLog = {
            logId: $(this).data('logid'),
            projectId: row.find('.cs-projectId').val(),
            description: row.find('.cs-desc').val(),
        };

        $.ajax({
            type : "post",
            url : "/customer/updateLog",
            data : updateLog,
            success : function(result) {
                //console.log(updateLog);
                alert("수정이 완료되었습니다!");
                location.reload();
            },
            error : function(xhr, status, error) {
                alert("처리 중 오류가 발생하였습니다.");
            }
        });
    });

    let logDelId = null;
    $(".delLog").click(function() {
        logDelId = $(this).data("logid");
        $(".delete-modal").css("display","flex");
    });

    $("#delBtn").click(function(e) {
        if(logDelId){
            $.ajax({
                type : "get",
                url : "/customer/delLog",
                data : { logId: logDelId },
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
        logDelId = null;
    });

    $(".delete-modal").click(function(e){
        if(e.target === this){
            $(this).hide();
            logDelId = null;
        }
    });

    $("#modal-open").click(() => {
        $(".modal-back").css("display", "flex");
     });

    $("#modal-close").click(() => {
       $(".modal-back").css("display", "none");
    });

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

    </script>
</body>
</html>