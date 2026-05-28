$(document).ready(function() {
    // 모든 입력 필드와 버튼 요소를 변수로 저장
    const emailInput = $('#emailInput');
    const passwordInput = $('#passwordInput');
    const nameInput = $('#nameInput');
    const gradeIdSelect = $('#gradeIdSelect');
    const deptIdSelect = $('#deptIdSelect');
    const registerButton = $('#registerButton');
    const registerSubmit = registerButton.find('input[type="submit"]');
    const emailCheckMsg = $('#emailCheckMsg');

    let isEmailValid = false;
    let isFormValid = false;

    // 모든 입력 필드의 상태를 확인하여 버튼 활성화 여부를 결정
    function checkFormValidity() {
        const allFieldsFilled = 
            emailInput.val().length > 0 &&
            passwordInput.val().length > 0 &&
            nameInput.val().length > 0 &&
            gradeIdSelect.val() > 0 &&
            deptIdSelect.val() > 0;

        isFormValid = allFieldsFilled && isEmailValid;
        
        if (isFormValid) {
            registerButton.prop('disabled', false);
            registerSubmit.prop('disabled', false);
        } else {
            registerButton.prop('disabled', true);
            registerSubmit.prop('disabled', true);
        }
    }

    // 이메일 중복 검사 (AJAX)
    function checkEmailDuplication() {
        const email = emailInput.val();
        // 이메일 형식이 유효할 때만 중복 검사 실행
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (email.length > 0 && emailRegex.test(email)) {
            $.ajax({
                type: "GET",
                url: "/checkEmail", // 컨트롤러에 정의된 URL
                data: { email: email },
                success: function(response) {
                    if (response === 'duplicate') {
                        emailCheckMsg.text('중복된 아이디입니다.').css("font-size", "12px");
                        isEmailValid = false;
                    } else {
                        emailCheckMsg.text('사용 가능한 아이디입니다.').css("font-size", "12px");
                        emailCheckMsg.css('color', 'green');
                        isEmailValid = true;
                    }
                    checkFormValidity();
                },
                error: function() {
                    emailCheckMsg.text('서버 오류 발생');
                    isEmailValid = false;
                    checkFormValidity();
                }
            });
        } else {
            // 이메일 입력이 비어있거나 형식이 유효하지 않을 때
            emailCheckMsg.text('');
            isEmailValid = false;
            checkFormValidity();
        }
    }

    // 입력 필드 변경 이벤트 리스너
    // keyup: 키보드를 누른 후 떼는 시점에 이벤트 발생
    emailInput.on('keyup', checkEmailDuplication);
    passwordInput.on('keyup', checkFormValidity);
    nameInput.on('keyup', checkFormValidity);
    gradeIdSelect.on('change', checkFormValidity);
    deptIdSelect.on('change', checkFormValidity);
    
    // 페이지 로드 시 초기 상태 검사
    checkFormValidity();
});