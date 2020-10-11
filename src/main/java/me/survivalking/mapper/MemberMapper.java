package me.survivalking.mapper;

import me.survivalking.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);
}
