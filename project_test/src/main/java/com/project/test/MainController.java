package com.project.test;


import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
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
		String savePath = "/usr/mydir/upload/";
//		String savePath = "C:/upload/";
		
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
		String savePath = "/usr/mydir/upload/";
//		String savePath = "C:/upload/";
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

	
	//회원가입 유저정보 저장하기 
	@RequestMapping(value = "/login/signup", method = RequestMethod.POST)
	@ResponseBody
	public String signupService(String id, String name, String email, String password, String telephone) {
		UserVO user = new UserVO();
		user.setId(id);
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setTelephone(telephone);	
//		user.setProfileImage(profileImage);
		hhService.insertUserData(user);
		return "{\"data\":\"유저 저장 완료\"}";
	}

	//아이디 중복확인
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
		
	//회원아이디 주소창에 표시
	@RequestMapping(value="/profileAccount", method=RequestMethod.GET)
	@ResponseBody
	public String profileAccount(String id) {
		return "main/profile/main";
	}
	
	//유저정보 불러오기 
	@RequestMapping(value = "/oneProfileUser", method=RequestMethod.GET)
	@ResponseBody
	public List<UserVO> getOneProfileUser() {
		List<UserVO> oneProfileUser = hhService.getOneProfileUser();
		return oneProfileUser;
	}
	
	//프로필 유저 정보 가져오기 - 정상작동
	@RequestMapping(value = "/getProfileUser", method = RequestMethod.POST)
	@ResponseBody
	public UserVO getProfileUser(String id) {
		UserVO profileUser = hhService.getProfileUser(id);
		//System.out.println("유저의 프로필 이미지 : " + profileUser);
		return profileUser;
	}
	
	//저장된 프로필 사진 불러오기 - 정상작동
	@RequestMapping(value = "/getOneProfileImage", method = RequestMethod.POST)
	@ResponseBody
	public List<UserVO> getOneProfileImage(String id) throws IOException {
		List<UserVO> oneImage = null;
		if (id != null || id !="") {
			oneImage = hhService.getOneProfileImage(id);
		}
	System.out.println("저장된 프로필 사진은 : " + oneImage);
		//System.out.println("저장된 프로필 사진 불러오기 완료");
		return oneImage;
	}
	
	@RequestMapping(value="/uploadProfileImage", method=RequestMethod.GET)
	public String uploadprofileimageform() {
		return "main/profile/othersmain";
	}
	
	//프로필 업로드 - 정상작동 
	@RequestMapping(value = "/uploadProfileImage", method = RequestMethod.POST)
	@ResponseBody
	public String uploadProfileImage(MultipartFile file) throws IOException {
		String filename = file.getOriginalFilename();
		// 서버 저장 경로 설정
		String savePath = "/usr/mydir/profile/";
//		String savePath = "C:/profile/";
		// 저장할 경로와 파일 이름 완성
		File savefile = new File(savePath + filename);
		// 서버 저장
		file.transferTo(savefile);
		System.out.println("업로드하기 위한 이미지 파일명: " + filename);
		return "{\"filename\":\""+filename+"\"}";
	}

	//프로필 사진 저장 - 정상작동
	@RequestMapping(value = "/saveProfileImage", method = RequestMethod.POST)
	@ResponseBody
	public String saveProfileImage(MultipartFile file) throws IOException {
		String filename = file.getOriginalFilename();
		System.out.println("저장한 프로필 사진명:" + filename);
		// 서버 저장 경로 설정
		String savePath = "/usr/mydir/profile/";
//		String savePath = "C:/profile/";
		// 저장할 경로와 파일 이름 완성
		File savefile = new File(savePath + filename);
		// 서버 저장
		file.transferTo(savefile);
		//return "{\"data\":\"저장했습니다!\"}";
		return "{\"filename\":\""+filename+"\"}";
	}

	//사용자 업로드한 프로필 이미지 저장하기 - 정상작동
	@RequestMapping(value="/updateUserProfileData", method=RequestMethod.POST)
	@ResponseBody
	public void updateUserProfileData(String id, String profileImage) {
		System.out.println(id + "|"+ profileImage);
		UserVO user = new UserVO();
		user.setId(id);
		user.setProfileImage(profileImage);
		hhService.updateUserProfileData(id, profileImage);
	}
	
	//게시물 수 불러오기 1 
	@RequestMapping(value="/postsCount", method=RequestMethod.POST)
	@ResponseBody
	public List<PostVO> getPostsCount(String id) throws IOException {
		List<PostVO> countList = null;
		if (id != null || id !="") {
			countList = hhService.getPostsCount(id);
		}
		//System.out.println("게시물 개수 불러오기 위한 리스트=" + countList);
		//System.out.println("게시물 수 불러오기 완료");
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
		//System.out.println("포스트 이미지들을 프로필 게시물 목록에 불러오기 위한 리스트=" + postsImage);
		//System.out.println("포스트 이미지 불러오기 완료");
		return postsImage;
    }
		
	//포스트 전체 불러오기 3 
	@RequestMapping(value="/posts", method=RequestMethod.GET)
    @ResponseBody
    public List<PostVO> getPosts(String id) throws IOException {
		//System.out.println("포스트 작성한 회원의 id는 "+id);
		List<PostVO> post = null;
		if (id != null || id != "") {
			post = hhService.getPosts(id);
		}
		//System.out.println("회원이 업로드한 프로필 게시물 전체=" + post);
        //System.out.println("포스트 불러오기 완료");
        return post;
    }
		

	@RequestMapping("/profile/editform")
	public String editform() {
		return "main/profile/editform";
	}

	@RequestMapping("/profile/imageform")
	public String imageform() {
		return "main/profile/imageform";
	}
 
	
	
	// 중복 방지를 위해 블록처리
	// @RequestMapping("/search")
	// public String search() {
	// return "search/main";
	// }

	@RequestMapping("/button")
	public String button() {
		return "main/button/button";
	}

	@RequestMapping(value = "/showposts", method = RequestMethod.POST)
	@ResponseBody
	public List<PostVO> showPosts(String user){
		List<PostVO> list = null;
		
		
		if(user != null) {
			List<String> follower = hhService.getFollowData(user);
			
			list = hhService.getUserPosts(user);
			for(String f : follower) {
				list.addAll(hhService.getUserPosts(f));
			}
		}
		Collections.sort(list, new Comparator<PostVO>() {
		    @Override
		    public int compare(PostVO o1, PostVO o2) {
		        return o2.postDate.compareTo(o1.postDate);
		    }
		    
		});
		return list;
	}
	
	@RequestMapping(value = "/follow", method = RequestMethod.POST)
	@ResponseBody
	public String follow(String from_user, String to_user){
		hhService.insertFollowData(from_user, to_user);
		return  "{\"data\":\"팔로우 저장 완료\"}";
	}
	
	
}
