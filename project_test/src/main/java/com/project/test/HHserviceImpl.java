package com.project.test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HHserviceImpl implements HHservice{
	@Autowired
	HHDAO hhdao;

	@Override
	public UserVO getOneUser(String id) {
		// TODO Auto-generated method stub
		UserVO result = hhdao.getOneUser(id);
		return result;
	}
	
}
