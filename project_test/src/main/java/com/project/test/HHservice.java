package com.project.test;

import java.util.List;

public interface HHservice {
	UserVO getOneUser(String id);
	List<UserVO> getUserID(String id);
	List<UserVO> getUserName(String id);
	List<PostVO> getHashtag(String hashtag);
	void insertPostData(PostVO pvo);
	List<PostVO> getPostNum(int PostNum);
	void insertUserData(UserVO uvo);
	List<ThumbsupVO> getThumbsup(int postNum);
	void thumbsPlus(int postNum, String id);
	void thumbsMinus(int postNum, String id);
	void addComments(int postNum, String comments, String id);
	List<CommentsVO> getComments(int postNum); 
	String getProfileImage(String id); 
	List<CommentThumbsupVO> getCommentThumbsup(int commentNum);
	void commentThumbsPlus(int commentNum, String id); // 댓글 좋아요 누르기
	void commentThumbsMinus(int commentNum, String id); // 댓글 좋아요 취소
	List<PostVO> getUserPosts(String id);//유저의 모든 포스트 데이터 반환
}
