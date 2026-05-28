package com.sh.haagendazo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Storage {
	
	private int storageId;
	private String storageName;
	private String location;
	private String type;
	private String description;
	
	private String stock;

}
