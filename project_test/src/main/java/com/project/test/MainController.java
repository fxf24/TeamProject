package com.project.test;


import java.io.File;
import java.io.IOException;
import java.util.List;

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
	@Autowired
	HHserviceImpl hhService;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() {
		return "index";
	}

	@RequestMapping("/postupload")
	public String uploadform() {
		return "main/posts/postupload";
	}

	@RequestMapping(value = "/saveImage", method = RequestMethod.POST)
	@ResponseBody
	public String saveImage(MultipartFile file) throws IOException {
		String filename = file.getOriginalFilename();
		System.out.println(filename);
		// 서버 저장 경로 설정
		String savePath = "c:/upload/";
		// 저장할 경로와 파일 이름 완성
		File savefile = new File(savePath + filename);
		// 서버 저장
		file.transferTo(savefile);
		return "{\"data\":\"저장했습니다!\"}";
	}

	//사용자 입력한 포스트 저장하기
	@RequestMapping(value="/saveData", method=RequestMethod.POST)
	@ResponseBody
	public String saveData(String id, String content, String image, String hashtag) {
		System.out.println(id + "|"+ content + "|"+ image + "|"+ hashtag );
		PostVO pvo = new PostVO();
		pvo.setId(id);
		pvo.setContents(content);
		pvo.setImagepath(image);
		pvo.setHashtag(hashtag);
		hhService.insertPostData(pvo);
		return "{\"data\":\"포스트 저장 완료\"}"; //작성 클릭 시, 화면 상 alert - 1
	}

	@RequestMapping(value = "/getODjson", method = RequestMethod.POST)
	@ResponseBody
	public String uploadresult(MultipartFile file) throws IOException {
		String filename = file.getOriginalFilename();
		// 서버 저장 경로 설정
		String savePath = "c:/upload/";
		// 저장할 경로와 파일 이름 완성
		File savefile = new File(savePath + filename);
		// 서버 저장
		file.transferTo(savefile);

		String odResult = naverService.getObjectDetectionService(filename);
		String cfrResult = naverService.getCFRService(filename);
		System.out.println(filename + ":" + odResult);
		System.out.println(cfrResult);

		return filename + "|" + odResult + "|" + cfrResult;
	}

	@RequestMapping("/")
	public String main() {
		return "main/infinite/mainscroll";
	}

	@RequestMapping("/login")
	public String login() {
		return "login/main";
	}

	
	//사용자 입력 데이터 저장하기
	@RequestMapping(value="/login", method=RequestMethod.POST)
	@ResponseBody
	public String loginService(String id, String password) {
		String result = "";
		UserVO user = hhService.getOneUser(id);
		System.out.println(user);
		if(user != null) {
			if(user.getPassword().equals(password)) {
				result = "{\"data\":\"로그인 성공!\", \"user\":\""+user.getId()+"\"}";
			}else {
				result = "{\"data\":\"잘못된 비밀번호 입니다!\"}";
			}
		}else {
			result = "{\"data\":\"없는 아이디 입니다!\"}";
		}
		return result;
	}

	@RequestMapping("/login/signup")
	public String signup() {
		return "login/signup";
	}

	
	//사용자 입력한 signup data 저장하기 
	@RequestMapping(value = "/login/signup", method = RequestMethod.POST)
	@ResponseBody
	public String signupService(String id, String name, String email, String password, String telephone) {
		UserVO user = new UserVO();
		user.setId(id);
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setTelephone(telephone);	
		hhService.insertUserData(user);
		return "{\"data\":\"유저 저장 완료\"}";
	}

	@RequestMapping(value = "/getUserID", method = RequestMethod.POST)
	@ResponseBody
	public String getOneUser(String id) {
		String result = "";
		UserVO user = hhService.getOneUser(id);
		if (user != null) {
			result = "{\"data\":\"사용할 수 없는 아이디 입니다!\"}";
		} else {
			result = "{\"data\":\"사용할 수 있는 아이디 입니다!\"}";
		}
		return result;
	}


	/* 프로필 */ 
	@RequestMapping("/profile")
	public String profile() {
		return "main/profile/main";
	}
	
	//회원아이디 불러오기 - 미작동 
	@RequestMapping(value="/profileaccount", method=RequestMethod.POST)
	@ResponseBody
	public UserVO profileaccount(String id) {
		UserVO user= null;
		UserVO uvo = new UserVO();
		uvo.setId(id);
		user = (UserVO) hhService.getOneUser(id);
		System.out.println("유저 저장 완료");
		return user;
		//return "{\"data\":\"유저 저장 완료\"}";
	}	
	
	@RequestMapping(value="/saveProfileImage", method=RequestMethod.GET)
	public String uploadprofileimageform() {
		return "/profile/main";
	}

	//프로필 이미지 업로드 받아오기
	@RequestMapping(value="/saveProfileImage", method=RequestMethod.POST)
	@ResponseBody
	public String saveprofileimage(MultipartFile file) throws IOException{
		String filename = file.getOriginalFilename();
		System.out.println(filename);
		//서버 저장 경로 설정
		String savePath="c:/profile/";
		//저장할 경로와 파일 이름 완성
		File savefile = new File(savePath + filename);
		//서버 저장
		file.transferTo(savefile);
		System.out.println("파일을 저장했습니다.");
		return "{\"filename\":\""+filename+"\"}";
	}
		
	//게시물 수 불러오기 1 
	@RequestMapping(value="/postsCount", method=RequestMethod.POST)
	@ResponseBody
	public List<PostVO> getPostsCount(String id) throws IOException {
		List<PostVO> countList = null;
		if (id != null || id !="") {
			countList = hhService.getPostsCount(id);
		}
		System.out.println("게시물 개수 불러오기 위한 리스트=" + countList);
		System.out.println("게시물 수 불러오기 완료");
		return countList;
	}		
	
	//포스트 이미지 불러오기 2 
	@RequestMapping(value="/postsImage", method=RequestMethod.POST)
    @ResponseBody
    public List<PostVO> getPostsImage(String id) throws IOException {
		List<PostVO> postsImage = null; 
		if(id != null || id != "") {
			postsImage = hhService.getPostsImage(id);
		}
		System.out.println("포스트 이미지들을 프로필 게시물 목록에 불러오기 위한 리스트=" + postsImage);
		System.out.println("포스트 이미지 불러오기 완료");
		return postsImage;
    }
		
	//포스트 전체 불러오기 3 
	@RequestMapping(value="/posts", method=RequestMethod.POST)
    @ResponseBody
    public List<PostVO> getPosts(String id) throws IOException {
		System.out.println("포스트 작성한 회원의 id는 "+id);
		List<PostVO> post = null;
		if (id != null || id != "") {
			post = hhService.getPosts(id);
		}
		System.out.println("회원이 업로드한 프로필 게시물 전체=" + post);
        System.out.println("포스트 불러오기 완료");
        return post;
    }
		
//	//포스트 전체 불러오기 3 시도1
//	@RequestMapping(value="/postData", method=RequestMethod.POST)
//    @ResponseBody
//    public String postData(String id, String contents, String imagepath, String hashtag, String postDate) {
//		PostVO post = new PostVO();
//		String getId = post.getId();
//		String getContents = post.getContents();
//		String getImagepath = post.getImagepath();
//		String getHashtag = post.getHashtag();
//		String getPostDate = post.getPostDate();
//		hhService.insertPostData(post);
//		return "{\""+getId+getContents+getImagepath+getHashtag+getPostDate+"\"}";
//	}
	
	
	@RequestMapping("/profile/editform")
	public String editform() {
		return "main/profile/editform";
	}

	@RequestMapping("/profile/imageform")
	public String imageform() {
		return "profile/imageform";
	}
 
	
	
	// 중복 방지를 위해 블록처리
	// @RequestMapping("/search")
	// public String search() {
	// return "search/main";
	// }

	@RequestMapping("/mainscroll")
	public String mainscroll() {
		return "main/infinite/mainscroll";
	}

	@RequestMapping("/button")
	public String button() {
		return "main/button/button";
	}

	@RequestMapping(value = "/showposts", method = RequestMethod.POST)
	@ResponseBody
	public List<PostVO> showPosts(String user){
		List<PostVO> list = null;
		if(user != null) {
			list = hhService.getUserPosts(user);
		}
		return list;
	}
}
