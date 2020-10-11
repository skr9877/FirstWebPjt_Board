package me.survivalking.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		model.addAttribute("msg", "접근 거부");
	}
	
	@GetMapping("/customLogin")
	public void logInput(String error, String logout, Model model) {
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "로그아웃!");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGet() {
		log.info("custom logout");
	}
}

