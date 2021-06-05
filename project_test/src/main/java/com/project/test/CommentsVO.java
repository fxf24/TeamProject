package com.project.test;

import org.springframework.stereotype.Component;

@Component("commentsVO")
public class CommentsVO {
	int commentNum, postNum;
	String id, comments, commentsDate;
	
	public CommentsVO() {}

	public CommentsVO(int commentNum, int postNum, String id, String comments, String commentsDate) {
		super();
		this.commentNum = commentNum;
		this.postNum = postNum;
		this.id = id;
		this.comments = comments;
		this.commentsDate = commentsDate;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	public int getPostNum() {
		return postNum;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
	public String getCommentsDate() {
		return commentsDate;
	}

	public void setCommentsDate(String commentsDate) {
		this.commentsDate = commentsDate;
	}

	@Override
	public String toString() {
		return "CommentsVO [commentNum=" + commentNum + ", postNum=" + postNum + ", id=" + id + ", comments=" + comments
				+ ", commentsDate =" + commentsDate+ "]";
	}
	
}
