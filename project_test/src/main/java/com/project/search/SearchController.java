package com.project.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.test.CommentThumbsupVO;
import com.project.test.CommentsVO;
import com.project.test.HHservice;
import com.project.test.PostVO;
import com.project.test.ReplyCommentsVO;
import com.project.test.ReplyThumbsupVO;
import com.project.test.ThumbsupVO;
import com.project.test.UserVO;

@Controller
public class SearchController {
	
	@Autowired
	HHservice service;
	
	// 테스트용, 추후 main페이지로 기능 이동 필요
	@RequestMapping("/searchtest")
	public String test() {
		return "main/search/mainsearchtest";
	}
		
	@RequestMapping("/search")
	public String hastagsearch() {
		return "main/search/search"; 
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
			list = (List<UserVO>)service.getUserName(name);	
		}
		return list;
	}
	
	// hashtag 검색시 반환 
	@RequestMapping("/hashtagsearch")
	@ResponseBody
	public List<PostVO> hashtagsearch(String hashtag) {
		List<PostVO> list = null;
		if(hashtag==null || hashtag=="") {
			list = null;	
		} else {
			list = (List<PostVO>)service.getHashtag(hashtag);
		}
		return list;
	}
	
	// hashtagresult.jsp
	@RequestMapping("/hashtagresult")
	public String oneHashtag() {
		return "main/search/hashtagresult";
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
	
	// 좋아요 취소 기능
	@RequestMapping("/thumbsminus")
	@ResponseBody
	public String thumbsminus(int postNum, String id) {
		ThumbsupVO tvo = new ThumbsupVO();
		tvo.setId(id);
		tvo.setPostNum(postNum);
		service.thumbsMinus(postNum, id);
		return "0";
	}
	
	// 댓글 작성 기능
	@RequestMapping(value="/addcomment", method=RequestMethod.POST)
	@ResponseBody
	public String addComments(int postNum, String comments, String id) {
		CommentsVO cvo = new CommentsVO();
		cvo.setPostNum(postNum);
		cvo.setComments(comments);
		cvo.setId(id);
		service.addComments(postNum, comments, id);
		//List<CommentsVO> list = service.getComments(postNum);
		return "1";
	}
	
	// 댓글 불러오기 기능
	@RequestMapping(value="/getcomment", method=RequestMethod.POST)
	@ResponseBody
	public List<CommentsVO> getComments(int postNum){
		List<CommentsVO> result = (List<CommentsVO>)service.getComments(postNum);	
		return result;
	}
	
	//프로필 이미지 불러오기 기능
	@RequestMapping(value="/getprofileimage", method=RequestMethod.POST)
	@ResponseBody
	public String getprofileimage(String id){
		UserVO uvo = new UserVO();
		uvo.setId(id);
		String profileImage = service.getProfileImage(id);
		if(profileImage==null) {
			profileImage = "0";
		}
		return profileImage;
	}
	
	// 댓글 로드시 각 댓글의 좋아요 갯수 반환
	@RequestMapping(value="/getcommentthumbsup", method=RequestMethod.POST)
	@ResponseBody
	public List<CommentThumbsupVO> getCommentThumbsup(int commentNum) {
		List<CommentThumbsupVO> result = 
				(List<CommentThumbsupVO>)service.getCommentThumbsup(commentNum);
		return result;
	}
	
	// 댓글에 좋아요 기능 클릭시 좋아요 눌리고 테이블에 저장
	@RequestMapping("/commentthumbsplus")
	@ResponseBody
	public String commentThumbsPlus(int commentNum, String id) {
		CommentThumbsupVO vo = new CommentThumbsupVO();
		vo.setId(id);
		vo.setCommentNum(commentNum);
		service.commentThumbsPlus(commentNum, id);
		return "1";
	}
	
	// 댓글 좋아요 취소 기능
	@RequestMapping("/commentthumbsminus")
	@ResponseBody
	public String commentThumbsMinus(int commentNum, String id) {
		CommentThumbsupVO vo = new CommentThumbsupVO();
		vo.setId(id);
		vo.setCommentNum(commentNum);
		service.commentThumbsMinus(commentNum, id);
		return "0";
	}
	
	// 댓글 지우기 기능
	@RequestMapping(value="/deletecomment", method=RequestMethod.POST)
	@ResponseBody
	public void DeleteComment(String id, int commentNum) {
//		CommentThumbsupVO tvo = new CommentThumbsupVO();
//		tvo.setCommentNum(commentNum);
//		service.DeleteCommentThumbs(commentNum);
		CommentsVO vo = new CommentsVO();
		vo.setId(id);
		vo.setCommentNum(commentNum);
		service.DeleteComment(id, commentNum);
	}
	
	// 댓글 수정하기 기능
	@RequestMapping(value="/updatecomment", method=RequestMethod.POST)
	@ResponseBody
	public void UpdateComment(int postNum, String comments, String id, int commentNum) {
		CommentsVO vo = new CommentsVO();
		vo.setPostNum(postNum);
		vo.setComments(comments);
		vo.setId(id);
		vo.setCommentNum(commentNum);
		service.UpdateComments(postNum, comments, id, commentNum);
	}
	
	// 대댓글(답글) 불러오기 기능
	@RequestMapping(value="/getreply", method=RequestMethod.POST)
	@ResponseBody
	public List<ReplyCommentsVO> getReply(int commentNum, int postNum) {
		ReplyCommentsVO vo = new ReplyCommentsVO();
		vo.setPostNum(postNum);
		vo.setCommentNum(commentNum);
		List<ReplyCommentsVO> list = (List<ReplyCommentsVO>)service.getReply(commentNum, postNum);
		return list;
	}
	
	// 대댓글(답글) 수정하기 기능
	@RequestMapping(value="/updatereply", method=RequestMethod.POST)
	@ResponseBody
	public void UpdateReply(int postNum, String comments, String id, int replyNum) {
		ReplyCommentsVO vo = new ReplyCommentsVO();
		vo.setPostNum(postNum);
		vo.setComments(comments);
		vo.setId(id);
		vo.setReplyNum(replyNum);
		service.UpdateReply(postNum, comments, id, replyNum);
	}
	
	// 답글(대댓글) 지우기 기능
	@RequestMapping(value="/deletereply", method=RequestMethod.POST)
	@ResponseBody
	public void DeleteReply(String id, int replyNum) {
		ReplyCommentsVO vo = new ReplyCommentsVO();
		vo.setReplyNum(replyNum);
		vo.setId(id);
		//service.DeleteCommentThumbs(commentNum); 대댓글 좋아요 기능 추가시 필요
		service.DeleteReply(id, replyNum);
	}
	
	// 답글 작성 기능
	@RequestMapping(value="/addreply", method=RequestMethod.POST)
	@ResponseBody
	public void AddReply(int postNum, int commentNum, String comments, String id) {
		ReplyCommentsVO cvo = new ReplyCommentsVO();
		cvo.setPostNum(postNum);
		cvo.setCommentNum(commentNum);
		cvo.setComments(comments);
		cvo.setId(id);
		service.AddReply(postNum, commentNum,comments, id);
	}
	
	
	// 답글의 좋아요 불러오기
	@RequestMapping(value="/getreplythumbsup", method=RequestMethod.POST)
	@ResponseBody
	public List<ReplyThumbsupVO> getReplyThumbsup(int replyNum) {
		List<ReplyThumbsupVO> result = (List<ReplyThumbsupVO>)service.getReplyThumbsup(replyNum);	
		return result;
	}
	
	// 답글 좋아요 누르기
	@RequestMapping("/replythumbsplus")
	@ResponseBody
	public void replyThumbsPlus(int replyNum, String id) {
		ReplyThumbsupVO vo = new ReplyThumbsupVO();
		vo.setReplyNum(replyNum);
		vo.setId(id);
		service.replyThumbsPlus(replyNum, id);
	}
	
	// 답글 좋아요 취소
	@RequestMapping("/replythumbsminus")
	@ResponseBody
	public void replyThumbsMinus(int replyNum, String id) {
		ReplyThumbsupVO vo = new ReplyThumbsupVO();
		vo.setReplyNum(replyNum);
		vo.setId(id);
		service.replyThumbsMinus(replyNum, id);
	}
}