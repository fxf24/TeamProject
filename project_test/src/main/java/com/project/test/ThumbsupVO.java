package com.project.test;

import org.springframework.stereotype.Component;

@Component("thumbsupVO")
public class ThumbsupVO {
	int thumbsNum;
	String id;
	int postNum;
	
	public ThumbsupVO() {}
	
	public ThumbsupVO(int thumbsNum, String id, int postNum) {
		super();
		this.thumbsNum = thumbsNum;
		this.id = id;
		this.postNum = postNum;
	}
	public int getThumbsNum() {
		return thumbsNum;
	}
	public void setThumbsNum(int thumbsNum) {
		this.thumbsNum = thumbsNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	@Override
	public String toString() {
		return "ThumbsupVO [thumbsNum=" + thumbsNum + ", id=" + id + ", postNum=" + postNum + "]";
	}
	
	
}
