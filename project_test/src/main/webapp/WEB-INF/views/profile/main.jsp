<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	<link href="/css/HHhead.css" rel="stylesheet" type="text/css">
	<link href="/css/profile/mainprofile.css" rel="stylesheet" type="text/css">
	
<script>
var user = sessionStorage.getItem("user") //유저 아이디 가져오기
window.onload = function() {
	$(document).ready(function(){
		
		/* 프로필 사진 업로드  */
		$('#img').click(function(i){
			document.imageform.target_url.value = document.getElementById('img').src;
			i.preventDefault();
		    $('#file').click();
		});
		
		
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

	
	function changeValue(obj){
		document.post_upload_btn.submit();
	};
	
	/* 게시물 업로드 - test1 */
	$('#postupload').click(function(p){
		document.postform.upload_url.value = document.getElementById('postupload').src;
		p.preventDefault();
	    $('#file').click();
	});
	
	/* 게시물 업로드 카메라와 연결 */ 
	$(function(){
	    $('#camera').change(function(c){
	        $('#pic').attr('src', URL.createObjectURL(c.target.files[0]));
	    });
	});//document ready 함수 end

}; //window onload 함수 end 

</script>
</head>

<!-- ㅋㅋㅋmerge할때 충돌 수정해주시는겁니다
head가 원본파일에 어떻게 되어있는지 보여주는거고
======표시 밑으로 merge한 파일이 어떻게 되어있는지 보여줘서
git add .
git commit -m '머지했다'
git push origin develop -->

<body>

<main> 
<!-- <1> 회원 간단 정보(DB) - 고정 : 프로필 사진 | 회원 아이디 | 프로필 편집  -->
	<div id="info-container"> 
      <!-- 프로필 사진은 회원이 업로드한 것으로 지정 - js 구현  -->
	      <div id="profileimage"> 
	      	<img id="img" src="/images/basicprofileimage.jpg" alt="프로필 사진을 지정해주세요" >
				<form name="imageform" ENCTYPE="multipart/form-data" action="imageform.jsp" >
    				<input type="file" id="file"  style="display:none;" onchange="changeValue(this)">
    				<input type="hidden" name = "target_url">
				</form>
			</div>

        	<table>
        		<tr>
        			<td>
						<span id="account_id"> 회원 아이디 &nbsp; </span>
							<!--         프로필 편집 클릭 시, 새로운 창으로 이동 - js 구현  -->
        					<button type="button" id=profileedit onclick="location.href='profile/editform'">프로필 편집</button>
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
				<div id="postupload"> 
					<form id="postform" ENCTYPE="multipart/form-data" method="post" action="postform.jsp"> 
        					<label id="postfont" for="input-file"> 게시물 업로드 </label>
        				<div id="postuploadbtn"> 
        					<input type="file" id="input-file" onchange="changeValue(this)">
    						<input type="hidden" name = "upload_url">
    					</div>
    				</form>
    			</div>
<!--         			게시물 업로드 카메라와 연결
        			<input type="file" id="file" name="camera" capture="camera" accept="image/*">
        			<img id="pic" style="width:100%;" >
        			<input type="hidden" name = "camera_url"> -->
        			
        			
			<tr> 
				<td> 
			        <!-- 프로필 편집 창에서 입력한 소개글 DB 저장 그대로 불러와 -->
			        	<div id="introduction">소개 
			        		<div> 회원이 작성한 소개글 </div> 
			        	</div>
			     </td>
			</tr>
	</table>
</div>

<!-- 게시물 -->
<!-- 목록은 최근에 업로드한 것이 위에 위치하도록 (순서는 거꾸로 - 3(첫째 줄), 2(둘째 줄), 1(셋째 줄))
'-1, 2, 3' 은 왼쪽에서 오른쪽으로의 순서  -->

		<div id="main-container">
		 <!-- 게시물 첫째 줄 -->
            <div id="card-body3-1">
            	<p class="card-text">게시물 내용</p>
              		<div class="d-flex justify-content-between align-items-center">
                		<div class="btn-group">
                			<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  			<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                		</div>
                		<small class="text-muted">9 mins</small>
              		</div>
            	</div>



            <span id="card-body3-2" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </span>

        

            <span id="card-body3-3" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </span>
		       
		

		<!-- 게시물 둘째 줄 -->
		<div id="second-contatiner">
            <div id="card-body2-1">
            	<p class="card-text">게시물 내용</p>
              		<div class="d-flex justify-content-between align-items-center">
                		<div class="btn-group">
                			<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  			<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                		</div>
                		<small class="text-muted">9 mins</small>
              		</div>
            	</div>



            <span id="card-body2-2" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </span>

        

            <span id="card-body2-3" >
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

		
		<!-- 게시물 셋째 줄 -->
            <div id="card-body1-1">
            	<p class="card-text">게시물 내용</p>
              		<div class="d-flex justify-content-between align-items-center">
                		<div class="btn-group">
                			<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  			<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                		</div>
                		<small class="text-muted">9 mins</small>
              		</div>
            	</div>



            <span id="card-body1-2" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </span>

        

            <span id="card-body1-3" >
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
</div>
		

</main>
</body>
</html>