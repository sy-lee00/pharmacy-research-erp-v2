package com.sh.haagendazo.model;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Chemical {
	
	private String chemicalId;
	private String chemicalName;
	private String casNo;
	private String storageUnit;
	private int storageId;
	private int stockQty;
	private int thresholdQty;
	private LocalDate createdAt;
	
	private String storageName;
	private String storageLocation;
	
	private int usedQty;
	
}