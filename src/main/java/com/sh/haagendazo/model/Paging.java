package com.sh.haagendazo.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class Paging {

	private int offset = 0; 
	private int limit = 10; 
	
	private int page = 1; 
	private int pageSize = 10; 
	private int endPage = this.pageSize; 
	private int startPage = this.endPage - this.pageSize + 1; 
	
	
	private boolean prev;
	private boolean next;
	
	private int total; 
	
	public Paging(int page, int total) {
		this.page = page;
		this.total = total;
		this.endPage = (int)(Math.ceil((double)page / this.pageSize)) * this.pageSize;
		this.startPage = this.endPage - this.pageSize + 1;
		
		int lastPage = (int) Math.ceil((double)total / this.limit);
		
		if(lastPage < this.endPage) {
			this.endPage = lastPage;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < lastPage;
	}
	
	private String search; 
	private String select; 
	private String keyword;
	
	private String status;
	
	private String name;
	private String email;
	private String password;
	private String gradeName;
	private String deptName;
	private Date createdAt;
	private int deptId;
	private int gradeId;
	private int uploadedBy;
	private int userId;
	private int managerId;
	
	private String role;
	
	private String orderBy;
	private String orderDirection; 
	
	private String filterApprovalType;
	private String filterApprovalContent;
	private String filterStatus;
	
	private int storageId;
	private MultipartFile file;
	private int boardNo;
	private String title;
	private String content;
	private String url;
	
}