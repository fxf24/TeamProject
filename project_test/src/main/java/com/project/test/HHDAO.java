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
	List<UserVO> getOneProfileUser();
	UserVO getProfileUser(String id); //프로필 유저 한 명 불러오기
	void updateUserProfileData(String id, String profileImage); //회원의 프로필 수정 저장
	List<UserVO> getOneProfileImage(String id); //회원의 프로필 사진 불러오기
	List<PostVO> getPostsCount(String id); //프로필 게시물 수 불러오기
	List<PostVO> getPosts(String id); //프로필 목록에 포스트 전체 불러오기
	List<PostVO> getPostsImage(String id); //프로필에 포스트 이미지 불러오기
	List<CommentThumbsupVO> getCommentThumbsup(int commentNum);//댓글 로드시 각 댓글의 좋아요 갯수 반환
	void commentThumbsPlus(int commentNum, String id); // 댓글 좋아요 누르기
	void commentThumbsMinus(int commentNum, String id); // 댓글 좋아요 취소
	List<PostVO> getUserPosts(String user);//유저의 모든 포스트 데이터 반환
	void DeleteComment(String id, int commentNum); // 댓글 지우기	
	void UpdateComments(int postNum, String comments, String id, int commentNum);// 댓글 수정하기
	List<ReplyCommentsVO> getReply(int commentNum, int postNum); //답글(대댓글) 불러오기
	void UpdateReply(int postNum, String comments, String id, int replyNum); // 답글(대댓글) 수정하기
	void DeleteReply(String id, int replyNum); //답글 삭제
	void AddReply(int postNum, int commentNum, String comments, String id);// 답글 달기
	List<ReplyThumbsupVO> getReplyThumbsup(int replyNum); //답글에 눌린 좋아요 불러오기
	void replyThumbsPlus(int replyNum, String id); //답글 좋아요 누르기
	void replyThumbsMinus(int replyNum, String id); //답글 좋아요 취소
	void insertFollowData(String from_user, String to_user);
	List<String> getFollowData(String fromUser);
}
