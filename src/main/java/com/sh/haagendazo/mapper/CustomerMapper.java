package com.sh.haagendazo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sh.haagendazo.model.Customer;
import com.sh.haagendazo.model.Paging;

@Mapper
public interface CustomerMapper {
	
	List<Customer> allCustomer(Paging paging);
	int total(Paging paging);
	int totalLog(Paging paging);
	void updateCs(Customer vo);
	void updateLog(Customer vo);
	List<Customer> allLog(Paging paging);
	List<Customer> myLog(Paging paging);
	List<Customer> projectLog(int projectId);
	List<Customer> projectMyLog(@Param("projectId") int projectId, @Param("mUserId") int mUserId);
	void addCustomer(Customer vo);
	void delCustomer(Customer vo);
	List<Customer> showCustomer();
	List<Customer> showCustomerDaily();
	List<Customer> showCustomerMonthly();
	void addLog(Customer vo);
	void delLog(Customer vo);
	void claimMessage(Customer vo);
	List<Customer> claimMember(int projectId);
	
}
