package com.sh.haagendazo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.haagendazo.model.Project;

@Mapper
public interface DocumentMapper {

	List<Project> docuView (int projectId);
	void insertDocument(Project project);
	void docuApproval(Project project);
}
