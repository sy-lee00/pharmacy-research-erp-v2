package com.sh.haagendazo.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sh.haagendazo.model.Approval;
import com.sh.haagendazo.model.Customer;
import com.sh.haagendazo.model.Project;
import com.sh.haagendazo.model.User;
import com.sh.haagendazo.service.CustomerService;
import com.sh.haagendazo.service.DetailService;
import com.sh.haagendazo.service.DocumentService;
import com.sh.haagendazo.service.ProjectChemicalService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class DetailController {

	@Autowired
	private DetailService detailService;
	
	@Autowired
	private ProjectChemicalService pcService;
	
	@Autowired
	private DocumentService docuService;

	@Autowired
	private CustomerService customerService;
	
	
	private String path = "D:\\team-project\\src\\main\\webapp\\resource\\upload\\";
	
	private String fileUpload(MultipartFile file) {
	    UUID uuid = UUID.randomUUID();
	    String fileName = uuid.toString() + "_" + file.getOriginalFilename();

	    File folder = new File(path);
	    if(!folder.exists()) {
	        folder.mkdirs();
	    }

	    File copyFile = new File(path + fileName);
	    try {
	        file.transferTo(copyFile);
	    } catch (IllegalStateException | IOException e) {
	        e.printStackTrace();
	    }
	    return fileName;
	}

	
	
	@GetMapping("/project/detail")
	public String detail(Model model, @Param("projectId") int projectId) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User loginUser = (User) auth.getPrincipal();
		int mUserId = loginUser.getUserId();
		
		
		Project project = detailService.detail(projectId);
		model.addAttribute("project", project);
		
		List<Project> projectMember = detailService.projectMember(projectId);
		model.addAttribute("projectMember", projectMember);
		
		List<Project> projectUser = detailService.userView();
		model.addAttribute("projectUser", projectUser);
		
		List<Project> projectChemical = pcService.projectChemicalList(projectId);
		model.addAttribute("projectChemical", projectChemical);
		
		List<Project> chemicalList = pcService.chemicalList();
		model.addAttribute("chemicalList", chemicalList); 
		
		List<Project> projectUserList = detailService.projectUserList(projectId);
		model.addAttribute("projectUserList", projectUserList); 
		
		List<Project> memberSchedule = detailService.memberSchedule(projectId);
		model.addAttribute("memberSchedule", memberSchedule);
		
		List<Project> docuView = docuService.docuView(projectId);
		model.addAttribute("docuView", docuView);
		
		List<Customer> log = customerService.projectLog(projectId);
	    model.addAttribute("log", log);
	    
	    List<Customer> member = customerService.claimMember(projectId);
	    model.addAttribute("member", member);

	    List<Customer> myLog = customerService.projectMyLog(projectId, mUserId);
	    model.addAttribute("myLog", myLog);
		
		return "/project/detail";
	}
	
	@PostMapping("/project/memberInsert")
	public String memberInsert(Project project) {
		detailService.pmUpdate(project);
		detailService.memberInsert(project);
		return "redirect:/project/detail?projectId=" + project.getProjectId() + "#member";
	}
	
	@PostMapping("/project/memberDelete")
	public String delelte(@RequestParam(name="idList", required = false) List<String> idList, Project project) {
		if(idList != null) {
			detailService.memberDelete(idList);
		}
		return "redirect:/project/detail?projectId=" + project.getProjectId() + "#member";
	}
	
	@GetMapping("/project/delete")
	public String projectDelete(int projectId) {
		detailService.projectDelete(projectId);
		return "redirect:/project/list";
	}
	
	@PostMapping("/project/update")
	public String projectUpdate(Project project) {
		detailService.projectUpdate(project);
		return "redirect:/project/detail?projectId=" + project.getProjectId();
	}
	
	@PostMapping("/project/pcAdd")
	public String pcAdd(Approval vo) {
		if(vo.getChemicalId() != 0 && vo.getUserId() != 0) {
			pcService.pcAdd(vo);
		}
		return "redirect:/project/detail?projectId=" + vo.getProjectId() + "#chemical";
	}
	
	@PostMapping("/project/claimMessage")
	public String claimMessage(Customer vo) {
		customerService.claimMessage(vo);
		return "redirect:/project/detail?projectId=" + vo.getProjectId() + "#claim";
	}
	
	
	@PostMapping("/document/insert")
	public String insertDocument(Project project,
	                             @RequestParam("file") MultipartFile file) {

		
	    if(file != null && !file.isEmpty()) {
	        String fileName = fileUpload(file);
	        project.setFileName(fileName);
	    }

	    project.setFilePath(path);

	    docuService.insertDocument(project);
	    docuService.docuApproval(project);
	    
	    
	    return "redirect:/project/detail?projectId=" + project.getDocumentProjectId() + "#document";
	}
	
	@GetMapping("/document/download")
	public void fileDownload(@RequestParam String fileName, HttpServletResponse response) {
		
	    File file = new File(path + fileName);
	    if(file.exists()) {
	        response.setContentType("application/octet-stream");
	        try {
	            String originalName = fileName.substring(fileName.indexOf("_") + 1);
	            response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(originalName, "UTF-8"));

	            try (FileInputStream fis = new FileInputStream(file);
	                 OutputStream os = response.getOutputStream()) {
	                byte[] buffer = new byte[1024];
	                int b;
	                while((b = fis.read(buffer)) != -1) {
	                    os.write(buffer, 0, b);
	                }
	            }
	        } catch(IOException e) {
	            e.printStackTrace();
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        }
	    } else {
	        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	    }
	}
}
