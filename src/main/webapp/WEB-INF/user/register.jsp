<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#registerModal {
	background: rgba(0,0,0,0.4);
}
.modal-content .form-group {
    display: flex;
    align-items: center;
    justify-content: space-between; /* 텍스트와 입력 필드 양 끝 정렬 */
    margin-bottom: 12px;
    gap: 0;
}

.modal-content .form-group span {
    font-size: 16px;
    color: #555555;
    white-space: nowrap; /* 줄바꿈 방지 */
}

.modal-content input[type="text"],
.modal-content input[type="password"] {
    width: 60%; /* 입력 필드 너비 조정 */
    padding: 8px; /* 패딩을 줄여서 높이 축소 */
    border: 1px solid #dddddd;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 14px;
}

.modal-content input[type="text"]:focus,
.modal-content input[type="password"]:focus {
    border-color: #007bff;
    outline: none;
}

.modal-content input[type="submit"] {
    background-color: #A4193D;
    color: #ffffff;
    border: none;
    padding: 10px; /* 버튼 패딩 축소 */
    border-radius: 4px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: backgrcolor 0.3s ease;
    margin-top: 15px; /* 버튼 위쪽 여백 추가 */
}

.modal-content input[type="submit"]:hover {
    background-color: rgb(128, 0, 64);
}

.modal-content input[type="text"],
.modal-content input[type="password"] {
    width: 60%;
    padding: 8px;
    border: 1px solid #dddddd;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 14px;
    background-color: #ffffff;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-image: none;
}

.modal-content select {
    width: 60%;
    padding: 8px;
    border: 1px solid #dddddd;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 14px;
    background-color: #ffffff;
    /* select의 기본 UI를 제거하고 커스텀 화살표를 적용합니다. */
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="%23666" viewBox="0 0 16 16"><path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/></svg>');
    background-repeat: no-repeat;
    background-position: right 8px center;
}

.modal-content input[type="text"]:focus,
.modal-content input[type="password"]:focus,
.modal-content select:focus {
    border-color: #007bff;
    outline: none;
}

.modal-content .button-group {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
    width: 100%;
}

.button-group button {
    flex: 1; /* 남은 공간을 균등하게 차지하도록 함 */
    padding: 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-align: center;
    height: 40px;
}

.modal-content .button-group button input[type="submit"],
.modal-content .button-group button a {
    display: block; /* a 태그를 블록 레벨로 변경하여 전체 버튼 영역을 채우도록 함 */
    width: 100%;
    padding: 10px;
    box-sizing: border-box; /* 패딩을 너비에 포함 */
    border: none;
    border-radius: 4px;
    font-size: 16px;
    font-weight: bold;
    text-decoration: none;
    color: #ffffff;
}

.modal-content .button-group button input[type="submit"] {
    background-color: #A4193D;
    border: none;
    border-radius: 4px;
    margin: 0;
}

/* 비활성화된 회원등록 버튼 스타일 (회색) */
.modal-content #registerButton[disabled] input[type="submit"] {
    background-color: lightgrey;
    border: none;
    border-radius: 4px;
    cursor: not-allowed;
    height: 40px;
}

/* 활성화된 회원등록 버튼 스타일 */
.modal-content #registerButton:not([disabled]) input[type="submit"] {
    background-color: #A4193D;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    height: 40px;
}

/* 중복 메시지 스타일 */
.modal-content .error-message {
    color: red;
    font-size: 12px;
    margin-top: -5px;
    margin-bottom: 10px;
    display: block; /* 텍스트가 한 줄을 차지하도록 함 */
}

.modal-content #emailCheckMsg {
    /* 이메일 입력창과 동일한 너비를 갖도록 설정 */
    width: 100%;
    /* 텍스트가 시작점과 정렬되도록 왼쪽 정렬 */
    text-align: left;
    margin-top: 5px; /* 입력창과 약간의 간격 조절 */
    margin-left: 0;
}

/* button 태그에 대한 일반적인 스타일 정의 */
.modal-content .button-group button {
    flex: 1; /* 남은 공간을 균등하게 차지하도록 함 */
    padding: 0;
    border: none;
    cursor: pointer;
    text-align: center;
    background: #6c757d;
}

</style>
        <form action="/register" method="post">
            <div class="form-group">
                <span>아이디(이메일) : </span><input type="text" name="email" id="emailInput">
            </div>
            <span id="emailCheckMsg" class="errorMsg"></span>
            <div class="form-group">
                <span>비밀번호 : </span><input type="password" name="password" id="passwordInput">
            </div>
            
            <div class="form-group">
                <span>이름 : </span><input type="text" name="name" id="nameInput">
            </div>
            <div class="form-group">
                <span>직급 : </span>
	            <select name="gradeId" id="gradeIdSelect" required>
            		<c:forEach items="${grade}" var="grade">
            			<c:if test="${grade.gradeName != '어드민'}">
	            		<option value="${grade.gradeId}">${grade.gradeName}</option>
	            		</c:if>
            		</c:forEach>
		        </select>    
		        <%--  <option value="1">사원</option>
		            <option value="2">선임</option>
		            <option value="3">책임</option>
		            <option value="4">수석</option>
		            <option value="5">파트장</option>
		            <option value="6">팀장</option>
		            <option value="7">그룹장</option>
		            <option value="8">실장</option> --%>
	        	
            </div>
            <div class="form-group">
                <span>부서 : </span>
                <select name="deptId" id="deptIdSelect" required>
                	<c:forEach items="${dept}" var="dept">
	                	<c:if test="${dept.deptName != '어드민'}">
		            	<option value="${dept.deptId}">${dept.deptName}</option>
		            	</c:if>
	            	</c:forEach>
	            </select>	
			    <%-- <option value="1">신약개발부</option>
				    <option value="2">임상개발부</option>
				    <option value="3">약물감시부</option>
				    <option value="4">사업개발부</option>
				    <option value="5">생산부</option>
				    <option value="6">품질관리부</option>
				    <option value="7">품질보증부</option>
				    <option value="8">규제업무부</option>
				    <option value="9">특허부</option>
				    <option value="10">인사부</option>
				    <option value="11">재무회계부</option>
				    <option value="12">총무부</option>
				    <option value="13">영업부</option>
				    <option value="14">마케팅부</option>
				    <option value="15">고객서비스부</option> --%> 
            </div>
            <div class="button-group">
			<button id="registerButton" disabled><input type="submit" value="회원등록" disabled></button>
			<button id="closeRegisterBtn"><a href="/user">닫기</a></button>
		</div>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="../resource/js/register.js"></script>
