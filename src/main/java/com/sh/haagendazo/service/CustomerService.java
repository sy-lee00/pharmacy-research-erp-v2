package com.sh.haagendazo.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.haagendazo.mapper.CustomerMapper;
import com.sh.haagendazo.model.Customer;
import com.sh.haagendazo.model.Paging;

@Service
public class CustomerService implements CustomerMapper {
	
	@Autowired
	private CustomerMapper mapper;

	@Override
	public List<Customer> allCustomer(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage()-1));
		List<Customer> list = mapper.allCustomer(paging);
		return list;
	}

	@Override
	public int total(Paging paging) {
		return mapper.total(paging);
	}
	
	@Override
	public int totalLog(Paging paging) {
		return mapper.totalLog(paging);
	}

	@Override
	public void updateCs(Customer vo) {
		mapper.updateCs(vo);
	}

	@Override
	public void updateLog(Customer vo) {
		mapper.updateLog(vo);		
	}

	@Override
	public List<Customer> allLog(Paging paging) {
		paging.setOffset(paging.getLimit() * (paging.getPage()-1));
		List<Customer> list = mapper.allLog(paging);
		return list;
	}

	@Override
	public List<Customer> myLog(Paging paging) {
		return mapper.myLog(paging);
	}

	@Override
	public void addCustomer(Customer vo) {
		mapper.addCustomer(vo);
	}
	
	@Override
	public void delCustomer(Customer vo) {
		mapper.delCustomer(vo);
	}

	@Override
	public void addLog(Customer vo) {
		mapper.addLog(vo);
	}

	@Override
	public List<Customer> showCustomer() {
		return mapper.showCustomer();
	}
	
	@Override
	public List<Customer> showCustomerDaily() {
		return mapper.showCustomerDaily();
	}

	@Override
	public List<Customer> showCustomerMonthly() {
		return mapper.showCustomerMonthly();
	}
	
	@Override
	public List<Customer> projectLog(int projectId) {
		List<Customer> list = mapper.projectLog(projectId);
		return list;
	}
	
	@Override
	public List<Customer> projectMyLog(@Param("projectId") int projectId, @Param("mUserId") int mUserId) {
		List<Customer> myList = mapper.projectMyLog(projectId, mUserId);
		return myList;
	}

	@Override
	public void delLog(Customer vo) {
		mapper.delLog(vo);
	}

	@Override
	public void claimMessage(Customer vo) {
		mapper.claimMessage(vo);
	}

	@Override
	public List<Customer> claimMember(int projectId) {
		return mapper.claimMember(projectId);
	}

}
