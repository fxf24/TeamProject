package com.project.test;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HHserviceImpl implements HHservice{
	@Autowired
	HHDAO hhdao;

	@Override
	public UserVO getOneUser(String id) {
		UserVO result = hhdao.getOneUser(id);
		return result;
	}

	@Override // id 검색 리스트 반환
	public List<UserVO> getUserID(String id) {
		return hhdao.getUserID(id);
	}
	
	@Override // name 검색 리스트 반환
	public List<UserVO> getUserName(String name) {
		return hhdao.getUserName(name);
	}

	@Override // hashtag 검색 리스트 반환
	public List<PostVO> getHashtag(String hashtag) {
		return hhdao.getHashtag(hashtag);
	}
	
	@Override
	public void insertPostData(PostVO pvo) {
		// TODO Auto-generated method stub
		hhdao.insertPostData(pvo);
	}

	@Override // postNum 검색 리스트 반환
	public List<PostVO> getPostNum(int postNum) {
		return hhdao.getPostNum(postNum);
	}

	@Override
	public void insertUserData(UserVO uvo) {
		// TODO Auto-generated method stub
		hhdao.insertUserData(uvo);
	}
}
