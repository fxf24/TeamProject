<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 상단 고정 스타일 css 연결  -->

	<link href="/css/HHhead.css" rel="stylesheet" type="text/css">
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
	    $('#file').click();
	});
});

function changeValue(obj){
	document.imageform.submit();
};
</script>
</head>

<body>
<h1>프로필입니다.</h1>

<!-- <1> 회원 간단 정보(DB) - 고정 : 프로필 사진 | 회원 아이디 | 프로필 편집  -->

  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
      <!-- 프로필 사진은 회원이 업로드한 것으로 지정 - js 구현  -->
	      <div id="profileimage" style="border: 1px solid gray;float: left; width: 30%; padding:10px;"> 
	      	<img src="/image/basicprofileimage.jpg" alt="프로필 사진을 지정해주세요" >
				<form name="imageform" method="POST" ENCTYPE="multipart/form-data" action="imageform.jsp" 
					style="text-align: center;">
    				<input type="file" id="file" name="file" style="display:none;" onchange="changeValue(this)">
    				<input type="hidden" name = "target_url">
				</form>
			</div>

        	<table style="border: 1px solid gray;float: left; width: 30%; padding:10px;">
        		<tr>
        			<td>
						<span id="account_id"> 회원 아이디 &nbsp; </span>
							<!--         프로필 편집 클릭 시, 새로운 창으로 이동 - js 구현  -->
<!--         				<div id="profile_edit" style="cursor:pointer;">
        					<button onclick="location='editform.jsp'">프로필 편집</button></div> -->
        					<form id="profile_edit" name="editform" ENCTYPE="multipart/form-data" action="editform.jsp"> 
        						<input name="profile_edit" type="button" value="프로필 편집">
       						</form>
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
					<form id="post" name="postform" ENCTYPE="multipart/form-data" method="post" action="postform.jsp"> 
        					<input name="post" type="button" value="게시물 업로드">
       				</form>
			<tr> 
				<td> 
			        <!-- 프로필 편집 창에서 입력한 소개글 DB 저장 그대로 불러와 -->
			        	<div class="introduction">소개 </div>
			        		<p> 회원이 작성한 소개글 </p> 
			     </td>
			</tr>
      </div>
    </div>
  </section>

 <main> 
  <div class="posts py-5 bg-light">
    <div class="main-container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      
        <div class="col">
          <div class="card shadow-sm">
<!--             <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img"  -->
<!--             aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"> -->
<!--             <title>Placeholder</title> -->
<!--             <rect width="100%" height="100%" fill="#55595c"/> -->
<!--             <text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text> -->
<!--             </svg> -->

            <div class="card-body">
            	<p class="card-text">게시물 내용</p>
              		<div class="d-flex justify-content-between align-items-center">
                		<div class="btn-group">
                			<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  			<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                		</div>
                		<small class="text-muted">9 mins</small>
              		</div>
            	</div>
          	</div>
        </div>

        <div class="col">
          <div class="card shadow-sm">
            <div class="card-body" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col">
          <div class="card shadow-sm">
            <div class="card-body" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </div>
          </div>
        </div>
        
      </div>
    </div>
  </div>
</main>


</body>
</html>