<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>관리자 페이지</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="../../resource/css/layout.css">

<style>

a {
	text-decoration: none;
	color: inherit;
}
.admin-container {
    border: 1px solid var(--main-back);
    border-radius: 8px;
    padding: 30px 40px;
    max-width: 600px;
    margin: 40px auto;
    background-color: #fff;
    box-shadow: 0 0 15px rgba(0,0,0,0.1);
    font-family: Arial, sans-serif;
    color: #333;
}

.admin-container h1 {
    text-align: center;
    color: var(--main-back);
    margin-bottom: 25px;
    font-size: 28px;
}

.admin-links {
    display: flex;
    flex-direction: column;
    gap: 15px;
    font-size: 1rem;
}

.admin-links a button {
	width: 200px;
    color: #a4193d;
    text-decoration: none;
    padding: 8px 4px;
    border: 1px solid #a4193d;
    border-radius: 5px;
    transition: background-color 0.2s, color 0.2s;
    text-align: center;
}

.admin-links a button:hover {
    background-color: #a4193d;
    color: white;
}
</style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<jsp:include page="../side.jsp"></jsp:include>

	<div class="admin-container">
    <h1>관리자 페이지</h1>

	<p><b><sec:authentication property="principal.name" /></b>님 안녕하세요!</p>
        
        <div class="user-info-list">
            <p><span>아이디</span> : <sec:authentication property="principal.email" /></p>
            <p><span>부서</span> : <sec:authentication property="principal.deptName" /></p>
            <p><span>직급</span> : <sec:authentication property="principal.gradeName" /></p>
        </div>
	
    <div class="admin-links">
       <a href="/"><button>홈으로</button></a>
       <a href="/user"><button>회원 목록</button></a>
       <a href="/statistics"><button>통계 및 현황</button></a>
    </div>
	</div>

	<div class="admin-container msg-box">
	    	
	    	<h1>쪽지함</h1>
	    	<div>
	    		메시지 박스 (주고받은 메시지가 담겨있음)
	    	</div>
	    	<div>
	    		알림 박스 (업무 관련 알림이 담겨있음)
	    	</div>
	</div>
</body>
</html>
