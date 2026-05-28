package com.sh.haagendazo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.haagendazo.model.Board;
import com.sh.haagendazo.model.Paging;

@Mapper
public interface BoardMapper {
	void addBoard(Board vo);
	void deleteBoard(int boardNo);
	void updateBoard(Board vo);
	
	List<Board> showBoard(Paging paging);
	List<Board> showNotice(Paging paging);
	int total(Paging paging);
	Board selectBoard(int boardNo);
	List<Board> view(int boardNo);
}
