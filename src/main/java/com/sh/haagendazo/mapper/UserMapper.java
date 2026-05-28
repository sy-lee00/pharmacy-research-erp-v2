package com.sh.haagendazo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sh.haagendazo.model.Message;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.User;

@Mapper
public interface UserMapper {
	void register(User vo);
	User login(String email);
	List<User> selectAll(Paging paging);
	List<User> search(User vo, Paging paging);
	void updateUser(User vo);
	void deleteUser(User vo);
	int total(Paging paging);
	int count(String role);
	List<User> userGrade();
	List<User> userDept();
	List<User> showCsdept();
	List<User> showManager(Paging paging);
	int countSchedule(int userId);
	int countApproval(int userId);
	int countReject(int userId);
	int countClaim(int userId);
	List<Message> messageView(int userId);
	void messageRead(int messageNo);
	List<Map<String, Object>> getDeptCounts();
	void deleteMessage(int messageNo);
}
