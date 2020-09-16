package me.survivalking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import me.survivalking.domain.BoardAttachVO;
import me.survivalking.domain.BoardVO;
import me.survivalking.domain.Criteria;
import me.survivalking.mapper.BoardAttachMapper;
import me.survivalking.mapper.BoardMapper;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	@Setter(onMethod_ = {@Autowired})
	private BoardMapper boardMapper;
	
	@Setter(onMethod_= {@Autowired})
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register ....." + board);
		
		boardMapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() == 0) return;
		
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
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

	@Override
	public int getTotalCount(Criteria cri) {
		
		return boardMapper.getTotalCount(cri);
	}
	
	// 파일 Service Impl
	@Override
	public List<BoardAttachVO> getattachList(Long bno) {
		
		return attachMapper.findByBno(bno);
	}
}
