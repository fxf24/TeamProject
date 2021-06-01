package com.project.search;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.test.HHservice;
import com.project.test.PostVO;
import com.project.test.UserVO;

@Controller
public class SearchController {
	
	@Autowired
	HHservice service;
	
	// 테스트용, 추후 main페이지로 기능 이동 필요
	@RequestMapping(value="/searchtest", method=RequestMethod.GET)
	public String test() {
		return "/search/mainsearchtest";
	}
		
	@RequestMapping("/search")
	public String hastagsearch() {
		return "/search/search"; 
	}

	// id 검색시 userVO 리스트 반환
	@RequestMapping("/idsearch")
	@ResponseBody
	public List<UserVO> idsearch(String id) {
		List<UserVO> list = null;
		if(id!=null || id!="") {
			list = (List<UserVO>)service.getUserID(id);	
		}
		return list;
	}
	
	// name 검색시 userVO 리스트 반환
	@RequestMapping("/namesearch")
	@ResponseBody
	public List<UserVO> namesearch(String name) {
		List<UserVO> list = null;
		if(name!=null || name!="") {
			list = (List<UserVO>)service.getUserID(name);	
		}
		return list;
	}
	
	// hashtag 검색시 반환 
	@RequestMapping("/hashtagsearch")
	@ResponseBody
	public List<PostVO> hashtagsearch(String hashtag) {
		List<PostVO> list = null;
		if(hashtag!=null || hashtag!="") {
			list = (List<PostVO>)service.getHashtag(hashtag);	
		}
		return list;
	}
	
	// hashtagresult.jsp
	@RequestMapping("/hashtagresult")
	public String oneHashtag() {
		return "/search/hashtagresult";
	}
	
	// postnum 검색시 반환 
	@RequestMapping("/postnumsearch")
	@ResponseBody
	public List<PostVO> postnumsearch(int postNum) {
		List<PostVO> list = (List<PostVO>)service.getPostNum(postNum);	
		return list;
	}
}
