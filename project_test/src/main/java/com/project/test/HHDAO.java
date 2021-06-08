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
	List<ThumbsupVO> getThumbsup(int postNum); //좋아요 갯수, 누른 사람 목록 반환
	void thumbsPlus(int postNum, String id); // 좋아요 누르기
	void thumbsMinus(int postNum, String id); // 좋아요 취소
	void addComments(int postNum, String comments, String id); //댓글 추가
	List<CommentsVO> getComments(int postNum); // 작성한 댓글 불러오기
	String getProfileImage(String id); // 프로필 사진만 불러오기
	int getProfilePosts(int postDate); //프로필 게시물 수 불러오기
}
