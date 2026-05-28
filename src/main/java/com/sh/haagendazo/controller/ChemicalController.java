package com.sh.haagendazo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sh.haagendazo.model.Chemical;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.Project;
import com.sh.haagendazo.model.Storage;
import com.sh.haagendazo.model.User;
import com.sh.haagendazo.service.ChemicalService;

@Controller
public class ChemicalController {
	
	@Autowired
	private ChemicalService service;
	
	@GetMapping("/chemical/list")
	public String list(@AuthenticationPrincipal User user, Paging paging, Model model) {
		List<Project> projectsOfUser = service.projectListOfUser(user);
		model.addAttribute("projectsOfUser", projectsOfUser);
		
		List<Chemical> list = service.viewChemical(paging);
		model.addAttribute("list", list);
		model.addAttribute("StorageNameList", service.viewAllStorageName());
		model.addAttribute("paging", new Paging(paging.getPage(), service.total(paging)));
		return "/chemical/list";
	}
	
	@PostMapping("/chemical/manage")
	public String manage(Chemical vo, String storageName, String type) {
		if(type != null && type.equals("modify")) {
			service.modifyChemical(vo);
		} else if(type != null && storageName != null && type.equals("add")) {
			vo.setStorageId(service.selectStorageId(storageName));
			service.addChemical(vo);
		}
		return "redirect:/chemical/list";
	}
	
	@PostMapping("/chemical/delete")
	public String delete(@RequestParam(name="chemList", required = false) List<Integer> chemList) {
		if(chemList != null) service.deleteChemical(chemList);
		return "redirect:/chemical/list";
	}
	
	@ResponseBody
	@GetMapping("/chemical/stock")
	public List<Storage> storage() {
		return service.viewStorage();
	}; 
	
	@GetMapping("/chemical/request")
	public String request(@AuthenticationPrincipal User user, Project vo, Model model) {
		List<Project> projectsOfUser = service.projectListOfUser(user);
		model.addAttribute("projectsOfUser", projectsOfUser);
		return "/chemical/request";
	}
	
	@ResponseBody
	@GetMapping("/getChemicals")
	public List<Project> getChemicals(int projectId) {
		return service.chemicalListOfProject(projectId);
	}
	
	@ResponseBody
	@GetMapping("/getStockOfChemical")
	public Project getStockOfChemical(int chemicalId) {
		return service.stockOfchemical(chemicalId);
	}

}
