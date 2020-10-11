package me.survivalking.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import me.survivalking.domain.MemberVO;
import me.survivalking.mapper.MemberMapper;
import me.survivalking.security.domain.CustomUser;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("Load User By username : " + username);
		
		// userName means userid
		MemberVO vo = memMapper.read(username);
		
		return vo == null ? null : new CustomUser(vo);
	}

}
