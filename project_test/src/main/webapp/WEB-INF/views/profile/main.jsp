<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 상단 고정 스타일 css 연결  -->

<!-- 	<link href="/css/HHhead.css" rel="stylesheet" type="text/css"> -->
	<link href="/css/profile/topmain.css" rel="stylesheet" type="text/css">
	
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.83.1">
<title>Insert title here</title>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	/* 프로필 사진 업로드  */
	$('#profileimage').click(function (e){
		document.imageform.target_url.value = document.getElementById('profileimage').src;
		e.preventDefault();
	    $('#imagefile').click();
	});
});

function changeValue(obj){
	document.imageform.submit();
};

/* 게시물 업로드 - test1 */
$('#post_upload_btn').click(function (e){
	document.post_upload_btn.upload_url.value = document.getElementById('post_upload_btn').src;
	e.preventDefault();
    $('#postuploadfile').click();
});

/* 게시물 업로드 카메라와 연결 */ 
$(function(){
    $('#camera').change(function(e){
        $('#pic').attr('src', URL.createObjectURL(e.target.files[0]));
    });
});


출처: https://cofs.tistory.com/180 [CofS]
</script>
</head>

<body>
<h1>프로필입니다.</h1>
<main> 
<!-- <1> 회원 간단 정보(DB) - 고정 : 프로필 사진 | 회원 아이디 | 프로필 편집  -->

      <!-- 프로필 사진은 회원이 업로드한 것으로 지정 - js 구현  -->
	      <div id="profileimage"> 
	      	<img id="img" src="/image/basicprofileimage.jpg" alt="프로필 사진을 지정해주세요" >
				<form name="imageform" ENCTYPE="multipart/form-data" action="imageform.jsp" 
					style="text-align: center;">
    				<input type="file" id="imgaefile" name="imagefile" style="display:none;" onchange="changeValue(this)">
    				<input type="hidden" name = "target_url">
				</form>
			</div>

        	<table>
        		<tr>
        			<td>
						<span id="account_id"> 회원 아이디 &nbsp; </span>
							<!--         프로필 편집 클릭 시, 새로운 창으로 이동 - js 구현  -->
        					<button id="profile_edit" onclick="location='editform.jsp'">프로필 편집</button>
        					<!-- <form id="profile_edit" name="editform" ENCTYPE="multipart/form-data" action="editform.jsp"> 
        						<input name="profile_edit" type="button" value="프로필 편집">
       						</form> -->
        				<br>
					</td>
				</tr>
        		<tr >
        			<!-- 게시물 | 팔로워 | 팔로우 수는 저장된 데이터의 수 그대로 불러오기 --> 
					<td class="secondline">
						<span id="secondline1">게시물 &nbsp; </span>
        				<span id="secondline2">팔로워 &nbsp; </span>
        				<span id="secondline3">팔로우 &nbsp; </span>
					</td>
				</tr>
			<tr>
				<td> 
					<form id="post_upload_btn" name="post_upload_btn" ENCTYPE="multipart/form-data" method="post" action="postform.jsp"> 
        					<input id="post_upload_btn" name="post_upload_btn" type="button" value="게시물 업로드">
        					<input type="file" id="postuploadfile" name="postuploadfile" style="display:none;" onchange="changeValue(this)">
    						<input type="hidden" name = "upload_url">
        					<!-- 게시물 업로드 카메라와 연결 -->
        					<input type="file" id="camera" name="camera" capture="camera" accept="image/*">
        					<img id="pic" style="width:100%;" >
        			</form>
			<tr> 
				<td> 
			        <!-- 프로필 편집 창에서 입력한 소개글 DB 저장 그대로 불러와 -->
			        	<div id="introduction">소개 
			        		<p> 회원이 작성한 소개글 </p> 
			        	</div>
			     </td>
			</tr>

<!-- 게시물 -->
		<div id="main-container">
            <span id="card-body1">
            	<p class="card-text">게시물 내용</p>
              		<div class="d-flex justify-content-between align-items-center">
                		<div class="btn-group">
                			<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  			<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                		</div>
                		<small class="text-muted">9 mins</small>
              		</div>
            	</span>



            <span id="card-body2" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </span>

        

            <span id="card-body3" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </span>
		</div>       



</main>
</body>
</html>