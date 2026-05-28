package com.sh.haagendazo.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.sh.haagendazo.mapper.UserMapper;
import com.sh.haagendazo.model.Message;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.User;


@Service
public class UserService implements UserDetailsService {

	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private PasswordEncoder bcpe;
	
	public void register(User vo) {
		//System.out.println("암호화 전 : " + vo.getPassword());
		//System.out.println("암호화 후 : " + bcpe.encode(vo.getPassword()));
		String pwd = vo.getPassword();
		vo.setPwd(pwd);
		vo.setPassword(bcpe.encode(vo.getPassword()));
//		System.out.println("원래 비밀번호 : " + pwd);
//		int defaultGradeId = 1; // 신규 가입자 기본 등급
//		vo.setGradeId(defaultGradeId);
		
		 if (vo.getGradeId() <= 2) {
	            vo.setRole("ROLE_RESEARCHER");
	        } else if (vo.getGradeId() == 9||vo.getEmail().equals("admin")) {
	        	vo.setRole("ROLE_ADMIN");
	        } else {
	        	vo.setRole("ROLE_MANAGER");
	        }
        mapper.register(vo);
        //System.out.println("회원가입 완료!");
	}
    

	public User login(String email, User vo) {
		
		 // 1. 기존 DB에 저장된 사용자 정보를 가져옵니다.
	    User existingUser = mapper.login(vo.getEmail());
	    
	    // 2. 새로운 비밀번호가 입력되었을 때만 암호화 로직을 실행합니다.
	    if (vo.getPassword() != null && !vo.getPassword().isEmpty()) {
	        vo.setPassword(bcpe.encode(vo.getPassword()));
	    } else {
	        // 비밀번호가 입력되지 않았으면 기존 비밀번호를 유지합니다.
	        vo.setPassword(existingUser.getPassword());
	    }

	    // 3. DB에 사용자 정보를 업데이트합니다.
	    mapper.login(email);

	    // 4. Spring Security 세션 갱신
	    Authentication currentAuth = SecurityContextHolder.getContext().getAuthentication();
	    UserDetails updatedUserDetails = this.loadUserByUsername(vo.getEmail());
	    
	    Authentication newAuth = new UsernamePasswordAuthenticationToken(
	            updatedUserDetails,
	            null, // 비밀번호는 세션에 저장할 필요 없음
	            updatedUserDetails.getAuthorities()
	    );

	    SecurityContextHolder.getContext().setAuthentication(newAuth);
		return existingUser;
	}
	
	public List<User> selectAll(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage()-1));
		List<User> list = mapper.selectAll(paging);
		return list;
	}
	
	public int total(Paging paging) {
		return mapper.total(paging);
	}
	
	public int count(String role) {
		return mapper.count(role);
	}
	
//	public List<User> search(User vo) {
//		return mapper.search(vo);
//	}
	
	public void updateUser(User vo) {
//	    User user = mapper.login(vo.getEmail());
//	    if (vo.getPassword() != null && !vo.getPassword().isEmpty()) {
//	        vo.setPassword(bcpe.encode(vo.getPassword()));
//	    } else {
//	        vo.setPassword(existingUser.getPassword());
//	    }
	    mapper.updateUser(vo);
	}
	
	public void deleteUser(User vo) {
		mapper.deleteUser(vo);
	}


	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		//System.out.println(email);
		User user = mapper.login(email);
		//System.out.println("로그인 성공!");
		//System.out.println(user);
		//System.out.println("---------");
		//System.out.println("사용자 권한: " + user.getAuthorities());
		return user;
	}

	public List<User> userGrade() {
		return mapper.userGrade();
	}
	
	public List<User> userDept() {
		return mapper.userDept();
	}


	public boolean isEmailDuplicate(String email) {
		return false;
	}

	public List<User> showCsdept() {
		return mapper.showCsdept();
	}
	
	public List<User> showManager(Paging paging) {
		return mapper.showManager(paging);
	}
	
	public int countSchedule(int userId) {
		return mapper.countSchedule(userId);
	}
	public int countApproval(int userId) {
		return mapper.countApproval(userId);
	}
	public int countReject(int userId) {
		return mapper.countReject(userId);
	}
	public int countClaim(int userId) {
		return mapper.countClaim(userId);
	}
	public List<Message> messageView(int userId) {
		return mapper.messageView(userId);
	}
	public void messageRead(int messageNo) {
		mapper.messageRead(messageNo);
	}

	public List<Map<String, Object>> getDeptCounts() {
		return mapper.getDeptCounts();
	}
	
	public void deleteMessage(int messageNo) {
		mapper.deleteMessage(messageNo);
	}
}
