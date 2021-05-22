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
		
<<<<<<< HEAD
	@RequestMapping("/search")
	public String hastagsearch() {
		return "/search/search";
	}

	// 아래 내용은 DB연결 시 변경 필요
	// id 검색시 반환 
	@RequestMapping("/idsearch") //(value="/idsearch", method=RequestMethod.GET)
	@ResponseBody
	public String idsearch(String searchmessage) {
		String event = null;
		if(searchmessage == "") {
		event = "(id)검색어를 입력해주세요.";
	} else {
		event = "(id)검색결과가 없습니다.";
	}
	//String response >> 추후 DB업데이트시 연결
	return event; //DB업데이트 시 response 로 변경
	}
	
	// name 검색시 반환 
	@RequestMapping("/namesearch")
	@ResponseBody
	public String namesearch(String searchmessage) {
		String event = null;
		if(searchmessage == "") {
			event = "(name)검색어를 입력해주세요.";
		} else {
			event = "(name)검색결과가 없습니다.";
		}
		//String response >> 추후 DB업데이트시 연결
		return event; //DB업데이트 시 response 로 변경
	}
	
	// hashtag 검색시 반환 
	@RequestMapping("/hashtagsearch")
	@ResponseBody
	public String hashtagsearch(String searchmessage) {
		String event = null;
		if(searchmessage == "") {
			event = "(hashtag)검색어를 입력해주세요.";
		} else {
			event = "(hashtag)검색결과가 없습니다.";
=======
	@RequestMapping(value="/hashtagsearch", method=RequestMethod.GET)
	public String hastagsearch() {
		return "/search/hashtagsearch";
	}
	
	
	@RequestMapping(value="/profilesearch", method=RequestMethod.GET)
	public String profilesearch() {
		return "/search/profilesearch";
	}
	
	@RequestMapping(value="/idsearch")
	@ResponseBody
	public String idsearch(String searchmessage) {
		String event = null;
		if(searchmessage == "") {
			event = "검색어를 입력해주세요.";
		} else {
			event = "검색결과가 없습니다.";
>>>>>>> 63b6a9d52b0d3f29eca00be66c7cd9597e793f3e
		}
		//String response >> 추후 DB업데이트시 연결
		return event; //DB업데이트 시 response 로 변경
	}

}
