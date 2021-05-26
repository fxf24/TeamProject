<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- px834 -->
<link href="/css/signup834.css" media="screen and (min-width: 429px) and (max-width: 834px)" rel="stylesheet">
<!-- px1440 -->
<link href="/css/signup1440.css" media="screen and (min-width: 834px) and (max-width: 1920px) "rel="stylesheet">
<!-- px1920 -->
<link href="/css/signup1920.css" media="screen and (min-width: 1920px) and" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/jquery-3.2.1.min.js"></script>
<script>
//특수문자 정규식 변수(공백 미포함)
var replaceChar = /[!@\$%\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/gi;
var replaceChar2 = /[!\$%\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/gi;
$(document).ready(function(){
$("#signupIdInput").on("focusout", function() {
        var x = $(this).val();
        if (x.length > 0) {
            if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
                x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
            }
            $(this).val(x);
        }
        }).on("keyup", function() {
            $(this).val($(this).val().replace(replaceChar, ""));
   });   
	$("#signupIdInput").on("focusout", function() {
	        var x = $(this).val();
	        if (x.length > 0) {
	            if (x.match(replaceChar2) || x.match(replaceNotFullKorean)) {
	                x = x.replace(replaceChar2, "").replace(replaceNotFullKorean, "");
	            }
	            $(this).val(x);
	        }
	        }).on("keyup", function() {
	            $(this).val($(this).val().replace(replaceChar2, ""));
	   });
$("#signupIdInput").on("focusout", function() {
    var x = $(this).val();
    if (x.length > 0) {
        if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
            x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
        }
        $(this).val(x);
    }
    }).on("keyup", function() {
        $(this).val($(this).val().replace(replaceChar, ""));
}); 
$("#signupPassInput").on("focusout", function() {
        var x = $(this).val();
        if (x.length > 0) {
            if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
                x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
            }
            $(this).val(x);
        }
        }).on("keyup", function() {
            $(this).val($(this).val().replace(replaceChar, ""));
   });
});       
$("#signupPassConfirmInput").on("focusout", function() {
    var x = $(this).val();
    if (x.length > 0) {
        if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
            x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
        }
        $(this).val(x);
    }
    }).on("keyup", function() {
        $(this).val($(this).val().replace(replaceChar, ""));
});
});       

</script>
</head>
<body>
<div id="signup">
	<div id="signupPBox1">
			<div id="signupBox1">
				<svg class="signupBox2">
					<rect id="signupBox2" rx="0" ry="0" x="0" y="0" width="1090" height="770">
					</rect>
				</svg>
			</div>
		<div id=signupPBox2>
			<div id="idBoxFont">
				<span>아이디</span>
			</div>
			<div id="idTerm">
				<span>※중복된 아이디입니다.</span>
			</div>
			<div id="emailFont">
				<span>이메일</span>
			</div>
			<div id="passwordFont">
				<span>비밀번호</span>
			</div>
			<div id="confirmPassFont">
				<span>비밀번호확인</span>
			</div>
			<div id="emailTerm">
				<span>※존재하지 않는 이메일입니다.</span>
			</div>
			<div id="passwordTerm">
				<span>※a-z, A-Z, 0-9 + 특수기호 ~,#,^,&,*  10자~16자 만 가능</span>
			</div>
			<div id="signupPButton">
				<div id="signupButton1">
					<svg class="signupButton2">
						<rect id="signupButton2" rx="24" ry="24" x="0" y="0" width="200" height="48">
						</rect>
					</svg>
					<div id="signupFont">
						<span>가입하기</span>
					</div>
					<div class="signupButtonClick">
						<button id="signupButtonClick" ></button>
					</div>
				</div>
			</div>
			<div id="idPBox">
				<div id="idBox1">
					<svg class="idBox2">
						<rect id="idBox2" rx="0" ry="0" x="0" y="0" width="372" height="52">
						</rect>
					</svg>
					<svg class="idBox3">
						<rect id="idBox3" rx="10" ry="10" x="0" y="0" width="372" height="52">
						</rect>
					</svg>
				</div>
				<div id="idFont1">
					<span>@</span>
				</div>
<!-- 				<div class="idBoxInput">
					<input id="idBoxInput"  type="text" >
				</div>
 -->			</div>
			<div id="emailPBox">
				<div id="emailBox1">
					<svg class="emailBox2">
						<rect id="emailBox2" rx="0" ry="0" x="0" y="0" width="372" height="52">
						</rect>
					</svg>
					<svg class="emailBox3">
						<rect id="emailBox3" rx="10" ry="10" x="0" y="0" width="372" height="52">
						</rect>
					</svg>
				</div>
<!-- 					<div class="emailnput" >
						<input id="emailInput"  type="text" >
					</div>
 -->			</div>
			<div id="passwordPBox">
				<div id="passwordBox1">
					<svg class="passwordBox2">
						<rect id="passwordBox2" rx="10" ry="10" x="0" y="0" width="372" height="52">
						</rect>
					</svg>
				</div>
<!-- 	 				<div class="passwordInput">
					<input id="passwordInput"  type="password">
				</div>
 -->			</div>
			<div id="confirmPassPBox">
				<div id="confirmPassBox1">
					<svg class="confirmPassBox2">
						<rect id="confirmPassBox2" rx="10" ry="10" x="0" y="0" width="372" height="52">
						</rect>
					</svg>
				</div>
<!-- 				<div class="confirmPassInput">
					<input id="confirmPassInput"  type="password">
				</div>
 -->			</div>
			<div id="signupTitle">
				<span>회원가입</span>
			</div>
		</div>
			<form action="/signup/" method="post" class="signup">
				<input type="text" class="signupIdInput" id="signupIdInput"   maxlength='50'>
				<input type="text" class="signupEmailInput"  id="signupEmailInput"  maxlength='50'>
				<input type="password" class="signupPassInput" id="signupPassInput"   maxlength='16'>
				<input type="password" class="signupPassConfirmInput"  id="signupPassConfirmInput"  maxlength='16'>
				<input type="submit" class="newSignupButton" id="newSignupButton" value="">
			</form>
	</div>
	<div id="hashhershe">
		<span>H</span><span style="font-size:34px;">A</span><span style="font-size:40px;">S</span><span style="font-size:48px;">H</span><span style="font-size:58px;">H</span><span style="font-size:70px;">E</span><span style="font-size:84px;">R</span><span style="font-size:104px;">S</span><span style="font-size:118px;">H</span><span style="font-size:142px;">E</span>
	</div>
	<img id="hashLine1" src="/loginimage/hashhash.png" >
		
	<img id="hashLine2" src="/loginimage/underhashhash.png" >
</div>	
</body>
</html>