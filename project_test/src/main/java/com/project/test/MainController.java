package com.project.test;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class MainController {
	@Autowired
	NaverService naverService;
	
	@RequestMapping("/postupload")
	public String uploadform() {
		return "/main/postupload";
	}
	
	@RequestMapping(value="/getODjson", method=RequestMethod.POST)
	@ResponseBody
	public String uploadresult(MultipartFile file) throws IOException {
		String filename = file.getOriginalFilename();
		//서버 저장 경로 설정
		String savePath="c:/upload/";
		//저장할 경로와 파일 이름 완성
		File savefile = new File(savePath + filename);
		//서버 저장
		file.transferTo(savefile);
		
		String result = naverService.getObjectDetectionService(filename);
		System.out.println(filename +":" + result);
		
		return filename +"|" +result; 
	}
	
	@RequestMapping("/")
	public String main() {
		return "main/main";
	}

	@RequestMapping("/login")
	public String login() {
		return "login/main";
	}

	@RequestMapping("/profile")
	public String profile() {
		return "profile/main";
	}

<<<<<<< HEAD
	// 중복 방지를 위해 블록처리
//	@RequestMapping("/search")
//	public String search() {
//		return "search/main";
//	}
=======
	@RequestMapping("/search")
	public String search() {
		return "search/main";
	}
>>>>>>> 63b6a9d52b0d3f29eca00be66c7cd9597e793f3e
}
