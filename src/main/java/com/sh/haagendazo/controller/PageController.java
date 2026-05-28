package com.sh.haagendazo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sh.haagendazo.model.Approval;
import com.sh.haagendazo.model.Board;
import com.sh.haagendazo.model.Chemical;
import com.sh.haagendazo.model.Customer;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.Project;
import com.sh.haagendazo.model.User;
import com.sh.haagendazo.service.ApprovalService;
import com.sh.haagendazo.service.BoardService;
import com.sh.haagendazo.service.ChemicalService;
import com.sh.haagendazo.service.CustomerService;
import com.sh.haagendazo.service.ProjectService;
import com.sh.haagendazo.service.ScheduleService;
import com.sh.haagendazo.service.UserService;

@Controller
public class PageController {
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private BoardService boardService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private ScheduleService scheService;
	
	@Autowired
	private ChemicalService chemicalService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ApprovalService approvalService;
	
	@GetMapping("/")
	public String getProjectDashboard(Model model, Paging paging) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loginUser = (User) auth.getPrincipal(); // User 엔티티 그대로 가져오기
        int userId = loginUser.getUserId();
        paging.setUserId(userId);
        paging.setRole(loginUser.getRole());
        
		paging.setOffset(0);
		paging.setLimit(5);
		
		List<Board> list = boardService.showNotice(paging);
		model.addAttribute("list", list);
		
		List<Project> today = scheService.todayUser(paging);
		model.addAttribute("today", today);
		
		List<Customer> allLog = customerService.allLog(paging);
	    model.addAttribute("allLog", allLog);
	    model.addAttribute("paging", new Paging(paging.getPage(), customerService.totalLog(paging)));
		
		List<Customer> log = customerService.myLog(paging);
	    model.addAttribute("log", log);

	    int countPlan = projectService.status("계획중");
		int countIng = projectService.status("진행중");
		int countDone = projectService.status("완료");
		
		paging.setStatus("계획중");
		int countMyPlan = projectService.userStatus(paging);
		paging.setStatus("진행중");
		int countMyIng = projectService.userStatus(paging);
		paging.setStatus("완료");
		int countMyDone = projectService.userStatus(paging);
		
		model.addAttribute("countPlan",countPlan);
		model.addAttribute("countIng",countIng);
		model.addAttribute("countDone",countDone);
		
		model.addAttribute("countMyPlan",countMyPlan);
		model.addAttribute("countMyIng",countMyIng);
		model.addAttribute("countMyDone",countMyDone);
		
	    return "/index";
	}
	
	@GetMapping("/statistics")
	public String goStatistics(Model model, Paging paging) {
		List<Customer> customerD = customerService.showCustomerDaily();
		List<Customer> customerM = customerService.showCustomerMonthly();
		model.addAttribute("customerD", customerD);
		model.addAttribute("customerM", customerM);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loginUser = (User) auth.getPrincipal(); // User 엔티티 그대로 가져오기
        int userId = loginUser.getUserId();
        paging.setUserId(userId);
        paging.setRole(loginUser.getRole());
        
		paging.setOffset(0);
		paging.setLimit(5);
		
		List<Board> list = boardService.showNotice(paging);
		model.addAttribute("list", list);
		
		List<Project> today = scheService.todayUser(paging);
		model.addAttribute("today", today);
		
		List<Customer> allLog = customerService.allLog(paging);
	    model.addAttribute("allLog", allLog);
	    model.addAttribute("paging", new Paging(paging.getPage(), customerService.totalLog(paging)));
	    
		List<Customer> log = customerService.myLog(paging);
	    model.addAttribute("log", log);

	    int countPlan = projectService.status("계획중");
		int countIng = projectService.status("진행중");
		int countDone = projectService.status("완료");
		
		paging.setStatus("계획중");
		int countMyPlan = projectService.userStatus(paging);
		paging.setStatus("진행중");
		int countMyIng = projectService.userStatus(paging);
		paging.setStatus("완료");
		int countMyDone = projectService.userStatus(paging);
		
		model.addAttribute("countPlan",countPlan);
		model.addAttribute("countIng",countIng);
		model.addAttribute("countDone",countDone);
		
		model.addAttribute("countMyPlan",countMyPlan);
		model.addAttribute("countMyIng",countMyIng);
		model.addAttribute("countMyDone",countMyDone);
		
		return "/statistics";
	}
	
	@ResponseBody
    @GetMapping("/chemical/chart-data")
    public List<Chemical> getChemicalChartData() {
        return chemicalService.getChemicalChartData();
    }
	
	@ResponseBody
    @GetMapping("/approval/chart-data")
    public List<Approval> getApprovalChartData(@AuthenticationPrincipal User user) {
        return approvalService.getApprovalStatusCounts(user);
    }
	
	@GetMapping("/deptChart/data")
	@ResponseBody
	public List<Map<String, Object>> getDeptCounts() {
	    return userService.getDeptCounts(); // dept_id, dept_name, cnt
	}
	
	@GetMapping("/message")
	public String sendMessage() {
		return "user/message";
	}
	
}
