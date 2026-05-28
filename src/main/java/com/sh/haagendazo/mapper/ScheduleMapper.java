package com.sh.haagendazo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.Project;
import com.sh.haagendazo.model.Schedule;

@Mapper
public interface ScheduleMapper {

	void insertSchedule(Schedule schedule);
	void projectScheduleUpdate(Schedule schedule);
	void scheduleDelete(int scheduleId);
	List<Project> projectCal(int userId, String role);
	List<Schedule> scheduleCal(int userId, String role);
	List<Project> todayUser(Paging paging);
	int todayUserTotal(Paging paging);
	void scheduleMessage(Schedule schedule);
}
