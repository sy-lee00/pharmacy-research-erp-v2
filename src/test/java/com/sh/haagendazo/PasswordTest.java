// 본인의 패키지 경로에 맞게 수정하세요
package com.sh.haagendazo;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String rawPassword = "qwer1234"; // 여기에 실제 사용할 비번 입력
        String result = encoder.encode(rawPassword);
        
        System.out.println("================================");
        System.out.println("암호화된 비밀번호: " + result);
        System.out.println("================================");
    }
}