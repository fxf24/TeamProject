package com.project.test;

import org.springframework.stereotype.Component;

@Component("replythumbsupVO")
public class ReplyThumbsupVO {
	int replyThumbsupNum, replyNum;
	String id;
	
	public ReplyThumbsupVO() {}

	public ReplyThumbsupVO(int replyThumbsupNum, int replyNum, String id) {
		super();
		this.replyThumbsupNum = replyThumbsupNum;
		this.replyNum = replyNum;
		this.id = id;
	}

	public int getReplyThumbsupNum() {
		return replyThumbsupNum;
	}

	public void setReplyThumbsupNum(int replyThumbsupNum) {
		this.replyThumbsupNum = replyThumbsupNum;
	}

	public int getReplyNum() {
		return replyNum;
	}

	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "ReplyThumbsupVO [replyThumbsupNum=" + replyThumbsupNum + ", replyNum=" + replyNum + ", id=" + id + "]";
	}
	
}
