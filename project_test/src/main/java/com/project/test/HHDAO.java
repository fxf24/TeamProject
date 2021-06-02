package com.project.test;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("hhDAO")
public interface HHDAO {

	UserVO getOneUser(String id); 
	List<UserVO> getUserID(String id); // 아이디 검색 리스트 반환
	List<UserVO> getUserName(String name); // 이름 검색 리스트 반환
	List<PostVO> getHashtag(String hashtag); // 해시태그 검색 리스트 반환
	void insertPostData(PostVO pvo);
	List<PostVO> getPostNum(int postNum);  // 포스트번호 검색, 리스트 반환
	List<ThumbsupVO> getThumbsup(int postNum); //좋아요 갯수, 누른 사람 목록 반환
	void thumbsPlus(int postNum, String id);
	void thumbsMinus(int postNum, String id);
}
