package com.sh.haagendazo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.sh.haagendazo.model.Customer;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.Project;
import com.sh.haagendazo.model.User;
import com.sh.haagendazo.service.CustomerService;
import com.sh.haagendazo.service.ProjectService;
import com.sh.haagendazo.service.UserService;

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProjectService projectService;
	
	@GetMapping("/customer")
	public String customer(Model model, Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));

	    List<Customer> list = customerService.allCustomer(paging);
	    model.addAttribute("list", list);
	    model.addAttribute("paging", new Paging(paging.getPage(), customerService.total(paging)));
	    
	    List<User> userList = userService.showCsdept();
        model.addAttribute("userList", userList);
        
	    return "/customer/list";
	}
	
	@PostMapping("/customer/updateList")
	public String updateCs(Customer vo) {
		customerService.updateCs(vo);
		return "redirect:/customer";
	}
	
	@PostMapping("/customer/updateLog")
	public String updateLog(Customer vo) {
		customerService.updateLog(vo);
		return "redirect:/customer/log";
	}
	
	@GetMapping("/customer/log")
	public String allLog(Model model, Paging paging) {
		
		List<Customer> list = customerService.showCustomer();
		model.addAttribute("list", list);
		
	    List<Customer> log = customerService.allLog(paging);
	    model.addAttribute("log", log);
	    model.addAttribute("paging", new Paging(paging.getPage(), customerService.totalLog(paging)));
	    
	    List<User> userList = userService.showCsdept();
        model.addAttribute("userList", userList);
        
        List<Project> projectList = projectService.showLog();
        model.addAttribute("projectList", projectList);
        
	    return "/customer/log";
	}
	
	@PostMapping("/customer/addCustomer")
	public String addCustomer(Customer vo) {
		customerService.addCustomer(vo);
		return "redirect:/customer";
	}
	
	@GetMapping("/customer/delCustomer")
	public String delCustomer(Customer vo) {
		customerService.delCustomer(vo);
		return "redirect:/customer";
	}
	
	@PostMapping("/customer/addLog")
	public String addLog(Customer vo) {
		customerService.addLog(vo);
		return "redirect:/customer/log";
	}
	
	@GetMapping("/customer/delLog")
	public String delLog(Customer vo) {
		customerService.delLog(vo);
		return "redirect:/customer/log";
	}
}
