<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="../../resource/css/boot.css">
    <link rel="stylesheet" href="../../resource/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <h1><b>로그인</b></h1>
        
        <form action="/login" method="post">
            <div class="form-group">
                <span>아이디(이메일) : </span>
                <div class="id-container">
                    <input type="text" name="email" id="emailInput">
                </div>
            </div>
            
            <div class="form-group">
                <span>비밀번호 : </span>
                <div class="password-container">
                    <input type="password" name="password" id="passwordInput">
                    <span class="toggle-password" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
            </div>
            
            <div class="button-group">
                <button type="submit" class="login-btn" id="loginBtn" style="height:40px;" disabled>로그인</button>
            </div>
        </form>
        
        <div class="links mt-3">
            <a href="#" class="link-find" data-bs-toggle="modal" data-bs-target="#findIdModal">아이디 찾기</a>
            <span class="divider">|</span>
            <a href="#" class="link-find" data-bs-toggle="modal" data-bs-target="#findPwdModal">비밀번호 찾기</a>
            
            <%-- <span class="divider">|</span>
            <a href="#" class="link-find" data-bs-toggle="modal" data-bs-target="#userListModal">유저 목록</a> --%>
        </div>
    </div>

    <div class="modal fade" id="findIdModal" tabindex="-1" aria-labelledby="findIdModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" style="width:450px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="findIdModalLabel">아이디 찾기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="findIdEmail" class="form-label">사원명을 입력해주세요</label>
                            <input type="email" class="form-control" id="findIdEmail" style="width:90%;">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                	<button type="button" class="btn btn-warning">아이디 찾기</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="findPwdModal" tabindex="-1" aria-labelledby="findPwdModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="findPwdModalLabel">비밀번호 찾기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="findPwdEmail" class="form-label">아이디(이메일)를 입력해주세요</label>
                            <input type="email" class="form-control" id="findPwdEmail" placeholder="name@example.com" style="width:90%;">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                	<button type="button" class="btn btn-warning">비밀번호 찾기</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="userListModal" tabindex="-1" aria-labelledby="userListModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="userListModalLabel">유저 목록 샘플 (비밀번호:123)</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>아이디</th>
                                <th>이름</th>
                                <th>부서</th>
                                <th>권한</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>user1@gmail.com</td>
                                <td>가나다</td>
                                <td>고객서비스부</td>
                                <td>ROLE_MANAGER</td>
                            </tr>
                            <tr>
                                <td>david.lee3@naver.com</td>
                                <td>이다윗</td>
                                <td>어드민</td>
                                <td>ROLE_ADMIN</td>
                            </tr>
                            <tr>
                                <td>no-reply@system.com</td>
                                <td>노답</td>
                                <td>특허부</td>
                                <td>ROLE_RESEARCHER</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    <script>
	    const emailInput = document.getElementById('emailInput');
	    const passwordInput = document.getElementById('passwordInput');
	    const loginBtn = document.getElementById('loginBtn');
	    const togglePassword = document.getElementById('togglePassword');
	    const eyeIcon = togglePassword.querySelector('i');
	    
	    // 입력 필드 상태를 확인하고 버튼을 활성화/비활성화하는 함수
	    function checkInputs() {
	        if (emailInput.value.trim() !== '' && passwordInput.value.trim() !== '') {
	            loginBtn.disabled = false;
	        } else {
	            loginBtn.disabled = true;
	        }
	    }
	
	    // 아이디와 비밀번호 입력 필드에 키보드 입력 이벤트 리스너 추가
	    emailInput.addEventListener('keyup', checkInputs);
	    passwordInput.addEventListener('keyup', checkInputs);

        // 마우스를 누르고 있을 때
        togglePassword.addEventListener('mousedown', function() {
            passwordInput.setAttribute('type', 'text');
            eyeIcon.classList.remove('fa-eye');
            eyeIcon.classList.add('fa-eye-slash');
        });

        // 마우스를 떼었을 때
        togglePassword.addEventListener('mouseup', function() {
            passwordInput.setAttribute('type', 'password');
            eyeIcon.classList.remove('fa-eye-slash');
            eyeIcon.classList.add('fa-eye');
        });

        // 사용자가 아이콘 위에서 마우스를 놓칠 경우를 대비
        togglePassword.addEventListener('mouseleave', function() {
            if (passwordInput.getAttribute('type') === 'text') {
                passwordInput.setAttribute('type', 'password');
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        });
        
    	// '아이디 찾기' 모달 관련 요소
        const findIdModal = document.getElementById('findIdModal');
        const findIdInput = document.getElementById('findIdEmail');
        const findIdBtn = findIdModal.querySelector('.btn-warning');

        // '아이디 찾기' 버튼 클릭 이벤트 리스너
        findIdBtn.addEventListener('click', function() {
            const userName = findIdInput.value.trim();

            if (userName === '') {
                alert('사원명을 입력해주세요.');
                return;
            }

            // AJAX를 사용하여 서버에 요청
            $.ajax({
                url: '/user/find-email',
                type: 'POST',
                data: { name: userName },
                success: function(response) {
                    // 응답으로 받은 데이터를 처리
                    if (response.email) {
                        alert('등록된 아이디는 ' + response.email + ' 입니다.');
                    } else {
                        alert('입력하신 사원명으로 등록된 아이디가 없습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    // 요청 실패 시 에러 처리
                    //console.error('AJAX Error: ', status, error);
                    alert('아이디를 찾는 도중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        });
    </script>
</body>
</html>