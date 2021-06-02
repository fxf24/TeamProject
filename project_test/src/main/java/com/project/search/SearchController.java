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
import com.project.test.ThumbsupVO;
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
	
	// 게시판 로드시 좋아요 개수, 좋아요 누른 사람 목록 반환
	@RequestMapping("/thumbsupsearch")
	@ResponseBody
	public List<ThumbsupVO> thumbsupsearch(int postNum) {
		List<ThumbsupVO> result = (List<ThumbsupVO>)service.getThumbsup(postNum);	
		return result;
	}
	
	// 게시물 좋아요 클릭시 좋아요 테이블에 쿼리 저장
	@RequestMapping("/thumbsplus")
	@ResponseBody
	public String thumbsplus(int postNum, String id) {
		ThumbsupVO tvo = new ThumbsupVO();
		tvo.setId(id);
		tvo.setPostNum(postNum);
		service.thumbsPlus(postNum, id);
		return "1";
	}
	
	@RequestMapping("/thumbsminus")
	@ResponseBody
	public String thumbsminus(int postNum, String id) {
		ThumbsupVO tvo = new ThumbsupVO();
		tvo.setId(id);
		tvo.setPostNum(postNum);
		service.thumbsMinus(postNum, id);
		return "0";
	}
	
	
}
