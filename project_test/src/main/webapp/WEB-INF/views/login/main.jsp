<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- px834 -->
<link href="/resources/css/login834.css" media="screen and (min-width: 429px) and (max-width: 834px)" rel="stylesheet">
<!-- px1440 -->
<link href="/resources/css/login1440.css" media="screen and (min-width: 834px) and (max-width: 1920px) "rel="stylesheet">
<!-- px1920 -->
<link href="/resources/css/login1980.css" media="screen and (min-width: 1920px) and" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/resources/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
});
</script>
</head>
<body>

<div id="login">
		<img id="hashhersheImg8341194" src="/resources/loginimage/hashhersheImg8341194.png" srcset="hashhersheImg8341194.png 1x, hashhersheImg8341194@2x.png 2x">
		<img id="cardigan" src="/resources/loginimage/cardigan.png" srcset="cardigan.png 1x, cardigan@2x.png 2x">
		<img id="head" src="/resources/loginimage/head.png" srcset="head.png 1x, head@2x.png 2x">
		<img id="pants" src="/resources/loginimage/pants.png" srcset="pants.png 1x, pants@2x.png 2x">
		<img id="scarf" src="/resources/loginimage/scarf.png" srcset="scarf.png 1x, scarf@2x.png 2x">
		<img id="help" src="/resources/loginimage/help.png" srcset="help.png 1x, help@2x.png 2x">
		<div id="hashhershe">
			<span>H</span><span style="font-size:34px;">A</span><span style="font-size:40px;">S</span><span style="font-size:48px;">H</span><span style="font-size:58px;">H</span><span style="font-size:70px;">E</span><span style="font-size:84px;">R</span><span style="font-size:104px;">S</span><span style="font-size:118px;">H</span><span style="font-size:142px;">E</span>
		</div>
		<img id="hashLine1" src="/resources/loginimage/hashhash.png" srcset="hashhash.png 1x, hashhash@2x.png 2x">
		<img id="hashLine2" src="/resources/loginimage/underhashhash.png" srcset="underhashhash.png 1x, underhashhash@2x.png 2x">
		<div id="naverLoginPBox">
			<svg class="naverLoginBox1">
				<rect id="naverLoginBox1" rx="0" ry="0" x="0" y="0" width="286" height="62">
				</rect>
			</svg>
			<div id="naverLoginBox2">
				<svg class="naverLoginBox3">
					<rect id="naverLoginBox3" rx="0" ry="0" x="0" y="0" width="270" height="44">
					</rect>
				</svg>
				<img id="naverIcon" src="naverIcon.png" srcset="naverIcon.png 1x, naverIcon@2x.png 2x">
				<div id="naverLoginFont">
					<span>네이버로 로그인하기</span>
				</div>
			</div>
		</div>
	<form action="/login/" method="post" class="loginHome">
		<div id="loginBox">
			<div class="loginBox1">
				<svg class="loginBox2">
					<rect id="loginBox2" x="0" y="0" width="428" height="644">
					</rect>
				</svg>
				<button id="loginBut" onclick="button()">
				</button>
				<div id="loginText">
					<span>로그인</span>
				</div>
			</div>
		<div id="loginCheckBox1" class="logBox1">
			<svg class="loginCheckBox3">
				<rect id="loginCheckBox3" rx="10" ry="10" x="0" y="0" width="344" height="40">
				</rect>
			</svg>
			<div id="loginCheckBoxText">
				<span>로그인</span>
			</div>
		</div>
		<div id="pwTextBox" class="pwBox1">
			<input type="password" id="pwInput" class="pw">
			<svg class="pwTextBox4">
				<rect id="pwTextBox4" rx="10" ry="10" x="0" y="0" width="344" height="40">
				</rect>
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
						<input type="text" id="idInput" class="id">
							<svg class="idTextBox2">
								<rect id="idTextBox2" rx="10" ry="10" x="0" y="0" width="344" height="40">
								</rect>
							</svg>
						<div id="idTextBox">
							<div id="idTextBoxText">
								<span>사용자 이름 및 이메일</span>
							</div>
						</div>
					</div>
				<div id="signup">
					<span>계정만들기</span>
				</div>
			<div id="findIdPass">
				<span>아이디/비밀번호 찾기</span>
			</div>
		</div>
	</form>
</div>
</body>
</html>