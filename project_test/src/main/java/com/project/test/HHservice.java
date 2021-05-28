package com.project.test;

import java.util.List;

public interface HHservice {
	UserVO getOneUser(String id);
	List<UserVO> getUserID(String id);
}
