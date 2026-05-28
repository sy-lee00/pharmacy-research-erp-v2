package com.sh.haagendazo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.haagendazo.mapper.ProjectChemicalMapper;
import com.sh.haagendazo.model.Approval;
import com.sh.haagendazo.model.Project;

@Service
public class ProjectChemicalService {

	@Autowired
	private ProjectChemicalMapper projectChemicalMapper;
	
	public List<Project> projectChemicalList(int projectId) {
		return projectChemicalMapper.projectChemicalList(projectId);
	}
	
	public List<Project> chemicalList(){
		return projectChemicalMapper.chemicalList();
	}
	
	@Transactional
	public void pcAdd(Approval vo) {
		projectChemicalMapper.additionNotApprovedChemical(vo);
		projectChemicalMapper.pcAdd(vo);
	}

}
