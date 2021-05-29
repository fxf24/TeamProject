package com.project.test;

import java.util.List;

public interface HHservice {
	UserVO getOneUser(String id);
	List<UserVO> getUserID(String id);
	List<UserVO> getUserName(String id);
	List<PostVO> getHashtag(String hashtag);
}