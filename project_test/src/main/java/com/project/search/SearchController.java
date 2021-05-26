package com.project.search;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.test.HHservice;
import com.project.test.UserVO;

@Controller
public class SearchController {
	
	@Autowired
	HHservice service;
	
	// 테스트용
	@RequestMapping(value="/searchtest", method=RequestMethod.GET)
	public String test() {
		return "/search/mainsearchtest";
	}
		
	@RequestMapping("/search")
	public String hastagsearch() {
		return "/search/search"; 
	}

	// 아래 내용은 DB연결 시 변경 필요
	// id 검색시 반환 
//	@RequestMapping("/idsearch")
//	@ResponseBody
//	public String idsearch(String id) {
//		UserVO vo = service.getOneUser(id);
//		String result = vo.getId();
//		System.out.println(result);
//		//ModelAndView mv = new ModelAndView("jsonView");
//		if(id == null || id == "") {
//			result = "(id)검색결과가 없습니다.";
//		}
//		//String response >> 추후 DB업데이트시 연결
//		return result; //DB업데이트 시 response 로 변경
//	}
	
	
	@RequestMapping("/idsearch")
	@ResponseBody
	public List<UserVO> idsearch(String id) {
		List<UserVO> list = (List<UserVO>)service.getUserID(id);
		return list;
	}
	
	
	// name 검색시 반환 
	@RequestMapping("/namesearch")
	@ResponseBody
	public String namesearch(String searchmessage) {
		String event = null;
		if(searchmessage == "") {
			event = "(name)검색어를 입력해주세요.";
		} else {
			event = searchmessage+"(name)검색결과가 없습니다.";
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
			event = searchmessage+"(hashtag)검색결과가 없습니다.";
		}
		//String response >> 추후 DB업데이트시 연결
		return event; //DB업데이트 시 response 로 변경
	}
	
}
