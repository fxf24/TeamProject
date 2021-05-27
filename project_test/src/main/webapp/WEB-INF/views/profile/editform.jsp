<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(document).ready(function(){
	/* 프로필 사진 업로드  */
	$('#profileimgchange').click(function(i){
		document.editprofileinfo.imgupload_url.value = document.getElementById('profileimgchange').src;
		i.preventDefault();
	    $('#file').click();
	});
});

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

<body>
<!-- 개요 창 : 프로필 편집  | 비밀번호 변경 | 푸시알림 | 공개 범위 및 보안 -->
<!-- 이 각자 창에서 작성된 data들은 db에 반영 -->

	<!-- 왼쪽 상단 메뉴들(항목들) 상시 고정 -->
		<div id="editlist"> 
			<p><a href="/accounts/edit/" target="_self"> 프로필 편집 </a></p>
			<p><a href="/accounts/password/change/" target="_self"> 비밀번호 변경 </a></p>
			<p><a href="/push/web/settings/" target="_self"> 푸시알림 </a></p>
			<p><a href="accounts/privacy_and_security/" target="_self"> 공개 범위 및 보안 </a></p>
		</div>

	<!-- 프로필 편집 ("/accounts/edit/") --> 
		<div id="profileinto"> 
			<form name="editprofileinfo" action="editform.jsp" method="get"> 
				<img id="img" src="/image/basicprofileimage.jpg" >
					<span > 회원 아이디 </span>
					<label id="profileimgchange" for="input-profileimg"> 프로필 사진 바꾸기 </label><br>
					<input type="file" id="input-profileimg" onchange="changeValue(this)">
					<input type="hidden" name = "imgupload_url">
				이름: <input type="text" name="name" value="이름을 작성해주세요"><br>
				아이디: <input type="text" name="id" value="id를 작성해주세요"><br>
				소개: <input type="text" name="introduction" value="자신의 계정의 포스트들을 소개하는 한 마디를 작성해주세요"><br> <!-- //users TABLE DB에 추가 필요 -->
				이메일: <input type="text" name="email" value="연락가능한 email을 작성해주세요"><br>
				전화번호: <input type="text" name="telephone" value="전화번호를 작성해주세요"><br>
				<input type="submit" value="제출">
			</form>
		</div>
		
	<!-- 비밀번호 변경 ("/accounts/password/change/") -->
		<div id="passwordchange"> 
			<form id="passwordinfo" action=" " method="post"> 
				이전 비밀번호: <input type="text" name="lastpassword" ><br>
				새 비밀번호: <input type="text" name="newpassword" ><br>
				새 비밀번호 확인: <input type="text" name="newpasswordagain" ><br>
				<input type="submit" value="비밀번호 변경"><br>
				<p><a href="#" target="_blank"> 비밀번호를 잊으셨나요? </a></p>
			</form>
		</div>
		
	<!-- 푸시알림 ("/push/web/settings/") -->
		<div id="pushnotification"> 
			<div id="likes"> 
				<form id="likesinfo" action=" " method="post"> 
					<h3>좋아요</h3>
					<input type="radio" value="off">해제<br>
					<input type="radio" name="on" value="onlytouser">내가 팔로우하는 사람만<br>
					<input type="radio" name="on" value="alluser">모든 사람<br>
				</form>
			</div>
			
			<div id="comments"> 
				<form id="commentsinfo" action=" " method="post"> 
					<h3>댓글</h3>
					<input type="radio" value="off">해제<br>
					<input type="radio" name="on" value="onlytouser">내가 팔로우하는 사람만<br>
					<input type="radio" name="on" value="alluser">모든 사람<br>
				</form>
			</div> 
			
			<div id="follow"> 
				<form id="followaskinfo" action=" " method="post"> 
					<h3>수락한 팔로우 요청</h3>
					<input type="radio" value="off">해제<br>
					<input type="radio" value="on">설정<br>
				</form>
			</div>
			
			<div id="notice"> 
				<form id="noticeinfo" action=" " method="post"> 
					<h3>알림</h3>
					<input type="radio" value="off">해제<br>
					<input type="radio" value="on">설정<br>
				</form>
			</div>
		</div>	
	
	
	<!-- 공개 범위 및 보안 ("accounts/privacy_and_security/") -->
			<div id="accountopen"> 
				<form id="openinfo" action=" " method="post"> 
					<h3>계정 공개 범위</h3>
					<input type="checkbox" value="openaccountoff">비공개 계정<br>
				</form>
			</div>

</body>
</html>