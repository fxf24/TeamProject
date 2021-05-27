package com.project.test;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("hhDAO")
public interface HHDAO {
	UserVO getOneUser(String id);
	List<UserVO> getUserID(String id);
}
