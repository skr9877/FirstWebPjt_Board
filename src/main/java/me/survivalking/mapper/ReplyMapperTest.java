package me.survivalking.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import me.survivalking.domain.Criteria;
import me.survivalking.domain.ReplyVO;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	private Long[] bnoArr = {10L, 16L, 20L};
	
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyVO vo = new ReplyVO();
			
			vo.setBno(bnoArr[i%3]);
			vo.setReply("댓글 테스트" + i);
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		});
	}
	
	public void testRead() {
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
	}
	
	public void testUpdate() {
		Long rno = 10L;
		
		ReplyVO vo = mapper.read(rno);
		
		vo.setReply("업데이트합니다.");
		
		int count = mapper.update(vo);
		
		if(count == 1) log.info("성공");
		else log.info("실패");
	}
	
	public void testGetList() {
		Criteria cri = new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 16L);
		
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void TestMaper() {
		testGetList();	
		
	}
}
