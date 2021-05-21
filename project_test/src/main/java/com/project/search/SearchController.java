package com.project.search;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SearchController {

	// 테스트용
	@RequestMapping(value="/test", method=RequestMethod.GET)
	public String test() {
		return "/search/test";
	}
		
	@RequestMapping(value="/hashtagsearch", method=RequestMethod.GET)
	public String hastagsearch() {
		return "/search/hashtagsearch";
	}
	
	
	@RequestMapping(value="/profilesearch", method=RequestMethod.GET)
	public String profilesearch() {
		return "/search/profilesearch";
	}
	 
}
