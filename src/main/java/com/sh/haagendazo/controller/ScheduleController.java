package com.sh.haagendazo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.Project;
import com.sh.haagendazo.model.Schedule;
import com.sh.haagendazo.model.User;
import com.sh.haagendazo.service.DetailService;
import com.sh.haagendazo.service.ScheduleService;

@Controller
public class ScheduleController {

	@Autowired
	private ScheduleService scheService;
	
	@Autowired
	private DetailService detailService;
	
	@PostMapping("/project/scheAdd")
	public String scheAdd(Schedule schedule) {
		
		Project project = detailService.detail(schedule.getProjectId());
		scheService.insertSchedule(schedule);
		scheService.scheduleMessage(schedule);
		return "redirect:/project/detail?projectId=" + schedule.getProjectId() + "#schedule";
	}
	
	@ResponseBody
	@PostMapping("/project/proSche")
	public void proSche(Schedule schedule) {
		scheService.projectScheduleUpdate(schedule);
	}
	
	@ResponseBody
	@PostMapping("/schedule/proScheDel")
	public void scheduleDelete(Schedule schedule) {
		int scheduleId = schedule.getScheduleId();
		scheService.scheduleDelete(scheduleId);
	}
	
    @GetMapping("/schedule")
    public String schedulePage() {
        return "/schedule/schedule"; 
    }

    @GetMapping("/schedule/event")
    @ResponseBody
    public List<Map<String, Object>> getCalendarEvents() {
        List<Map<String, Object>> events = new ArrayList<>();

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loginUser = (User) auth.getPrincipal();
        int userId = loginUser.getUserId();

        List<Project> projects = scheService.projectCal(userId, loginUser.getRole());
        for(Project p : projects) {
            Random rand = new Random(p.getProjectId());
            int r = rand.nextInt(100);
            int g = rand.nextInt(100);
            int b = rand.nextInt(100);
            int a = rand.nextInt(40) + 50;

            Map<String, Object> event = new HashMap<>();
            event.put("title", "프로젝트 명 : "+ p.getProjectName());
            event.put("start", p.getStartDate());
            event.put("end", p.getEndDate());
            event.put("backgroundColor", "rgba(" + r + "," + g + "," + b + ", 0." + a + ")");
            event.put("textColor", "#fff");
            event.put("type", "project");
            event.put("projectId", p.getProjectId());
            events.add(event);
        }

        List<Schedule> schedules = scheService.scheduleCal(userId, loginUser.getRole());
        for(Schedule s : schedules) {
            Random rand = new Random(s.getScheduleId()); 
              int a = rand.nextInt(50) + 10;

            Map<String, Object> event = new HashMap<>();
            event.put("title", "일정 명 : "+ s.getTitle());
            event.put("start", s.getStartDatetime());
            event.put("end", s.getEndDatetime());
            event.put("backgroundColor", "rgba(10, 25, 151, 0." + a + ")");
            event.put("textColor", "#000"); 
            event.put("type", "schedule");
            event.put("projectId", s.getProjectId());
            events.add(event);
        }

        return events;
    }
    
    @GetMapping("/today/my")
    public String today(Model model, Paging paging) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User loginUser = (User) auth.getPrincipal(); 
        int userId = loginUser.getUserId();
        
        paging.setUserId(userId);
        paging.setRole(loginUser.getRole());
        
        List<Project> todayUser = scheService.todayUser(paging);
        model.addAttribute("todayUser", todayUser);
        model.addAttribute("paging", new Paging(paging.getPage(), scheService.todayUserTotal(paging)));
        return "/schedule/today";
    }
    
}
