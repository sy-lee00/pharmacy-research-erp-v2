package com.sh.haagendazo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sh.haagendazo.model.Message;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.User;
import com.sh.haagendazo.service.UserService;


@Controller
public class UserController {

	@Autowired
	private UserService service;

	@GetMapping("/user")
	public String index(Model model, Paging paging, @RequestParam(defaultValue = "1") int page, User vo, @RequestParam(required = false) String order) {
		 if (paging.getPage() < 1) {
		        paging.setPage(1);
		    }
		    paging.setOffset(paging.getLimit() * (paging.getPage() - 1));

		    if ("asc".equalsIgnoreCase(order)) {
		        paging.setOrderDirection("ASC");
		    } else if ("desc".equalsIgnoreCase(order)) {
		        paging.setOrderDirection("DESC");
		    }
		    
	    List<User> list = service.selectAll(paging);
	    model.addAttribute("list", list);
//	    List<User> search = service.search(vo);
//	    model.addAttribute("list", search);
	    model.addAttribute("paging", new Paging(paging.getPage(), service.total(paging)));
	    
	    int count1 = service.count("ROLE_RESEARCHER");
	    int count2 = service.count("ROLE_MANAGER");
	    model.addAttribute("count1", count1);
	    model.addAttribute("count2", count2);
	    
	    List<User> grade = service.userGrade();
		List<User> dept = service.userDept();
		
		model.addAttribute("grade", grade);
		model.addAttribute("dept", dept);
		
		List<User> managerList = service.showManager(paging);
		model.addAttribute("managerList", managerList);
		
	    return "/user/user";
	}
	
	@GetMapping("/user/managerSelect")
	@ResponseBody
	public List<User> managerSelect(Paging paging) {
	    System.out.println(paging);
		return service.showManager(paging);
	}
	
	@GetMapping("/register")
	public String register(Model model) {
		List<User> grade = service.userGrade();
		List<User> dept = service.userDept();
		
		model.addAttribute("grade", grade);
		model.addAttribute("dept", dept);
		return "/user/register";
	}
	
	@PostMapping("/register")
	public String register(User vo, Model model) {
		service.register(vo);
		return "redirect:/user";
	}
	
	@GetMapping("/checkEmail")
	@ResponseBody
	public String checkEmail(@RequestParam("email") String email) {
	    // service.isEmailDuplicate(email) 메서드는 DB에서 이메일이 존재하는지 확인하고 true/false를 반환한다고 가정
	    if (service.isEmailDuplicate(email)) {
	        return "duplicate";
	    } else {
	        return "available";
	    }
	}
	
//	@PostMapping("/")
//	public String search(User vo, Model model) {
//		List<User> search = service.search(vo);
//		model.addAttribute("list", search);
//		return "user";
//	}
	
	@PostMapping("/user/update")
	public String updateUser(User vo) {
		//HttpSession session = request.getSession();
		//User user = (User) session.getAttribute("user");
		//vo.setUserId(user.getUserId());
		service.updateUser(vo); // DB에서 사용자 정보를 업데이트
		//System.out.println(vo);
		
	    // 2. 현재 로그인된 사용자의 Authentication 객체를 가져옵니다.
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    
	    // 3. 업데이트된 정보로 새로운 UserDetails 객체를 생성합니다.
	    // 기존의 principal 객체가 UserDetails를 구현하고 있다고 가정합니다.
	    UserDetails principal = (UserDetails) authentication.getPrincipal();
	    
	    // 이 부분에서 principal 객체의 정보를 업데이트합니다.
	    // 예시: principal.setDeptName(updatedUser.getDeptName());
	    // 예시: principal.setGradeName(updatedUser.getGradeName());

	    // 4. 새로운 Authentication 객체를 생성합니다.
	    Authentication newAuth = new UsernamePasswordAuthenticationToken(
	        principal, 
	        null, //authentication.getCredentials(), 
	        principal.getAuthorities());

	    // 5. SecurityContext에 새 Authentication 객체를 설정하여 세션을 갱신합니다.
	    SecurityContextHolder.getContext().setAuthentication(newAuth);
	    
		return "redirect:/user";
	}
//	@PostMapping("/update")
//	public String update(User vo, HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		User user = (User) session.getAttribute("user");
//		vo.setUserId(user.getUserId());
//		service.update(vo);
//		return "redirect:/";
//	}
	
	@PostMapping("/user/delete")
	public String deleteUser(User vo) {
		service.deleteUser(vo);
		//System.out.println(vo);
		return "redirect:/user";
	}
	
	@GetMapping("/login")
	public String login() {
		return "/user/login";
	}
	
	@GetMapping("/mypage")
	public String mypage(Model model) {
		// 현재 로그인된 사용자의 Authentication 객체를 가져옵니다.
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // 현재 principal에서 사용자 아이디(이메일)를 가져옵니다.
        User loginUser = (User) authentication.getPrincipal();
        String userEmail = ((UserDetails) authentication.getPrincipal()).getUsername();
        // 1. 데이터베이스에서 최신 사용자 정보를 조회합니다.
        // 이 메서드는 UserDetails 타입의 최신 정보를 반환해야 합니다.
        UserDetails updatedPrincipal = service.loadUserByUsername(userEmail);
        
        // 2. 최신 정보로 새로운 Authentication 객체를 생성합니다.
        Authentication newAuth = new UsernamePasswordAuthenticationToken(
            updatedPrincipal, 
            authentication.getCredentials(),
            updatedPrincipal.getAuthorities());
        
        // 3. SecurityContext를 최신 정보로 갱신합니다.
        SecurityContextHolder.getContext().setAuthentication(newAuth);
        
        // 4. 모델에 갱신된 사용자 정보를 담아 JSP로 전달합니다.
        model.addAttribute("user", newAuth);
        int userId = loginUser.getUserId();
        //System.out.println(newAuth);
        List<Message> messageView = service.messageView(userId);
        
        model.addAttribute("messageView", messageView);
        
		return "/user/mypage";
	}
	
	@GetMapping("/admin")
	public String admin() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) auth.getPrincipal();
		//System.out.println(user);
		return "/user/admin";
	}
	
	@ResponseBody
	@PostMapping("/messageRead")
	public void messageRead(int messageNo) {
		service.messageRead(messageNo);
	}
	
	@ResponseBody
	@PostMapping("/message/delete")
	public String deleteMessage(int messageNo) {
		service.deleteMessage(messageNo);
		return "redirect: /user/mypage";
	}
}
