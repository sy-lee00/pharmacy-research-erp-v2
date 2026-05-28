package com.sh.haagendazo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sh.haagendazo.model.Approval;
import com.sh.haagendazo.model.Chemical;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.Project;
import com.sh.haagendazo.model.Storage;
import com.sh.haagendazo.model.User;

@Mapper
public interface ChemicalMapper {
	
	List<Chemical> viewChemical(@Param("paging") Paging paging);
	int total(@Param("paging") Paging paging);
	void modifyChemical(Chemical vo);
	void addChemical(Chemical chemical);
	void deleteChemical(List<Integer> chemList);
	String viewStorageName(int storageId);
	List<String> viewAllStorageName();
	int selectStorageId(String storageName);
	
	List<Storage> viewStorage();
	List<Chemical> viewStockChem(int chemicalId);
	
	List<Project> projectListOfUser(User user);
	List<Project> chemicalListOfProject(int projectId);
	Project stockOfchemical(int chemicalId);
	void requestUsageChemical(Approval vo);
	void approvalRequestUsageChemical(Approval vo);
	
	List<Chemical> getChemicalChartData();
}
