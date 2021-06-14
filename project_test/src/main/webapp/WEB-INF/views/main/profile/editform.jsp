<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="HTML, CSS">
<meta name="author" content="Practice">
<meta name="keywords" content="WebPortfolio">
<title>Insert title here</title>
<script type="text/javascript" src="/jquery-3.2.1.min.js"></script>

<!-- 상단 고정 스타일 css 연결  -->
	<link href="/css/profile/editprofile.css" rel="stylesheet" type="text/css">

<script>
var user = sessionStorage.getItem("user") //유저 아이디 가져오기
$(document).ready(function(){
	/* 프로필 편집 창 띄우기 */
		$("#editenter").on('click', function(){
			$("#profileinfo").css("display","block");
			$("#profileeditbox").css("display","block");
			$("#formdesign").css("display","block");
			$("#formdesign2").css("display","block");
		});// 프로필 편집 div 생성
		$("#editenter").on('dblclick', function(){
			$("#profileinfo").css("display","none");
		});//프로필 편집 div 제거
	
	
	/* 비밀번호 변경 창 띄우기 */
		$("#changeenter").on('click', function(){
			$("#passwordchange").css("display","block");
		});// 비밀번호 변경 div 생성
		$("#changeenter").on('dblclick', function(){
			$("#passwordchange").css("display","none");
		});//비밀번호 변경 div 제거
	
	
	/* 푸시 알림 창 띄우기 */
		$("#pushenter").on('click', function(){
			$("#pushnotification").css("display","block");
		});// 푸시 알림 div 생성
		$("#pushenter").on('dblclick', function(){
			$("#pushnotification").css("display","none");
		});//푸시 알림 div 제거
	
	
	/* 공개범위 및 보안 창 띄우기 */
		$("#settingenter").on('click', function(){
			$("#accountopen").css("display","block");
		});// 공개범위 및 보안 div 생성
		$("#settingenter").on('dblclick', function(){
			$("#accountopen").css("display","none");
		});//공개범위 및 보안 div 제거
	
	
	/* 프로필 사진 업로드  */
	$('#profileimgchange').click(function(i){ //label
		document.editprofileinfo.imgupload_url.value = document.getElementById('profileimgchange').src; //form - input
		i.preventDefault();
	    $('#input-profileimg').click(); //input file
	});//function end

});//ready end 
	
	/* 푸시 알림 radio 버튼 선택 해제 (좋아요, 댓글) */
	function deselect(){
	    var onoff = document.getElementByName('onoff');
		    if (onoff.innerHTML = "모든 사람") {
		    	onoff.innerHTML = "내가 팔로우하는 사람";     
		    }else if (onoff.innerHTML = "내가 팔로우하는 사람"){
		    	onoff.innerHTML = "해제";
		    }else {
		    	onoff.innerHTML = "모든 사람"
		    }//if end
	 }//function end
	 
	 
	/* 푸시 알림 radio 버튼 선택 해제 (수락한 팔로우 요청, 알림) */
	function desel(){
	    var onoff = document.getElementByName('onoff');
		    if (onoff.innerHTML = "해제") {
		    	onoff.innerHTML = "설정";     
		    }else {
		    	onoff.innerHTML = "해제";
		    }//if end
	 }//function end

	
	
/* //서버 비동기적 처리
$.ajax ({
	type: "post or get",
	async: "true or false", //비동기식 처리할 지 여부 = True
	url: 요청할 url ,
	data: {서버로 전송할 데이터(매개변수)},
	dataType: "서버에서 전송받을 데이터형식",
	success: function (data,textStatus) {
	//정상요청, 응답 시 처리 
		 $('#message').append(data); 
}
}); */
</script>
</head>

<body id="profileeditbody">
<%-- main.jsp -> 프로필 편집 클릭 -> editform.jsp 
<%    
    request.setCharacterEncoding("UTF-8");
    request.getParameter();
%>

<a>이름은 <%= name %></a> --%>

<!-- 개요 창 : 프로필 편집  | 비밀번호 변경 | 푸시알림 | 공개 범위 및 보안 -->
<!-- 이 각자 창에서 작성된 data들은 db에 반영 -->

	<!-- 왼쪽 상단 메뉴들(항목들) 상시 고정 -->
		<div id="editlist"> 
			<a href="#profileinfo" target="_self" id="editenter" > 프로필 편집 </a><br>
			<a href="#passwordchange" target="_self" id="changeenter"> 비밀번호 변경 </a><br>
			<a href="#pushnotification" target="_self" id="pushenter"> 푸시알림 </a><br>
			<a href="#accountopen" target="_self" id="settingenter" > 공개 범위 및 보안 </a><br>
		</div>
		<div id="profilelistdescription"> 해당 항목에 원 클릭은 새 창 열림, 더블 클릭은 현재 창 제거</div>


	<!-- 프로필 편집 ("/accounts/edit/") --> 
		<div id="profileinfo"> 
			<form id="profileeditbox" name="editprofileinfo" action="editform.jsp" method="get"> 
				<div id="formdesign"> 
					<h1 id="profileedittitle"> &nbsp;&nbsp;프로필 편집 </h1>
						<img id="img" src="/images/basicprofileimage.jpg" >
							<div id="formdesign2">
							<h3 id="accountid"> 회원 아이디 </h3>
							<label id="profileimgchange" for="input-profileimg"> 프로필 사진 바꾸기 </label><br>
							<input type="file" id="input-profileimg" onchange="changeValue(this)"><br>
							<input type="hidden" name = "imgupload_url">
							&nbsp;&nbsp;이름: <input type="text" name="name" placeholder="이름을 작성해주세요" size=30 maxlength=20><br>
							&nbsp;&nbsp;아이디: <input type="text" name="id" placeholder="id를 작성해주세요" size=30 maxlength=20><br>
							&nbsp;&nbsp;소개: <input type="text" id="introduction" name="introduction" placeholder="자신의 계정의 포스트들을 소개하는 한 마디를 작성해주세요" 
							size=80 maxlength=40><br> <!-- //users TABLE DB에 추가 필요 -->
							&nbsp;&nbsp;이메일: <input type="email" name="email" placeholder="연락가능한 email을 작성해주세요" size=40 maxlength=20><br>
							&nbsp;&nbsp;전화번호: <input type="text" name="telephone" placeholder="전화번호를 작성해주세요" size=40 maxlength=20><br>
							<input type="submit" id="submit" value="제출">
							</div>
						</div>
					</form>
				</div>
		
		
	<!-- 비밀번호 변경 ("/accounts/password/change/") -->
		<div id="passwordchange"> 
			<form id="passwordinfo" action=" " method="post"> 
				<h1 id="pwchgtitle"> &nbsp;&nbsp; 비밀번호 변경 </h1>
					&nbsp;&nbsp;이전 비밀번호: <input type="text" name="lastpassword" ><br>
					&nbsp;&nbsp;새 비밀번호: <input type="text" name="newpassword" ><br>
					&nbsp;&nbsp;새 비밀번호 확인: <input type="text" name="newpasswordagain" ><br>
					<input type="submit" id="pwchgbtn" value="비밀번호 변경"><br>
					<a href="#" target="_blank" id="forgotpw"> &nbsp;&nbsp;비밀번호를 잊으셨나요? </a>
				</form>
			</div>
		
		
	<!-- 푸시알림 ("/push/web/settings/") -->
		<div id="pushnotification"> 
			<h1 id="pushsttitle">&nbsp;&nbsp; 푸시 알림</h1>
				<form id="pushsubmit"> 
					<div id="likes"> 
						<form name="onoff" id="likesinfo" action=" " method="post"> 
							<h3>좋아요</h3> 
							<input type="radio" id="off" name="onoff" value="innerHTML()" onclick="deselect()">해제<br>
							<input type="radio" id="onlytousers" name="onoff" value="innerHTML()" onclick="deselect()">내가 팔로우하는 사람만<br>
							<input type="radio" id="allusers" name="onoff" value="innerHTML()" onclick="deselect()">모든 사람<br>
							<input type="reset" id="reset" value="초기화"><br>
						</form>
					</div>
					
					<div id="comments"> 
						<form name="onoff" id="commentsinfo" action=" " method="post"> 
							<h3>댓글</h3>
							<input type="radio" id="off" name="onoff" value="innerHTML()" onclick="deselect()">해제<br>
							<input type="radio" id="onlytousers" name="onoff" value="innerHTML()" onclick="deselect()">내가 팔로우하는 사람만<br>
							<input type="radio" id="allusers" name="onoff" value="innerHTML()" onclick="deselect()">모든 사람<br>
							<input type="reset" id="reset"value="초기화"><br>
						</form> 
					</div> 
					
					<div id="follow"> 
						<form name="onoff" id="followaskinfo" action=" " method="post"> 
							<h3>수락한 팔로우 요청</h3>
							<input type="radio" id="off" name="onoff" value="innerHTML()" onclick="desel()">해제<br>
							<input type="radio" id="on" name="onoff" value="innerHTML()" onclick="desel()">설정<br>
							<input type="reset" id="reset" value="초기화"><br>
						</form>
					</div>
					
					<div id="notice"> 
						<form name="onoff" id="noticeinfo" action=" " method="post"> 
							<h3>알림</h3>
							<input type="radio" id="off" name="onoff" value="innerHTML()" onclick="desel()">해제<br>
							<input type="radio" id="on" name="onoff" value="innerHTML()" onclick="desel()">설정<br>
							<input type="reset" id="reset" value="초기화"><br>
						</form>
					</div>
					<input type="submit" id="done" value="설정 완료"><br>
				</form>
			</div>	
	
	
	<!-- 공개 범위 및 보안 ("accounts/privacy_and_security/") -->
		<div id="accountopen"> 
			<h1> 공개범위 및 보안</h1>
				<form id="openinfo" action=" " method="post"> 
					<h3>&nbsp;&nbsp;계정 공개 범위</h3>
					&nbsp;&nbsp;<input type="checkbox" value="openaccountoff">&nbsp;&nbsp;비공개 계정<br>
					<input type="submit" id="opensetting" value="설정 완료"><br>
				</form>
			</div>

</body>
</html>