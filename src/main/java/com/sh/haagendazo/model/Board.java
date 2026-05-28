package com.sh.haagendazo.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Board {

	private int boardNo;
	private String title;
	private String content;
	private String url;
	private String type;
	
	private String uploaderType; // User or Customer
	private int uploadedBy;
	private int userId;
	private int CustomerId;
	private String name;
	private String uploaderName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date uploadedAt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedAt;
	
	private Date formatDate;
	private MultipartFile file;
}
