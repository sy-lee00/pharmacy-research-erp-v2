package com.sh.haagendazo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.haagendazo.model.Project;

@Mapper
public interface DetailMapper {
	
	Project detail(int projectId);
	
	List<Project> projectMember(int projectId);
	List<Project> userView();
	List<Project> projectUserList(int projectId);
	
	void projectUpdate(Project project);
	void projectDelete(int projectId);
	void memberInsert(Project project);
	void pmUpdate(Project project);
	void memberDelete(List<String> idList);
	List<Project> memberSchedule(int projectId);
}
