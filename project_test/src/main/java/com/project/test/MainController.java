package com.project.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/")
	public String main() {
		return "main/main";
	}
	@RequestMapping("/login")
	public String login() {
		return "login/main";
	}
	@RequestMapping("/profile")
	public String profile() {
		return "profile/main";
	}
	@RequestMapping("/search")
	public String search() {
		return "search/main";
	}
}
