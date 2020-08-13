package me.survivalking.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum; // 페이지
	private int amount; // 페이지당 게시글 수
	
	public Criteria() {
		this(1,20);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
