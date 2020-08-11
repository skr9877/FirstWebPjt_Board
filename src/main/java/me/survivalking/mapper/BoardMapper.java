package me.survivalking.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import me.survivalking.domain.BoardVO;

public interface BoardMapper {
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno); // 삭제 여부에 따라 1, 0
	
	public int update(BoardVO board); 
}
