package com.sh.haagendazo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.haagendazo.mapper.DocumentMapper;
import com.sh.haagendazo.model.Project;

@Service
public class DocumentService implements DocumentMapper{

	@Autowired
	private DocumentMapper documentMapper;

	@Override
	public List<Project> docuView(int projectId) {
		return documentMapper.docuView(projectId);
	}

	@Override
	public void insertDocument(Project project) {
		documentMapper.insertDocument(project);		
	}

	@Override
	public void docuApproval(Project project) {
		documentMapper.docuApproval(project);
	}
}
