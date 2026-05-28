package com.sh.haagendazo.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.haagendazo.mapper.BoardMapper;
import com.sh.haagendazo.model.Board;
import com.sh.haagendazo.model.Paging;

@Service
public class BoardService {

	@Autowired
	private BoardMapper mapper;

	public void addBoard(Board vo) {
		mapper.addBoard(vo);
	}

	public Board selectBoard(int boardNo) {
		return mapper.selectBoard(boardNo);
	}

	public void deleteBoard(int boardNo) {
		mapper.deleteBoard(boardNo);
	}

	public List<Board> view(int boardNo) {
		return mapper.view(boardNo);
	}
	
	public void updateBoard(Board vo) {
		mapper.updateBoard(vo);
	}

	public List<Board> showBoard(Paging paging) {

		paging.setOffset(paging.getLimit() * (paging.getPage()-1));
		List<Board> list = mapper.showBoard(paging);
		List<Board> dtoList = new ArrayList<Board>();
		for(Board b : list) {
			Board vo = new Board();
			vo.setBoardNo(b.getBoardNo());
			vo.setType(b.getType());
			vo.setTitle(b.getTitle());
			vo.setContent(b.getContent());
			//Date formatDate = Date.from((b.getCreatedAt()).atZone(ZoneId.systemDefault()).toInstant());
			vo.setName(b.getName());
			vo.setUploaderType(b.getUploaderType());
			vo.setUploadedBy(b.getUploadedBy());
			vo.setUploaderName(b.getUploaderName());
			vo.setUploadedAt(b.getUploadedAt());
			vo.setUpdatedAt(b.getUpdatedAt());
			dtoList.add(vo);
		}
		return dtoList;
	}
	
	public List<Board> showNotice(Paging paging) {
		return mapper.showNotice(paging);
	}
	
	public int total(Paging paging) {
		return mapper.total(paging);
	}
	
}
