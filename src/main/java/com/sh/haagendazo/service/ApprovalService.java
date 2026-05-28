package com.sh.haagendazo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.haagendazo.mapper.ApprovalMapper;
import com.sh.haagendazo.mapper.ChemicalMapper;
import com.sh.haagendazo.model.Approval;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.User;

@Service
public class ApprovalService {

    private final ChemicalMapper chemicalMapper;
	
	@Autowired
	private ApprovalMapper mapper;
	
    public ApprovalService(ChemicalMapper chemicalMapper) {
        this.chemicalMapper = chemicalMapper;
    }

	public List<Approval> allAprovalsList(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		return mapper.allAprovalsList(paging);
	}

	public int total(Paging paging) {
		return mapper.total(paging);
	}
	
	public void processApproval(List<Approval> vo) {
		mapper.processApproval(vo);
	}
	public void approvalMessage(Approval vo) {
		mapper.approvalMessage(vo);
	}
	@Transactional
	public void requestApproval(User user, Approval vo) {
		vo.setUserId(user.getUserId());
		chemicalMapper.requestUsageChemical(vo);
		chemicalMapper.approvalRequestUsageChemical(vo);
	}
	
	@Transactional
	public void approvedChemicalAddition(List<Integer> approvalIdList, 
											List<Integer> targetIdList,List<Integer> reqbyIdList, User user, Approval vo) {
		List<Approval> approvalList = new ArrayList<>();
		for(int i = 0; i < approvalIdList.size(); i++) {
			Approval approval = new Approval(); 
			
			approval.setApprovalId(approvalIdList.get(i));
			approval.setRequestedBy(reqbyIdList.get(i));
			approval.setApprovedBy(user.getUserId());
			approval.setStatus(vo.getStatus());
			approval.setComment(vo.getComment());
			approvalList.add(approval);
			
			vo.setApprovalId(approval.getApprovalId());
			vo.setRequestedBy(approval.getRequestedBy());
			mapper.approvalMessage(vo);
		}
		mapper.processApproval(approvalList);
		if(vo.getStatus().equals("승인")) {
			mapper.approvedChemical(targetIdList);
		}
	}
	
	@Transactional
	public void approvedChemicalUsage(List<Integer> approvalIdList, List<Integer> chemicalIdList, 
										List<Integer> targetIdList, List<Integer> usedQtyList,List<Integer> reqbyIdList, User user, Approval vo) {
		List<Approval> approvalList = new ArrayList<>();
		List<Approval> usedChemicalList = new ArrayList<>();
		for(int i = 0; i < approvalIdList.size(); i++) {
			Approval approval1 = new Approval(); 
			
			approval1.setApprovalId(approvalIdList.get(i));
			approval1.setRequestedBy(reqbyIdList.get(i));
			approval1.setApprovedBy(user.getUserId());
			approval1.setStatus(vo.getStatus());
			approval1.setComment(vo.getComment());
			approvalList.add(approval1);
			vo.setApprovalId(approval1.getApprovalId());
			vo.setRequestedBy(approval1.getRequestedBy());
			
			Approval approval2 = new Approval(); 
			mapper.approvalMessage(vo);
			
			approval2.setChemicalId(chemicalIdList.get(i));
			approval2.setUsedQty(usedQtyList.get(i));
			usedChemicalList.add(approval2);
			
		}
		mapper.processApproval(approvalList); // 시약 사용 승인
		if(vo.getStatus().equals("승인")) {
			mapper.approvedChemical(targetIdList); // 사용 요청된 시약 project_chemical에 TRUE
			mapper.subtractStockOfChemical(usedChemicalList); // 승인되어 사용한 시약 만큼 재고 차감
		}
	}
	
	public List<Approval> getApprovalStatusCounts(User user) {
		return mapper.getApprovalStatusCounts(user);
	}
}
