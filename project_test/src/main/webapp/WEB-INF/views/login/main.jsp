<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- px834 -->
<link href="/css/login834.css" media="screen and (min-width: 429px) and (max-width: 834px)" rel="stylesheet">
<!-- px1440 -->
<link href="/css/login1440.css" media="screen and (min-width: 834px) and (max-width: 1920px) "rel="stylesheet">
<!-- px1920 -->
<link href="/css/login1920.css" media="screen and (min-width: 1920px) and" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
// 	$("#idInput").on("focusout", function() {
//         var x = $(this).val();
//         if (x.length > 0) {
//             if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
//                 x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
//             }
//             $(this).val(x);
//         }
//         }).on("keyup", function() {
//             $(this).val($(this).val().replace(replaceChar, ""));
//    });   
// 	$("#password").on("focusout", function() {
//         var x = $(this).val();
//         if (x.length > 0) {
//             if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
//                 x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
//             }
//             $(this).val(x);
//         }
//         }).on("keyup", function() {
//             $(this).val($(this).val().replace(replaceChar, ""));
//    });   
	

});//document ready end

function signup(){
	location.href = "/login/signup"
}

function login(){
	var id = $("#idInput").val()
	var password = $("#passwordInput").val()
	
	$.ajax({
		type: 'post',
  		url: '/login',
  		data: {'id': id, 'password': password},
  		dataType: 'json',
  		
  		success: function(response){
  			console.log(response.data)
  			if(response.data == "로그인 성공!"){
  				alert(response.data) //로그인 성공!
  				sessionStorage.setItem("user", response.user)
  				location.href = "/"
  			}
  			else{
  				alert(response.data) //로그인 실패
  				location.href = "/login"
  			}	
  		},
  			
  		error:function(request,status,error){
 			alert("success에 실패 했습니다.");
 			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
 		}
	})
}
</script>
</head>
<body>

<div id="login">
		<img id="hashhersheImg8341194" src="/loginimage/hashhersheImg8341194.png" >
		<img id="cardigan" src="/loginimage/cardigan.png" >
		<img id="head" src="/loginimage/head.png" >
		<img id="pants" src="/loginimage/pants.png" >
		<img id="scarf" src="/loginimage/scarf.png" >
		<img id="help" src="/loginimage/help.png" >
		<div id="hashhershe">
			<span>H</span><span style="font-size:34px;">A</span><span style="font-size:40px;">S</span><span style="font-size:48px;">H</span><span style="font-size:58px;">H</span><span style="font-size:70px;">E</span><span style="font-size:84px;">R</span><span style="font-size:104px;">S</span><span style="font-size:118px;">H</span><span style="font-size:142px;">E</span>
		</div>
		<img id="hashLine1" src="/loginimage/hashhash.png" >
		<img id="hashLine2" src="/loginimage/underhashhash.png" >
		<div id="loginBox">
			<div class="loginBox1">
				<svg class="loginBox2">
					<rect id="loginBox2" x="0" y="0" width="428" height="644"/>
				</svg>
<!-- 				<button id="loginBut" onclick="button()">
				</button> -->
				<div id="loginText">
					<span>로그인</span>
				</div>
			</div>
		<div id="loginCheckBox1" class="logBox1">
			<svg class="loginCheckBox3">
				<rect id="loginCheckBox3" rx="10" ry="10" x="0" y="0" width="344" height="40"/>
			</svg>
			<div id="loginCheckBoxText">
				<span>로그인</span>
			</div>
		</div>
		<div id="pwTextBox" class="pwBox1">
<!-- 			<input type="password" id="pwInput" class="pw">
 -->			<svg class="pwTextBox4">
				<rect id="pwTextBox4" rx="10" ry="10" x="0" y="0" width="344" height="40"/>
			</svg>
			<div id="pwText">
				<div id="pwText1" class="pwText1">
					<div id="pwText2">
							<span>비밀번호</span>
					</div>
				</div>
			</div>
		</div>
					<div id="idTextBox" class="idBox">
<!-- 						<input type="text" id="idInput" class="id">
 -->							<svg class="idTextBox2">
								<rect id="idTextBox2" rx="10" ry="10" x="0" y="0" width="344" height="40"/>
							</svg>
						<div id="idTextBox">
							<div id="idTextBoxText">
								<span>사용자 이름 및 이메일</span>
							</div>
						</div>
					</div>
				<div id="signup">
					<span><!-- <a href="/login/signup"> -->계정만들기<!-- </a> --></span>
				</div>
			<div id="findIdPass">
				<span>아이디/비밀번호 찾기</span>
			</div>
		<div id="naverLoginPBox">
			<svg class="naverLoginBox1">
				<rect id="naverLoginBox1" rx="0" ry="0" x="0" y="0" width="286" height="62"/>
			</svg>
			<div id="naverLoginBox2">
				<svg class="naverLoginBox3">
					<rect id="naverLoginBox3" rx="0" ry="0" x="0" y="0" width="270" height="44"/>
				</svg>
				<img id="naverIcon" src="/loginimage/naverIcon.png" >
				<div id="naverLoginFont">
					<span>네이버로 로그인하기</span>
				</div>
			</div>
		</div>
		<form action="" method="post" class="loginHome">
		<input type="text"id="idInput" class="idInput"/>
		<input type="password" id="passwordInput" class="passwordInput"/>
		<input type="button" id="loginButton" class="loginButton" onclick="login()"/>
		<button type=button id="findIdPassButton"  class="findIdPassButton"  onclick="location.href = "></button>
		<button type=button id="signupButton" class="signupButton"  onclick='signup()'></button>
		<button type=button id="naverLoginButton" class="naverLoginButton"  onclick="location.href = "></button>
		</form>
		</div>

</div>
</body>
</html>