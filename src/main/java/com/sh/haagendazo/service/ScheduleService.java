package com.sh.haagendazo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.haagendazo.mapper.ScheduleMapper;
import com.sh.haagendazo.model.Paging;
import com.sh.haagendazo.model.Project;
import com.sh.haagendazo.model.Schedule;

@Service
public class ScheduleService implements ScheduleMapper{

	@Autowired
	private ScheduleMapper scheMapper;
	
	@Override
	public void insertSchedule(Schedule schedule) {
		scheMapper.insertSchedule(schedule);
	}
	
	@Override
	public void projectScheduleUpdate(Schedule schedule) {
		scheMapper.projectScheduleUpdate(schedule);
	}


	@Override
	public List<Project> projectCal(int userId, String role) {
		return scheMapper.projectCal(userId, role);
	}

	@Override
	public void scheduleDelete(int scheduleId) {
		scheMapper.scheduleDelete(scheduleId);
		
	}


	@Override
	public List<Schedule> scheduleCal(int userId, String role) {
		return scheMapper.scheduleCal(userId, role);
	}
	
	@Override
	public List<Project> todayUser(Paging paging) {
		return scheMapper.todayUser(paging);
	}

	@Override
	public int todayUserTotal(Paging paging) {
		return scheMapper.todayUserTotal(paging);
	}

	@Override
	public void scheduleMessage(Schedule schedule) {
		scheMapper.scheduleMessage(schedule);
	}

}
