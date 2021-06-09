package com.project.test;

import org.springframework.stereotype.Component;

@Component("postVO")
public class PostVO {
	int postNum;
	String id, contents, imagepath, hashtag, postDate;
	
	public PostVO() {}
	
	public PostVO(int postNum, String id, String contents, String imagepath, String hashtag, String postDate) {
		super();

		this.postNum = postNum;
		this.id = id;
		this.contents = contents;
		this.imagepath = imagepath;
		this.hashtag = hashtag;
		this.postDate = postDate;
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
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	
	@Override
	public String toString() {
		return "PostVO [postNum=" + postNum + ", id=" + id + ", contents=" + contents + ", imagepath=" + imagepath
				+ ", hashtag=" + hashtag + ", postDate=" + postDate + "]";
	}
	
}