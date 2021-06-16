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
		hhdao.insertPostData(pvo);
	}

	@Override // postNum 검색 리스트 반환
	public List<PostVO> getPostNum(int postNum) {
		return hhdao.getPostNum(postNum);
	}

	@Override
	public void insertUserData(UserVO uvo) {
		hhdao.insertUserData(uvo);
	}
	
	public List<ThumbsupVO> getThumbsup(int postNum) {
		return hhdao.getThumbsup(postNum);
	}

	@Override
	public void thumbsPlus(int postNum, String id) {
		hhdao.thumbsPlus(postNum, id);
	}
	
	public void thumbsMinus(int postNum, String id) {
		hhdao.thumbsMinus(postNum, id);
	}

	@Override
	public void addComments(int postNum, String comments, String id) {
		hhdao.addComments(postNum, comments, id);
	}

	@Override
	public List<CommentsVO> getComments(int postNum) {
		return hhdao.getComments(postNum);
	}

	@Override
	public String getProfileImage(String id) {
		return hhdao.getProfileImage(id);
	}

	@Override
	public List<UserVO> getOneProfileUser() {
		return hhdao.getOneProfileUser();
	}

	@Override
	public UserVO getProfileUser(String id) {
		UserVO result = hhdao.getProfileUser(id);
		return result;
	}

	@Override
	public void updateUserProfileData(String id, String profileImage) {
		hhdao.updateUserProfileData(id, profileImage);
	}
	
	@Override
	public List<UserVO> getOneProfileImage(String id) {
		return hhdao.getOneProfileImage(id);
	}

	@Override
	public List<PostVO> getPostsCount(String id) {
		return hhdao.getPostsCount(id);
	}

	@Override
	public List<PostVO> getPosts(String id) {
		return hhdao.getPosts(id);
	}

	@Override
	public List<PostVO> getPostsImage(String id) {
		return hhdao.getPostsImage(id);
	}

	@Override
	public List<CommentThumbsupVO> getCommentThumbsup(int commentNum) {
		return hhdao.getCommentThumbsup(commentNum);
	}

	@Override
	public void commentThumbsPlus(int commentNum, String id) {
		hhdao.commentThumbsPlus(commentNum, id);
		
	}

	@Override
	public void commentThumbsMinus(int commentNum, String id) {
		hhdao.commentThumbsMinus(commentNum, id);
	}

	@Override
	public List<PostVO> getUserPosts(String id) {
		return hhdao.getUserPosts(id);
	}

	@Override
	public void DeleteComment(String id, int commentNum) {
		hhdao.DeleteComment(id, commentNum);		
	}

	@Override
	public void UpdateComments(int postNum, String comments, String id, int commentNum) {
		hhdao.UpdateComments(postNum, comments, id, commentNum);
	}

	@Override
	public List<ReplyCommentsVO> getReply(int commentNum, int postNum) {
		return hhdao.getReply(commentNum, postNum);
	}

	@Override
	public void UpdateReply(int postNum, String comments, String id, int replyNum) {
		hhdao.UpdateReply(postNum, comments, id, replyNum);		
	}

	@Override
	public void DeleteReply(String id, int replyNum) {
		hhdao.DeleteReply(id, replyNum);	
	}

	@Override
	public void AddReply(int postNum, int commentNum, String comments, String id) {
		hhdao.AddReply(postNum, commentNum, comments, id);
	}

	@Override
	public List<ReplyThumbsupVO> getReplyThumbsup(int replyNum) {
		return hhdao.getReplyThumbsup(replyNum);
	}

	@Override
	public void replyThumbsPlus(int replyNum, String id) {
		hhdao.replyThumbsPlus(replyNum, id);
	}

	@Override
	public void replyThumbsMinus(int replyNum, String id) {
		hhdao.replyThumbsMinus(replyNum, id);
	}

	public void insertFollowData(String from_user, String to_user) {
		// TODO Auto-generated method stub
		hhdao.insertFollowData(from_user, to_user);
	}

	@Override
	public List<String> getFollowData(String fromUser) {
		// TODO Auto-generated method stub
		return hhdao.getFollowData(fromUser);
	}
	
}
