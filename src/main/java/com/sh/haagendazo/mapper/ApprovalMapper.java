package com.sh.haagendazo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sh.haagendazo.model.Approval;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.User;

@Mapper
public interface ApprovalMapper {
	
	List<Approval> allAprovalsList(@Param("paging") Paging paging);
	int total(@Param("paging") Paging paging);
	void processApproval(List<Approval> vo);
	void additionApprovedChemical(List<Approval> list);
	void approvedChemical(List<Integer> list);
	void subtractStockOfChemical(List<Approval> list);
	void approvalMessage(Approval vo);
	List<Approval> getApprovalStatusCounts(User user);
}
