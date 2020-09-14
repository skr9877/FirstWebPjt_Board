package me.survivalking.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import me.survivalking.domain.BoardVO;
import me.survivalking.domain.Criteria;

public interface BoardMapper {
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria criteria);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno); // 삭제 여부에 따라 1, 0
	
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
