package me.survivalking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import me.survivalking.domain.BoardVO;
import me.survivalking.service.BoardService;

@Controller // 스프링의 Bean으로 인식 웹요청 처리 컨트롤러로 사용
@RequestMapping("/board/*") // board로 시작하는 모든 처리
@Log4j
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list", service.getList());
	}
	
	@GetMapping("/register")
	public void register() {
		
	}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register : " + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result",  board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("get or modify");
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("modify : " + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list"; 
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		log.info("remove : " + bno);

		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/board/list";
	}
	
}