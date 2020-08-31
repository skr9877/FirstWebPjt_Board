package me.survivalking.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import me.survivalking.domain.Criteria;
import me.survivalking.domain.ReplyPageDTO;
import me.survivalking.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo);
	public ReplyVO get(Long rno);
	public int remove(Long rno);
	public int modify(ReplyVO vo);
	public List<ReplyVO> getList(Criteria cri, Long bno);
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
