package com.project.test;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("hhDAO")
public interface HHDAO {

	UserVO getOneUser(String id); //유저 한명 가져오기
	List<UserVO> getUserID(String id); // 아이디 검색 리스트 반환
	List<UserVO> getUserName(String name); // 이름 검색 리스트 반환
	List<PostVO> getHashtag(String hashtag); // 해시태그 검색 리스트 반환
	void insertPostData(PostVO pvo);//포스트데이터 저장
	List<PostVO> getPostNum(int postNum);  // 포스트번호 검색, 리스트 반환
	void insertUserData(UserVO uvo);
}
