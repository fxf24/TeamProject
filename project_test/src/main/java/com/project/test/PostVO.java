package com.project.test;

import org.springframework.stereotype.Component;

@Component("postVO")
public class PostVO {
	int postNum;
	String id, contents, imagepath, hashtag, date;
	int thumbsup;
		
	public PostVO() {}
	
	public PostVO(int postNum, String id, String contents, String imagepath, String hashtag, String date, int thumbsup) {
		this.postNum = postNum;
		this.id = id;
		this.contents = contents;
		this.imagepath = imagepath;
		this.hashtag = hashtag;
		this.date = date;
		this.thumbsup = thumbsup;
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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getImagepath() {
		return imagepath;
	}
	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}
	public String getHashtag() {
		return hashtag;
	}
	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}
	public int getThumbsup() {
		return thumbsup;
	}
	public void setThumbsup(int thumbsup) {
		this.thumbsup = thumbsup;
	}
	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "PostVO [postNum=" + postNum + ", id=" + id + ", contents=" + contents + ", imagepath=" + imagepath
				+ ", hashtag=" + hashtag + ", thumbsup=" + thumbsup + "]";
	}
}
