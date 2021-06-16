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
	List<UserVO> getOneProfileUser();
	UserVO getProfileUser(String id);
	void updateUserProfileData(String id, String profileImage);
	List<UserVO> getOneProfileImage(String id);
	List<PostVO> getPostsCount(String id);
	List<PostVO> getPosts(String id);
	List<PostVO> getPostsImage(String id);
	List<CommentThumbsupVO> getCommentThumbsup(int commentNum);
	void commentThumbsPlus(int commentNum, String id); // 댓글 좋아요 누르기
	void commentThumbsMinus(int commentNum, String id); // 댓글 좋아요 취소
	List<PostVO> getUserPosts(String id);//유저의 모든 포스트 데이터 반환
	void DeleteComment(String id, int commentNum); // 댓글 지우기
	void UpdateComments(int postNum, String comments, String id, int commentNum);// 댓글 수정하기
	List<ReplyCommentsVO> getReply(int commentNum, int postNum);
	void UpdateReply(int postNum, String comments, String id, int replyNum);
	void DeleteReply(String id, int replyNum);
	void AddReply(int postNum, int commentNum, String comments, String id);
	List<ReplyThumbsupVO> getReplyThumbsup(int replyNum);
	void replyThumbsPlus(int replyNum, String id);
	void replyThumbsMinus(int replyNum, String id);
	void insertFollowData(String from_user, String to_user);
	List<String> getFollowData(String fromUser);
}
