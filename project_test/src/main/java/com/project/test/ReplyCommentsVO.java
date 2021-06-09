package com.project.test;

import org.springframework.stereotype.Component;

@Component("replycommentsVO")
public class ReplyCommentsVO {
	int replyNum, postNum, commentNum;
	String id, comments, commentsDate;
	
	public ReplyCommentsVO() {}

	public ReplyCommentsVO(int replyNum, int postNum, int commentNum, String id, String comments, String commentsDate) {
		super();
		this.replyNum = replyNum;
		this.postNum = postNum;
		this.commentNum = commentNum;
		this.id = id;
		this.comments = comments;
		this.commentsDate = commentsDate;
	}

	public int getReplyNum() {
		return replyNum;
	}

	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}

	public int getPostNum() {
		return postNum;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
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
		return "ReplyCommentsVO [replyNum=" + replyNum + ", postNum=" + postNum + ", commentNum=" + commentNum + ", id="
				+ id + ", comments=" + comments + ", commentsDate=" + commentsDate + "]";
	}
	
}
