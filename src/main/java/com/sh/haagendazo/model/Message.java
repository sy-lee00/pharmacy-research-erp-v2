package com.sh.haagendazo.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message {
	private int messageNo;
	private String title;
	private String content;
	private String url;
	private String type;
	private int targetId;
	private int senderId;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date sentAt;
	private int receiverId;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date receivedAt;
	private int isRead;
}
