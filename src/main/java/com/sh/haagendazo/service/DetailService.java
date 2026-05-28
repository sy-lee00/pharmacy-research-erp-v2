package com.sh.haagendazo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.haagendazo.mapper.DetailMapper;
import com.sh.haagendazo.model.Project;

@Service
public class DetailService {

	@Autowired
	private DetailMapper detailMapper;
	
	public Project detail(int projectId) {
		return detailMapper.detail(projectId);
	}
	
	public void projectDelete(int projectId) {
		detailMapper.projectDelete(projectId);
	}
	
	public void projectUpdate(Project project) {
		detailMapper.projectUpdate(project);
	}
	
	public List<Project> projectMember (int projectId){
		return detailMapper.projectMember(projectId);
	}
	
	public List<Project> userView (){
		return detailMapper.userView();
	}
	
	public List<Project> projectUserList(int projectId){
		return detailMapper.projectUserList(projectId);
	}
	
	public void memberInsert(Project project) {
		detailMapper.memberInsert(project);
	}
	
	public void memberDelete(List<String> idList) {
		detailMapper.memberDelete(idList);
	}
	
	public void pmUpdate(Project project) {
		project.setUserId(project.getMemberUserId());
		detailMapper.pmUpdate(project);
	}
	
	
	public List<Project> memberSchedule(int projectId){
		return detailMapper.memberSchedule(projectId);
	}
}
