package com.sh.haagendazo.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.haagendazo.mapper.ProjectMapper;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.Project;

@Service
public class ProjectService {

	@Autowired
	private ProjectMapper projectMapper;
	
	
	public List<Project> selectAll(Paging paging){
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		return projectMapper.selectAll(paging);
	}
	
	public int total(@Param("paging") Paging paging) {
		return projectMapper.total(paging);
	}
	
	public List<Project> selectAll(String select, String projectSearch){
		return projectMapper.selectAll(select, projectSearch);
	}
	
	public List<Project> searchBar(Paging paging){
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		return projectMapper.searchBar(paging);
	}
	
	public int searchBarTotal(@Param("paging") Paging paging) {
		return projectMapper.searchBarTotal(paging);
	}
	public int status(String status) {
		return projectMapper.status(status);
	}
	
	public int userStatus(Paging paging) {
	    return projectMapper.userStatus(paging);
	}
	
	
	public void projectSelectDelete(List<String> idList) {
		projectMapper.projectSelectDelete(idList);
	}
	
	
	public void projectInsert(Project project) {
		projectMapper.projectInsert(project);
	}

	public boolean duplicate(String projectCode) {
		boolean check = projectMapper.duplicate(projectCode) == 0;
		return check;
	}
	
	public List<Project> userProject(Paging paging){
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		return projectMapper.userProject(paging);
	}
	
	public List<Project> showLog(){
		return projectMapper.showLog();
	}

	public int userProjectTotal(Paging paging) {
		return projectMapper.userProjectTotal(paging);
	}
}
