package me.survivalking.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import me.survivalking.domain.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {
	@Setter(onMethod_ = {@Autowired})
	private BoardMapper boardMapper;
	
	//@Test
	public void testGetList() {
		boardMapper.getList().forEach(board -> log.info(board));
	}
	
	//@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		
		boardMapper.insert(board);
		
		log.info(board);
	}
	
	//@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		
		board.setTitle("다시 작성하는 글");
		board.setContent("다시 작성하는 내용");
		board.setWriter("oldbie");
		
		boardMapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	//@Test
	public void testread() {
		BoardVO board = boardMapper.read(5L);
		
		log.info(board);
	}
	
	@Test
	public void testupdate() {
		BoardVO board = new BoardVO();
		
		board.setBno(2L);
		board.setTitle("변경 완료");
		board.setContent("변경된 컨텐츠");
		
		int count = boardMapper.update(board);
		
		log.info("UPDATE COUNT : " + count);
	}
}
