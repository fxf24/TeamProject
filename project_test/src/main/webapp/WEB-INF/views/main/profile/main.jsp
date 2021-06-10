<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	//String postDate = request.getParameter("postDate");
	//out.print("게시물 등록 날짜는" + postDate);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="HTML, CSS">
<meta name="author" content="Practice">
<meta name="keywords" content="WebPortfolio">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<title>Insert title here</title>

<!-- 상단 고정 스타일 css 연결  -->
	<link href="/css/HHhead.css" rel="stylesheet" type="text/css">
	<link href="/css/profile/mainprofile.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/jquery-3.2.1.min.js"></script>
<script>
var user = sessionStorage.getItem("user") //유저 아이디 가져오기 (String id, String name, String email, String password, String telephone)
var post = sessionStorage.getItem("post") 

$(document).ready(function(){
	/* 게시물 업로드 - 포스트 작성으로 이동 */
	$('#postupload').click(function(){
		location.href = "/postupload"
	});
	
	$("#fileimage").click(function(e){
		document.imageform.target_url.value = document.getElementById('img').src;
		e.preventDefault()
		 $('#file').click();
		
	});
	
<!-- 프로필 사진은 회원이 업로드한 것으로 지정 - js 구현  -->
	/* 프로필 사진 업로드  */
 	$("#uploadprofile").click(function(event){
		event.preventDefault() 

		var form = $("#imageform")[0]
		var formData = new FormData(form)
		formData.append("file", $("#inputProfile")[0].files[0]) 
		$.ajax({
			url:'/saveProfileImage',
			type:'post',
			data: formData,
			cache: false,
			processData:false,
			contentType:false,
			success: function(response){
				var json = JSON.parse(response)
				var filename = json.filename
				console.log(json.filename);

 				//캔버스에 이미지 로드(canvas 태그 + canvas 자바스크립트 라이브러리)
				var imagecanvas = document.getElementById("imagecanvas")//htmlobject타입
				var context = imagecanvas.getContext("2d")
				
				//<img id="img" src="/image/basicprofileimage.jpg" alt="프로필 사진을 지정해주세요" >
				//이미지 로드
				var profileimg = document.getElementById('img').src
				var image = new Image()				
				image.src = "/profile/" + filename
				image.onload = function(){
					var maxWidth = 250; 
					var maxHeight = 250;
					var width = image.width;
					var height = image.height;
					
					if(width > maxWidth){
						height = height/(width / maxWidth) ;
						width = maxWidth;
						
					}else{
						if(height > maxHeight){
							width = width/(height/ maxHeight);
							height = maxHeight;
						}//중첩 if ends
					}//if end 
					context.drawImage(image, 0, 0, width, height)

				}//image.onload function end  
	
			}, //success end 
			error: function(e){
				console.log(e)
				alert('error : ' + e.message)
			} //error end 
		});//ajax end 

	}); //uploadprofile click function end 
	
/* 게시물 수 불러오기 1*/ 
var id = "";
var postDate = "";

		$.ajax({ 
		url: '/postsCount',
		type: 'post',
		data: {
			"postDate":postDate,
			"id":user
			},
		dataType: "json",
		processData: false,	
		async: false,
		success: function(response){
			//alert(response.length)
			console.log(response)
			var postscount = response.length
			var postsword = $('#profileposts').text(); 
			$('#profileposts').text(postsword + postscount); //게시물 + 갯수
		}, //success end 
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}//error end
	});//ajax end  

	
/* 포스트 전체 불러오기 3 */
var contents = "";
$.ajax({
	url: '/posts',
	type: 'post',
	data: {"postDate": postDate},
	dataType: "json",
	success: function(response){
		alert(response)
	}, //success end 
	error: function(request, status, error){
		alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);
	} //error end 
});//ajax end


/* 포스트 이미지 불러오기 2 */
var postsImage = "";

//function getPostsImage(id, postDate, postsList){
	$.ajax({ //postupload 이미지 불러오기
		url:'/postsImage',
		type:'post',
		data: {"id": user},
		dataType: "json",
		success: function(response){
			alert(response)
			for(var i=0; i< response.length; i++){
				console.log(response[i]);
			}
			if(response == "0"){ //포스트 사진이 없을 때
				$(".card-body").append
				("<div class='card-body' ></div>" + "<p class='card-text'>게시물 내용</p>"
   				+ "<div class='d-flex justify-content-between align-items-center'>"
					+ '<div class="btn-group">'
					+ '<button type="button" class="btn btn-sm btn-outline-secondary">View</button>'
					+ '<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>'
					+ '</div>'
					+ '<small class="text-muted">9 mins</small>'
				+ '</div>')
			}
			else {
				var postimagePath = response.split('/')
				console.log("경로 : "+ postimagePath)
				var postimageName = postimagePath[postimagePath.length-1]
				console.log("이미지이름 : "+ postimageName)
				postsImage = '/upload/'
				postsImage += postimageName
			}//else end
			$(".card-body").append
			("<img id='postsimg' src='"+ postsImage +"'>")
			console.log($('.card-body').val())
		}, //success end 
		error: function(request, status, error){
			alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);
		} //error end 
	});//ajax end 
//}//function getPostsImage end 

		
		
 /* 회원 아이디에서만 올린 포스트로 분류하기 위해 DB (문자열) 불러오기 */
// console.log($("#card-body3-1").append())
// $.ajax({
// 	type: 'post',
// 	url: '/saveData',
// 	data: {
// 		'id': user, 'content': $("#contents").val(), 'image': fileName,
// 		'hashtag': $("#hashtags").text() + $("#names").val()
// 	},
// 	dataType: 'json',

// 	success: function (response) {
// 		alert(response.data)
// 		location.href = "/"
		
// 	},

// 	error: function (request, status, error) {
// 		alert("success에 실패 했습니다.");
// 		console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
// 	}
// }); //ajax end

 	 
});//document ready end



</script>	
</head>
<body>
		<div id="followermodal" onclick="modalClick()"></div>
		<div id="modalContent" onclick="modalContentClick()"></div>
		
		<div id="followmodal" onclick="modalClick()"></div>
		<div id="modalContent" onclick="modalContentClick()"></div>

<main> 
<!-- <1> 회원 간단 정보(DB) - 고정 : 프로필 사진 | 회원 아이디 | 프로필 편집  -->
	<div id="info-container"> 
      <!-- 프로필 사진은 회원이 업로드한 것으로 지정 - js 구현  -->
		<div id="profileimage"> 
			<canvas id="imagecanvas" width=250 height=250></canvas>
			<img id="img" src=" " >
		</div>
		<form name="imageform" id="imageform" ENCTYPE="multipart/form-data" action="/saveProfileImage" method="post">
			<label id="fileimage" for="inputProfile"><img id="plus" src="/images/plus.png"></label>
			<div id="profileimgbox"> 
				<input name="file" type="file" id="inputProfile" accept="image/*" multiple   ><br>
				<input type="hidden" name ="target_url">
				<button id="uploadprofile" > 프로필 사진 업로드 </button>
			</div>
		</form>
	</div> 

        	<table>
        		<tr>
        			<td class="certaininfo">
						<span id="accountId"> <%=id %>&nbsp; </span>
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
						<span class="secondline" id="profileposts">게시물 &nbsp; </span>
        				<span class="secondline" id="follower">팔로워 &nbsp; </span>
        				<span class="secondline" id="follow">팔로우 &nbsp; </span>
					</td>
				</tr>
			<tr>
				<td> 
				<div id="postupload"> 
        			<label id="postfont"> 게시물 업로드 </label>
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
		 <div id="first-container">
            <div class="card-body" id="card-body3-1">
            <canvas class="posts" id="postscanvas" ></canvas>
            	<p class="card-text">게시물 내용</p>
              		<div class="d-flex justify-content-between align-items-center">
                		<div class="btn-group">
                			<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  			<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                		</div>
                		<small class="text-muted">9 mins</small>
              		</div>
            	</div>



            <div class="card-body" id="card-body3-2" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </div>

        

            <div class="card-body" id="card-body3-3" >
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
		

		<!-- 게시물 둘째 줄 -->
		<div id="second-contatiner">
            <div class="card-body"  id="card-body2-1">
            	<p class="card-text">게시물 내용</p>
              		<div class="d-flex justify-content-between align-items-center">
                		<div class="btn-group">
                			<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  			<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                		</div>
                		<small class="text-muted">9 mins</small>
              		</div>
            </div>



            <div class="card-body"  id="card-body2-2" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </div>

        

            <div class="card-body"  id="card-body2-3" >
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

		
		<!-- 게시물 셋째 줄 -->
		<div id="third-contatiner">
            <div class="card-body"  id="card-body1-1">
            	<p class="card-text">게시물 내용</p>
              		<div class="d-flex justify-content-between align-items-center">
                		<div class="btn-group">
                			<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  			<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                		</div>
                		<small class="text-muted">9 mins</small>
              		</div>
            	</div>
		


            <div class="card-body"  id="card-body1-2" >
              <p class="card-text">게시물 내용</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </div>

        

            <div class="card-body"  id="card-body1-3" >
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
		

</main>
</body>
</html>