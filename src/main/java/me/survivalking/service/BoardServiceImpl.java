package me.survivalking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import me.survivalking.domain.BoardVO;
import me.survivalking.domain.Criteria;
import me.survivalking.mapper.BoardMapper;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardMapper boardMapper;

	@Override
	public void register(BoardVO board) {
		log.info("register ....." + board);
		
		boardMapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get..." + bno);
			
		return boardMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify..." + board);
		
		return (boardMapper.update(board) == 1);
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove..." + bno);
		
		return (boardMapper.delete(bno) == 1);
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList...");


		return boardMapper.getList();
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria criteria) {
		log.info("getListWithPaging");
		
		return boardMapper.getListWithPaging(criteria);
	}
}
