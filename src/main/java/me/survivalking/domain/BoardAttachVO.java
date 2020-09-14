package me.survivalking.domain;

import lombok.Data;

// 파일 CRUD 관련 VO
@Data
public class BoardAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private Long bno;
}
