package me.survivalking.service;

import java.util.List;

import me.survivalking.domain.BoardVO;

public interface BoardService {
	public void register(BoardVO board); // c
	
	public BoardVO get(Long bno); // r
	
	public boolean modify(BoardVO board); // u
	
	public boolean remove(Long bno); // d
	
	public List<BoardVO> getList();
	
}
