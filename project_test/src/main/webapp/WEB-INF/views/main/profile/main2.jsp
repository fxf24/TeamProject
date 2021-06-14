<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<% 
	request.setCharacterEncoding("UTF-8");
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
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
<!-- 	<link href="/css/profile/mainprofile.css" rel="stylesheet" type="text/css"> -->
<script type="text/javascript" src="/jquery-3.2.1.min.js"></script>
		<script>
		/* 게시물 업로드 - 포스트 작성으로 이동 */ 
		$('#postupload').click(function(){
			location.href = "/postupload"
		});
		
		$(document).ready(function(){
			var user = sessionStorage.getItem("user")
			/*  프로필 이미지 업로드 - 파일 저장 - 출력 */
		 	$("#uploadprofile").click(function(event){ //프로필 사진 업로드 클릭 
				event.preventDefault() 
				

		 	
				var form = $("#imageform")[0]
				var formData = new FormData(form)
				formData.append("file", $("#inputProfile")[0].files[0])
				var fileName = ""
				
				$.ajax({
					url:'/uploadProfileImage',
					type:'post',
					data: formData, 
					cache: false,
					processData:false,
					contentType:false,
					success: function(response){
						console.log(response)
						var json = JSON.parse(response)
						fileName = json.filename
						console.log(json.filename);
						
		 				//캔버스에 이미지 로드(canvas 태그 + canvas 자바스크립트 라이브러리)
						var imagecanvas = document.getElementById("imagecanvas")//htmlobject타입
						var context = imagecanvas.getContext("2d")
						
						//<img id="img" src="" >
						//이미지 로드
						var image = new Image()	
						image.style.display = "absolute"
						image.style.zIndex = "3"
						image.src = "/profile/" + fileName
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
				
				showProfileImage(fileName)
				
			}); //uploadprofile click function end 
				
				/* 업로드 - 프로필 사진 출력 - 유지 */ //Cannot write uploaded file to disk!
				function showProfileImage(fileName) {
					$.ajax({ 
						url:'/getOneProfileImage',
						type:'post',
						data: { "id": user },
						dataType: "json",
						success: function(response){
							console.log(response) //1의 행
							var profileImage = response[0].profileImage
							console.log(profileImage) //null or 이미지파일명
						 		
							if(profileImage == null){ //프로필 사진이 없을 때 - 기본이미지 출력 
						 			var imagecanvas = document.getElementById("imagecanvas")//htmlobject타입
									var context = imagecanvas.getContext("2d")
						 			profileImage = 'basicprofileimage.jpg';
										var img = document.getElementById('img');
										img.style.display = "none"
										img.src = "/profile/" + profileImage
							 			img.onload = function() {
											var maxWidth = 250; 
											var maxHeight = 250;
											var width = img.width;
											var height = img.height;
											
											if(width > maxWidth){
												height = height/(width / maxWidth) ;
												width = maxWidth;
												
											}else{
												if(height > maxHeight){
													width = width/(height/ maxHeight);
													height = maxHeight;
												}//중첩 if ends
											}//if end 
											context.drawImage(img, 0, 0, width, height)	
										} //onload end 
						 		
								} else { //저장된 프로필 사진 있을 때 - 해당 사진 출력
							 			var imagecanvas = document.getElementById("imagecanvas")//htmlobject타입
										var context = imagecanvas.getContext("2d")
							 			profileImage = fileName;
								 			var img = document.getElementById('img');
											img.style.display = "none"
											img.src = "/profile/" + profileImage
								 			img.onload = function() {
												var maxWidth = 250; 
												var maxHeight = 250;
												var width = img.width;
												var height = img.height;
												
												if(width > maxWidth){
													height = height/(width / maxWidth) ;
													width = maxWidth;
													
												}else{
													if(height > maxHeight){
														width = width/(height/ maxHeight);
														height = maxHeight;
													}//중첩 if ends
												}//if end 
												context.drawImage(img, 0, 0, width, height)	
											} // onload end
						 			
									//var imagePath = response.split("/")
									//var imageName = imagePath[imagePath.length-1]
					//	 			profileImage = '/profile/'
					//	 			profileImage += imageName
					
								}//else end
				
							}, //success end 
							error: function(request, status, error){
								//alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error); 
							} //error end 
							
						});//ajax end 
				
					} //showProfileImage() end
				
			
			});//document ready end

			
			
	var user = sessionStorage.getItem("user")
	//var profileimgSrc = document.getElementById('img').src
	
	if (user == null) {
		if (confirm("로그인해주세요!")) {
			location.href = "/login"
			}
	} else {
			
		
			/*  프로필 사진 저장 - 이미지 파일형식 변환  */
			function saveProfileImage() { //프로필 사진 업로드 클릭 시 
				var $canvas = document.getElementById('imagecanvas');
				var imgDataUrl = $canvas.toDataURL('image/png', 1.0)
				
				var blobBin = atob(imgDataUrl.split(',')[1]); // base64 데이터 디코딩
				var array = [];
				for (var i = 0; i < blobBin.length; i++) {
					array.push(blobBin.charCodeAt(i));
				}
				      var file = new Blob([new Uint8Array(array)], {
				          name: '$("#inputProfile")[0].files[0]',
				          type: 'image/png'
				      }); // Blob 생성					
				var formdata = new FormData(); // formData 생성
				var fileValue = $("#inputProfile").val().split("\\");
				var fileName = fileValue[fileValue.length - 1];
				formdata.append("file", file, fileName);	// file data 추가
				
				$.ajax({
					type: 'post',
					url: '/saveProfileImage',
					data: formdata,
					processData: false,	// data 파라미터 강제 string 변환 방지!!
					contentType: false,	// application/x-www-form-urlencoded; 방지!!
					success: function (response) {
						var json = JSON.parse(response)
						var filename = json.filename
						console.log(json.filename);
						
					}
				
				}); //ajax end 	
				
				updateProfileImage(fileName)
				
			} //saveProfileImage() function end		
			

		/*  프로필 사진 저장 - user DB에 프로필 이미지 추가 업데이트 */
		function updateProfileImage(fileName) {
			$.ajax({ 
				type: 'post',
				url: '/updateUserProfileData',
				data: { 
					"id": user,
					"profileImage" : fileName 
					},
				dataType: 'json',
				success: function (response) {
		
				},
				error: function (request, status, error) {
					//alert("success에 실패 했습니다.");
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			})	//ajax end
			
		
		} //updateProfileImage() end





			/* 프로필 유저 정보 가져오기 - 테스트용 */
			$.ajax({ 
				url:'/getProfileUser',
				type:'post',
				data: {"id": user},		
				dataType: "json",
				success: function(response){
					console.log(response)
				},
				error: function(request, status, error){
					alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error); 
				} //error end 
			});//ajax end
			
			
			/* 회원아이디, 게시물 수 불러오기 1*/ 
			$.ajax({ 
			url: '/postsCount',
			type: 'post',
			data: {"id": user},
			dataType: "json",
			success: function(response){
				//console.log(response) // Array(response.length) 
				//console.log(response.length)
				var postscount = response.length //게시물 개수
				var postsword = $('#profileposts').text(); 
				$('#profileposts').text(postsword + "\n" + "\n" + postscount + "\n"); //게시물 + 갯수
				$('#accountId').text("\n" + user + "\n"); //회원아이디
			}, //success end 
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
			}//error end
			});//ajax end  
			
			
			/* 포스트 이미지 불러오기 2 */
			$.ajax({ //로그인한 상태로 들어오면 자동 출력
				url:'/postsImage',
				type:'post',
				data: {"id": user},
				dataType: "json",
				success: function(response){
					//console.log(response) //array(접속 회원 아이디의 포스트 개수)
					for(var i=0; i< response.length; i++){
						//console.log(response[i]); //최상단의 하나의 포스트 {, , , ... , }
						var onePost = response[i];
						//console.log(onePost.imagepath.split("/")) //["iu.png"]
						var imageName = onePost.imagepath.split("/"); 
			
						$(".flex-item").append('<img src="/upload/'+imageName+' " style="border: 3px solid silver">')
						imageName.onload = function() {
							var maxWidth = 300; 
							var maxHeight = 300;
							var width = imageName.width;
							var height = imageName.height;
							
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
						} //image onload function end
			
					} //for end 
				}, //success end 
				error: function(request, status, error){
					//alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error); 
				} //error end 
			});//ajax end 
			
			
			
			/* 포스트 전체 불러오기 3 - */
			var contents = "";
			$.ajax({ //부적합한 열 유형 1111 => 값이 null이므로 => postupload에서 값 받아오는게 안됨
				url: '/posts',
				type: 'post',
				data: {"id": user},
				dataType: "json",
				success: function(response){
					//console.log(response) //arraylist 
					//console.log(response[0].id) //list의 id 값 불러오기
				}, //success end 
				error: function(request, status, error){
					alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error); 
				} //error end 
			});//ajax end


		} //else end

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
	      <!-- 프로필 이미지  -->
			<div id="profileimgbox"> 
				<canvas id="imagecanvas" width=250 height=250 style="border-radius:19em; border:5px solid pink"></canvas>
				<img id="img" src=" " >
				<form name="imageform" id="imageform" ENCTYPE="multipart/form-data" method="post">
					<label id="fileimage" for="inputProfile">
						<img id="plus" src="/images/plus.png" style="cursor:pointer;width:3em; height:3em;"  >
					</label>
					<input name="file" type="file" id="inputProfile" style="display:none;"><br>
					<input type="hidden" name ="target_url">
					<button id="uploadprofile"  > 프로필 사진 업로드 </button>
					<button onclick="saveProfileImage()"> 프로필 사진 저장 </button>
				</form>
			</div>
			
			
			

			<!-- 회원아이디, 프로필 편집 줄 --> 
        	<table>
        		<tr>
        			<td class="certaininfo">
						<span id="accountId"> &nbsp; </span>
        					<button type="button" id=profileedit onclick="location.href='profile/editform'">프로필 편집</button>
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
			
			<!-- 게시물 업로드 줄 --> 
			<tr>
				<td> 
				<div id="postupload"> 
        			<label id="postfont"> 게시물 업로드 </label>
    			</div>
        	
        			
			<tr> 
				<td> 
			        <!-- 프로필 편집 창에서 입력한 소개글 DB 저장 그대로 불러와 -->
			        	<div id="introduction">소개 
			        		<div> 회원이 작성한 소개글 </div> 
			        	</div>
			     </td>
			</tr>
	</table>


<!-- 게시물 -->
<!-- 목록은 최근에 업로드한 것이 위에 위치하도록 (순서는 거꾸로 - 3(첫째 줄), 2(둘째 줄), 1(셋째 줄))
'-1, 2, 3' 은 왼쪽에서 오른쪽으로의 순서  -->

	<div id="main-container">
		 <!-- 게시물 첫째 줄 -->
		 <div class="flex-container">
            <div class="flex-item" id="card-body"></div>
        </div> 
	</div>       

		

</main>
</body>
</html>