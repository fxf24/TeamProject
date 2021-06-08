package com.project.test;

import org.springframework.stereotype.Component;

@Component("commentthumbsupVO")
public class CommentThumbsupVO {
	int commentThumbsupNum, commentNum;
	String id;
	
	public CommentThumbsupVO() {}

	public CommentThumbsupVO(int commentThumbsupNum, int commentNum, String id) {
		super();
		this.commentThumbsupNum = commentThumbsupNum;
		this.commentNum = commentNum;
		this.id = id;
	}

	public int getCommentThumbsupNum() {
		return commentThumbsupNum;
	}

	public void setCommentThumbsupNum(int commentThumbsupNum) {
		this.commentThumbsupNum = commentThumbsupNum;
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

	@Override
	public String toString() {
		return "CommentThumbsup [commentThumbsupNum=" + commentThumbsupNum + ", commentNum=" + commentNum + ", id=" + id
				+ "]";
	}
		
}
