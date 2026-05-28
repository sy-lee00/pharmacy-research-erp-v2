package com.sh.haagendazo.model;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class User implements UserDetails {
	
	private int userId;			// Primary Key
	private String email;		// 로그인 아이디로 활용
	private String password;	// 암호화로 저장
	private String pwd; 		// 원래 비밀번호 (암호화 이전)
	private String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdAt;
	private int managerId;		// 관리자 id (상위)
	
	private int gradeId;
	private String gradeName;
	private String role;		// 접근 권한 설정 
	// (gradeId => 1~2 : RESEARCHER, 3~8 : MANAGER, 9 : ADMIN)
	
	private int deptId;
	private String deptName;
	
	private String search;
	private String select;
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority(role));
	}
	
	@Override // 시큐리티의 비밀번호와 변수 매칭
	public String getPassword() {
		return this.password;
	}
	
	@Override // 시큐리티의 이름과 변수 매칭
	public String getUsername() {
		return this.email;
	}

	
//	@Override
//	public boolean isAccountNonExpired() {
//		return true; // 계정 만료 여부 (true: 만료되지 않음)
//	}
//
//	@Override
//	public boolean isAccountNonLocked() {
//		return true; // 계정 잠금 여부 (true: 잠기지 않음)
//	}
//
//	@Override
//	public boolean isCredentialsNonExpired() {
//		return true; // 비밀번호 만료 여부 (true: 만료되지 않음)
//	}
//
//	@Override
//	public boolean isEnabled() {
//		return true; // 계정 활성화 여부 (true: 활성화됨)
//	}
	
}
