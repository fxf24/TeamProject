<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="overflow-y:scroll">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Pragma" content="no-cache" />
<title>Insert title here</title>
 	<link href="/css/profile/mainprofile.css" rel="stylesheet" type="text/css">
  	<link href="/css/profile/postmodal.css" rel="stylesheet" type="text/css">	
  	<link href="/css/search/modal834.css" media="screen and (min-width: 429px) and (max-width: 834px)" rel="stylesheet">
	<link href="/css/search/modal1920.css" media="screen and (min-width: 834px)" rel="stylesheet">
<script type="text/javascript" src="/jquery-3.2.1.min.js"></script>
		<script>
var user = sessionStorage.getItem("user")

$(document).ready(function(){
	$("#goToTopBtn").on("click", function(event){
		var offset = $("#main").offset();
		$("body").animate({scrollTop:offset.top}, 1500);
	});
	
if (getParam('id')== ""){
	user = sessionStorage.getItem("user")
	$("#follow").hide();
}
else{
	user = getParam("id")
	$('#profileedit').hide();
	$('#plus').hide();
	$('#upload').hide();
	$('#settingprofile').hide();
	$('#postfont').hide();
}

console.log(user)

		/* 게시물 업로드 - 포스트 작성으로 이동 */ 
		$('#postfont').click(function(){
			location.href = "/postupload"
		});

			/*  프로필 이미지 업로드 - 파일 저장 - 출력 */
		 	$("#upload").click(function(event){ //프로필 사진 업로드 클릭 
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

		
				
				
					meProfile(user)
});//document ready end
/* 업로드 - 프로필 사진 출력 - 유지 */ //Cannot write uploaded file to disk!
function showProfileImage(fileName) {
	var profileImage = fileName;
	console.log("profileImage" + profileImage)
	var img = new Image();
	if(profileImage == null){ //프로필 사진이 없을 때 - 기본이미지 출력 - 미작동 
		var imagecanvas = document.getElementById("imagecanvas")//htmlobject타입
		var context = imagecanvas.getContext("2d")
			img.src = "/images/basicprofileimage.jpg"
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
			var context = imagecanvas.getContext("2d");
				//img.style.display = "none"
				console.log("/profile/" + profileImage);
				img.src = "/profile/"+profileImage;
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
} //showProfileImage() end
	
function getProfileImage(profileImage) {
	$.ajax({
			type: 'get',
			url: '/oneProfileUser',
			dataType: 'json',
			success: function(response){
				console.log(response) //array
				var user0 = response[3].id
				console.log(user0) //eunsu
			// 0: {id: "admin", password: "admin", email: "admin@naver.com", name: "administrator", telephone: "010-1234-5678", …}
			// 1: {id: "admin2", password: "admin2", email: "admin2@naver.com", name: "administrator2", telephone: "010-2345-7890", …}
			// 2: {id: "elin", password: "12345678", email: "elincreator2126@gmail.com", name: "하은", telephone: "010-8888-9999", …}
			// 3: {id: "eunsu", password: "eunsu", email: "eunsu@gmail.com", name: "은수", telephone: "010-0000-7890", …}
			// length: 4							
 				var userno = response[0].userno
 				console.log(userno) //1
//  				var userNumber = response[i].userno
//  				console.log(userNumber) 
					for (var i=0; i < response.length; i++){
						var userId = response[i].id
						console.log(userId) //[" "]
						
						if (userId == user) { //자신의 프로필 접속 가능 
							meProfile(userId)
							//location.href = "/profile"
							 
						} else  { //타인 프로필 접속 가능 
							//alert("타인의 프로필로 접속합니다!")
							//location.href = "/profile/account?id=" + userId
							//otherProfile(userId)		
								
						} //else end 
						
					} //for end 
			},
			error: function(request, status, error){
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
			
		}); //ajax end 		
} //getProfileImage(profileImage) end 		

function getParam(sname) {
    var params = location.search.substr(location.search.indexOf("?") + 1);

    var sval = "";
    params = params.split("&");
    for (var i = 0; i < params.length; i++) {

        temp = params[i].split("=");

        if ([temp[0]] == sname) { sval = temp[1]; }
    }
    console.log(sval)
    return sval;
}	



if (user == null) {
		if (confirm("로그인해주세요!")) {
				location.href = "/login"
					}
}else { 							
					
function meProfile(userId) {
			


			/* 프로필 유저 이미지 유지 */
			$.ajax({ 
				url:'/getProfileUser',
				type:'post',
				data: {"id": userId},		
				dataType: "json",
				success: function(response){
					console.log(response) //{id: "eunsu", password: "eunsu", email: "eunsu@gmail.com", name: "은수", telephone: "010-0000-7890", …}
// 					email: "eunsu@gmail.com"
// 						id: "eunsu"
// 						name: "은수"
// 						password: "eunsu"
// 						profileImage: "eunsu.jpg"
// 						telephone: "010-0000-7890"
// 						userno: 43
				
					console.log(response.profileImage)
					showProfileImage(response.profileImage)
					
				},
				error: function(request, status, error){
					alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error); 
				} //error end 
			});//ajax end

			/* 회원아이디, 게시물 수 불러오기 1*/ 
			$.ajax({ 
			url: '/postsCount',
			type: 'post',
			data: {"id": userId},
			dataType: "json",
			success: function(response){
				//console.log(response) // Array(response.length) 
				//console.log(response.length)
				var postsCount = response.length //게시물 개수
				var postsWord = $('#profileposts').text(); 
				$('#profileposts').text(postsWord + "\n" + "\n" + postsCount + "\n"); //게시물 + 갯수
				$('#accountId').text("\n" + userId + "\n"); //회원아이디
				
			}, //success end 
			error:function(request,status,error){
				alert("회원 아이디와 게시물 수를 불러오기에 실패했습니다.")
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
			    
			}//error end
			});//ajax end  
			
			
			/* 포스트 이미지 불러오기 2 */
			$.ajax({ //로그인한 상태로 들어오면 자동 출력
				url:'/postsImage',
				type:'post',
				data: {"id": userId},
				dataType: "json",
				success: function(response){
					console.log(response) //array(접속 회원 아이디의 포스트 개수)
						for(var i=0; i< response.length; i++){
							//console.log(response[i]); //최상단의 하나의 포스트 {, , , ... , }
							var onePost = response[i];
							//console.log(onePost.imagepath.split("/")) //["iu.png"]
							var imageName = onePost.imagepath
							//console.log(imageName)
							var postDate = onePost.postDate 
							//console.log(postDate)
							var postNumber = onePost.postNum;
							//console.log(postNumber)
	
								
	// if문 추가하기 - 수직정렬 아이콘(1) | 수평수직정렬 아이콘 
							$(".flex-item").append(
									'<div class="postImageDate">'+
									'<div class="pD" >"'+postNumber+'"</div>'+
									'<img class="postImages" id="'+postNumber+'" src="/upload/'+imageName+' " onclick="clickImage('+postNumber+')" style="border: 3px solid silver;cursor: pointer;"></div>')
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
				
						} //for i end 
			

						
				}, //success end 
				error: function(request, status, error){
					//alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error); 
				} //error end 
			});//ajax end 
 			


} //meProfile(userId) end 					

			
} // else end 	
		var imageName = ""
			var postContent = ""
			var hashTag = ""
			var postDate = ""

				/* 포스트 전체 불러오기 3 - */
var CheckThumbsup = 0; //모달창을 띄웠을 때 기존에 좋아요를 눌렀는지 체크
var CheckCommentThumbsup = 0; //댓글창에 좋아요를 눌렀는지 체크??
var CheckReplyThumbsup = 0; //답글창에 좋아요를 눌렀는지 체크 
//var myid = "admin1"; // 현재 로그인한 아이디를 세션에서 받아옴, 현재 테스트용 admin으로 설정
var myid = sessionStorage.getItem("user") //로그인한 아이디를 세션에서 받아오는 방법
var postNum = 0; // 클릭한 이미지의 포스트번호 저장
var totalThumbs = 0; // 총 좋아요 개수 저장
var contents = []; // 좋아요 누른 사람을 저장하는 리스트


function clickImage(postNumber){ // 이미지 클릭시 게시글 모달창으로 나타냄
	$(".modal").css("display","flex")
	$(".modal").fadeIn();
	$("body").css("overflow-y", "hidden")
// 	$("html").css("overflow-y", "hidden")
	$(".modalContent").text("")
	postNum = parseInt(postNumber);
	
	$.ajax({ //전달받은 postNum 조회
		url :"/postnumsearch",
		type : "get",
		data : {"postNum" : postNum},
		dataType : "json",
		success : function(response){ //모달창에 작성
			var contents = response[0];
			var imageName = contents.imagepath.split("/")
			var hashtag = contents.hashtag.split("#")
			var commentList = []
			hashtag.shift(0)
			var postID = contents.id;
						
			var profileImagePath = FunctionGetContentProfileImage(postID); // 게시글 작성자의 프로필 이미지 불러오기	
			FunctionGetComment(postNum, commentList) // 댓글 가져오기 함수
			
			console.log(hashtag)
			$(".modalContent").append(
				"<div class='modalArticle'>"+
					"<img class='contentsImage' src='/upload/"+imageName[imageName.length-1]+"' ondblclick='thumbsup()'>"+
				"</div>")
					
			$(".modalContent").append(
			"<div class=modalSection>"+
				"<div class=modalHeader>"+
					"<div class=Header1>"+
						"<div class=Header1-1>"+
							"<div class='postProfileImage'>"+
								"<img class=postImage src='"+profileImagePath+"' onclick=location.href='/profile?id="+contents.id+"'>"+
							"</div>"+ 						
						"</div>"+ //header1-1
						"<div class=Header1-2>"+
							"<div class=postIDX>"+
								"<div class='postID'><a id=postID href='/profile?id="+contents.id+"'>"+contents.id+"</a></div>"+
								"<div class='windowClose'><i class='far fa-window-close fa-2x' onclick='modalClick()'></i></div>"+
							"</div>"+ //postIDx
							"<div class='postDate'>"+
								"<p id=postDate>"+contents.postDate+"</p>"+
							"</div>"+ // postDate
						"</div>"+ //header1-2
					"</div>"+ //Header1
					"<div class=Header2>"+
						//"<div class='postHashtag'></div>"+
						"<div class='postContents'><p id=postContents>"+contents.contents+"</p></div>"+
					"</div>"+ //Header2
				"</div>"+ //modalHeader
				
				"<div class=modalComment>"+
				"</div>"+ //modalComment
				
				"<div class=postComment>"+
					"<div><input id='myComment' type='text' onkeyup='enterkey(\""+contents.postNum+"\")' placeholder='댓글을 입력하세요'></div>"+
					"<div><input id='commentBtn' type='button' value='작성' onclick='addComment(\""+contents.postNum+"\")'></div>"+	
				"</div>"+
				
				"<div class=modalFooter>"+
					"<div class=LikeImage></div>"+
					"<div class=TotalLike></div>"+
				"</div>"+//modalFooter
			"</div>") //modalSection 여기가 문제
			
			var tag = "";
			for(var i in hashtag){
				tag += "<p><a class=hashtagLink href='https://search.shopping.naver.com/search/all?query="
					+hashtag[i]+"&cat_id=&frm=NVSHATC' target='_blank'>#"+hashtag[i]+"<a></p>"
				//$(".postHashtag").append(
				//"<p class=hashtagLink href='https://search.shopping.naver.com/search/all?query="
				//+hashtag[i]+"&cat_id=&frm=NVSHATC' target='_blank'>#"+hashtag[i]+"</p>")
			} // for end
			$(".postContents").prepend(tag)
			FunctionThumbsupSearch(postNum) // 좋아요 불러오기
		}, //success end
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} // error end
	}); //outer ajax end
}// function end
//엔터키 입력(a - 97  0 - 48 엔터키 - 13)하면 send  함수 동일 효과
function enterkey(postNum){
	if(window.event.keyCode == 13){
		addComment(postNum);
	}
}//function end
// 모달 창 function
var modalStatus = 0; // 모달창을 클릭한 것인지, 배경을 클릭한 것인지 구분
var editmodalState = 0;
function modalClick(){
	if(modalStatus==0){
		$("body").css("overflow-y", "scroll")
// 		$("html").css("overflow-y", "scroll")
		$(".modal").fadeOut();
		$("#cedit").fadeIn();
		$("#cdelete").fadeIn();
		$("#updateMyComment").html("");
		$(".commentEditModal").fadeOut();
		$("#redit").fadeIn();
		$("#rdelete").fadeIn();
		$("#updateMyReply").html("");
		$(".replyEditModal").fadeOut();
	} else if(modalStatus==1) {
		modalStatus = 0;
	} // elseif end
} // modalClick end
function modalContentClick(){
	modalStatus = 1;
	if(editmodalState==0){
		$("#cedit").fadeIn();
		$("#cdelete").fadeIn();
		$("#updateMyComment").html("");
		$(".commentEditModal").fadeOut();
		$("#redit").fadeIn();
		$("#rdelete").fadeIn();
		$("#updateMyReply").html("");
		$(".replyEditModal").fadeOut();
	}
	editmodalState=0;
} // modalContentClick end


function thumbsup(){ //좋아요 누르기 / 취소하기
	var id = myid;
	if(CheckThumbsup == 0){ //좋아요가 눌려있지 않은 경우
		$.ajax({
			url : "/thumbsplus",
			type : "get",
			data : {
				"postNum" : postNum,
				"id" : id
			},
			dataType : "text",
			success : function(response){
				totalThumbs = totalThumbs+1;
				CheckThumbsup = parseInt(response);
				$(".TotalLike").html(totalThumbs+"명이 좋아합니다.")
				//console.log("토탈 : "+totalThumbs)
				$(".LikeImage").html("<i class='fas fa-heart'></i>")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} // error end
		}); // ajax end
	} 
	else { // 좋아요가 이미 눌려있는 경우
		$.ajax({
			url : "/thumbsminus",
			type : "get",
			data : {
				"postNum" : postNum,
				"id" : id
			},
			dataType : "text",
			success : function(response){
				totalThumbs = totalThumbs-1;
				CheckThumbsup = parseInt(response);
				$(".TotalLike").text(totalThumbs+"명이 좋아합니다.")
				//console.log("토탈 : "+totalThumbs)
				$(".LikeImage").html("<i class='far fa-heart'></i>")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} // error end
		}); // ajax end
	}// else end
} // function thumbsup end

//좋아요 개수, 좋아요 누른 사람 반환
function FunctionThumbsupSearch(postNum){
	$.ajax({ 
		url : "/thumbsupsearch",
		type : "get",
		data : {"postNum" : postNum},
		dataType : "json",
		success : function(response){
			contents = []
			CheckThumbsup = 0; //현재 게시물 좋아요를 눌렀는지 판단
			for(var i in response){
				contents.push(response[i]);
				//console.log(contents)
				if(response[i].id == myid){ //현재는 admin 계정으로 간주, 이후 세션 id값으로 변경
					CheckThumbsup = 1; 							
				} //if end
			}//for end
			totalThumbs = contents.length; // 좋아요 개수
			//console.log(totalThumbs)
			if(CheckThumbsup == 0){ //좋아요가 눌려져 있지 않음
				$(".LikeImage").attr("onclick", "thumbsup()")
				$(".LikeImage").html
				("<i class='far fa-heart'></i>")
				$(".TotalLike").html(totalThumbs+"명이 좋아합니다.")
				
			} else { //좋아요가 눌려져 있음
				$(".LikeImage").attr("onclick", "thumbsup()")
				$(".LikeImage").html
				("<i class='fas fa-heart'></i>")
				$(".TotalLike").html(totalThumbs+"명이 좋아합니다.")					
			}// if else end	
		},
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} // error end 
	}); // ajax end
}
// 댓글 작성 기능
function addComment(postNum){
	var myComment = $("#myComment").val() //댓글입력창의 값을 추출
	if(myComment == null || myComment.trim() == ""){ //댓글입력창에 값이 없을 경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("댓글을 작성하시겠습니까?")){
// 		var id = myid
		var postNum = postNum		
		$.ajax({
			url: "/addcomment",
			type: "post",
			data : {
				"postNum": postNum,
				"comments": myComment,
				"id" : myid
			},
			dataType : "text",
			success : function(response){
				//console.log(response)
				var commentList = []
				$(".modalComment").text("") // 댓글창 초기화				
				FunctionGetComment(postNum, commentList)
				$("#myComment").val("") //댓글 등록후 작성창에 내용 삭제
				alert("댓글 작성이 완료되었습니다.")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}//addComment end

// 댓글 내용 반환 
function FunctionGetComment(postNum, commentList){
	$.ajax({ //댓글 불러옴
		url: "/getcomment",
		type: "post",
		data : {"postNum" : postNum},
		dataType : "json",
		//async: false,
		success: function(response){
			for(var i=0; i<response.length; i++){
				//console.log(response[i])
				commentList.push(response[i])
			}
			//console.log(commentList)
			if(commentList.length==0){
				$(".modalComment").html("<p class=commentEmpty>댓글이 없습니다.</p>")
			} // if end
			else { // 댓글 불러오기
				// 프로필 사진 불러오기
				for(var i=0; i<commentList.length; i++){
					FunctionGetProfileImage(commentList[i], i)
				}// for end
			}
		},//success end
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}//error end
	})//ajax end
} //function end


//댓글 프로필 이미지, 내용 반환
var CheckCommentThumbsup = 0; //현재 게시물 좋아요를 눌렀는지 판단
function FunctionGetProfileImage(commentList, i){
	var profileImage = "";
	var cnt = i;
	$.ajax({ 
		url: "/getprofileimage",
		type: "post",
		data: {"id" : commentList.id},
		dataType: "text",
		async: false,
		success: function(response){					
			if(response=="0"){ //프로필 사진이 없을 때
				profileImage = '/images/basicprofileimage.jpg';
			}
			else {
				var imagePath = response.split("/")
				var imageName = imagePath[imagePath.length-1]
				profileImage = '/profile/'
				profileImage += imageName
			}//else end
			
			$.ajax({ 
				url : "/getcommentthumbsup",
				type : "post",
				data : {"commentNum" : commentList.commentNum},
				dataType : "json",
				async: false,
				success : function(response){
					contents = []
					for(var i in response){
						contents.push(response[i]);
// 						CheckCommentThumbsup = 0; 	
						if(response[i].id == myid){ //현재는 admin 계정으로 간주, 이후 세션 id값으로 변경
							CheckCommentThumbsup = 1; 							
						} //if end
					}//for end
					var totalThumbs = contents.length; // 좋아요 개수
						
					$(".modalComment").append(
					"<div class=OneComment>"+ //댓글 하나
				        "<div class=Comment1>"+
				        	"<div class=Comment1-1>"+
				            	"<div class=oneCommentProfileImage>"+
				            		"<image class='commentImage' src='"+profileImage+"' onclick=location.href='/profile?id="+commentList.id+"'>"+
				           		"</div>"+
				           	"</div>"+ //Comment1-1
				           	"<div class=Comment1-2>"+
					            "<div class=CommentIDX>"+
					                "<div class=CommentID>"+
					                	"<a id=CommentID onclick=location.href='/profile?id="+commentList.id+"'> "+commentList.id+"</a>"+
					                "</div>"+
					                "<div class=CommentSet onclick='FunctionEditComment(\""+commentList.id+"\", "+commentList.commentNum+", "+cnt+")'>"+
					                	"<i class='fas fa-ellipsis-h' id=CommentSet></i>"+
					                "</div>"+
					            "</div>"+
					            "<div class=CommentDate>"+
					            	"<p id=CommentDate>"+commentList.commentsDate+"</p>"+
					            "</div>"+
				            "</div>"+ //Comment1-2
				        "</div>"+
				        "<div class=Comment2>"+
				            "<div class=CommentContents>"+
				            	"<p class='contents' id='contents_"+cnt+"' style='text-align:left'> "+commentList.comments+"</p>"+
				            "</div>"+
				            "<div class=CommentBox>"+
				                "<div class=CommentLike>"+
				                    "<div class=CommentLikeImage_"+cnt+" onclick='commentThumbsup("+CheckCommentThumbsup+", "+commentList.commentNum+", "+totalThumbs+", "+cnt+")'></div>"+
				                    "<div class=CommentTotalLike></div>"+
				                "</div>"+
				                "<div class=CommentTotalReply id='seeReply_"+cnt+"' onclick='ShowReply("+cnt+")'></div>"+
				                "<div class=CommentAddReply id='reply_"+cnt+"' onclick='writeReply("+commentList.commentNum+", "+cnt+")'>답글달기</div>"+
				         	  "</div>"+
				         	 "<div class='replyBox' id='replyBox_"+cnt+"'></div>"+
				        "</div>"+
				    "</div>"+ // oneComment	
				   
				    
				    "<div class=OneReply id='replyList_"+cnt+"'></div>")
					
					
					if(CheckCommentThumbsup == 0){ //좋아요가 눌려있음
						$(".CommentLikeImage_"+cnt+"").html("<i class='far fa-heart'></i> 좋아요 "+totalThumbs+"개 ")
					} else if(CheckCommentThumbsup == 1){ // 좋야요가 눌려있지않음
						$(".CommentLikeImage_"+cnt+"").html("<i class='fas fa-heart'></i> 좋아요 "+totalThumbs+"개 ")
					}// if else end	
					CheckCommentThumbsup = 0;
				},
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				} // error end 
			}); // ajax end	
		},
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}//error end
	})//ajax end	
	FunctionGetReply(commentList.commentNum, cnt) 
}// function end

//댓글에 좋아요 누르기
function commentThumbsup(CheckCommentThumbsup, commentNum, totalThumbs, cnt){
	var id = myid;
	var num = commentNum;
	
	if(CheckCommentThumbsup == 0){ //좋아요가 눌려있지 않은 경우
		$.ajax({
			url : "/commentthumbsplus",
			type : "get",
			data : {
				"commentNum" : commentNum,
				"id" : id
			},
			dataType : "text",
			success : function(response){
				totalThumbs = totalThumbs+1;
				CheckCommentThumbsup = 1; //parseInt(response);
				//console.log(CheckCommentThumbsup)
				$(".CommentLikeImage_"+cnt+"").removeAttr("onclick") //클릭 속성 제거
				$(".CommentLikeImage_"+cnt+"").attr("onclick", "commentThumbsup("+CheckCommentThumbsup+", "+commentNum+", "+totalThumbs+", "+cnt+")") //클릭 속성 내 Check~값 변경
				$(".CommentLikeImage_"+cnt+"").html("<i class='fas fa-heart'></i> 좋아요 "+totalThumbs+"개 ")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} // error end
		}); // ajax end
	} 
	else if(CheckCommentThumbsup == 1){ // 좋아요가 이미 눌려있는 경우
		$.ajax({
			url : "/commentthumbsminus",
			type : "get",
			data : {
				"commentNum" : commentNum,
				"id" : id
			},
			dataType : "text",
			success : function(response){
				totalThumbs = totalThumbs-1;
				CheckCommentThumbsup = 0; //parseInt(response);
				$(".CommentLikeImage_"+cnt+"").removeAttr("onclick") //클릭 속성 제거
				$(".CommentLikeImage_"+cnt+"").attr("onclick", "commentThumbsup("+CheckCommentThumbsup+", "+commentNum+", "+totalThumbs+", "+cnt+")") //클릭 속성 내 Check~값 변경
				$(".CommentLikeImage_"+cnt+"").html("<i class='far fa-heart'></i> 좋아요 "+totalThumbs+"개 ")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} // error end
		}); // ajax end
	}// else end
	return true;
}

// 컨텐츠 클릭시 작성자 프로필 이미지 추출
function FunctionGetContentProfileImage(postID){
	var profileImage = "";
	$.ajax({ 
		url: "/getprofileimage",
		type: "post",
		data: {"id" : postID},
		dataType: "text",
 		async: false,
		success: function(response){
			if(response=="0"){ //프로필 사진이 없을 때
				profileImage = '/images/basicprofileimage.jpg';
				return profileImage;
			}
			else {
				var imagePath = response.split("/")
				//console.log("경로 : "+ imagePath)
				var imageName = imagePath[imagePath.length-1]
				//console.log("이미지이름 : "+ imageName)
				profileImage = '/profile/'
				profileImage += imageName
			} // else end
		},
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}//error end
	}); //ajax end
	return profileImage;
}// function end

//서치 돋보기 클릭시 서치값 같이 넘김
function wordsearch(){
	var f = document.searchForm;
	f.submit();
}//function end

//댓글 달기
function FunctionCommentThumbs(){
	var myComment = $("#myComment").val() //댓글입력창의 값을 추출
	if(myComment == null || myComment.trim() == ""){ //댓글입력창에 값이 없을 경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("댓글을 작성하시겠습니까?")){
		var id = myid
		var postNum = postNum		
		$.ajax({
			url: "/addcomment",
			type: "post",
			data : {
				"postNum": postNum,
				"comments": myComment,
				"id" : myid
			},
			dataType : "text",
			success : function(response){
				//console.log(response)
				var commentList = []
				$(".OneComment").text("") // 댓글창 초기화				
				FunctionGetComment(postNum, commentList)
				$("#myComment").val("") //댓글 등록후 작성창에 내용 삭제
				alert("댓글 작성이 완료되었습니다.")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}

//댓글 수정 및 삭제
var cntCommentNum = 0; //넘어온 댓글 번호
var cntNum = 0; // 넘어온 댓글의 일련번호(?)
function FunctionEditComment(id, commentNum, cnt){ // 댓글 옆 ... 누르기
	if(id!=myid){
		alert("수정 및 삭제 권한이 없습니다.")
	} else {
		$(".commentEditModal").css("display", "flex");
		$(".commentEditModal").fadeIn();
		editmodalState=1;
		cntCommentNum = commentNum;
		cntNum = cnt; 
	}
}

function updateEnterkey(){
	if(window.event.keyCode == 13){
		UpdateComment();
	}
}
function gotoUpdateComment(){ // 댓글 수정창 띄우기
	if(confirm("댓글을 수정하시겠습니까?")){
		$("#cdelete").fadeOut();
		$("#updateMyComment").html(
		"<input id='commentupdatebox' type='text' value='"+$("#contents_"+cntNum+"").text()+"' onkeyup='updateEnterkey()'>"+
		"<input id='sendBtn' type='button' value='작성' onclick='UpdateComment()'>")
		console.log(postNum)
	}
}

function UpdateComment(){ //댓글 수정하기
	var update = String($("#commentupdatebox").val()) //댓글입력창의 값을 추출
	if(update == null || update.trim() == ""){ //댓글입력창에 값이 없을 경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("댓글을 수정하시겠습니까?")){
		console.log(postNum, update, myid, cntCommentNum)
		$.ajax({
			url: "/updatecomment",
			type: "post",
			data : {
				"postNum": postNum,
				"comments": update,
				"id" : myid,
				"commentNum" : cntCommentNum
			},
			dataType : "text",
			success : function(){
				var commentList = []
				$(".modalComment").text("") // 댓글창 초기화				
				FunctionGetComment(postNum, commentList)
				$("#myComment").val("") //댓글 등록후 작성창에 내용 삭제
				alert("댓글 수정이 완료되었습니다.")
				modalContentClick()			
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}

function DeleteComment(){ // 댓글 삭제하기
	console.log(myid, cntCommentNum)
	if(confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url: "/deletecomment",
			type: "post",
			data: {
				"id" : myid,
				"commentNum" : cntCommentNum
			},
			dataType: "text",
			success: function(){
				alert("삭제가 완료되었습니다.")
				var blankList = []
				$(".modalComment").html("")
 				FunctionGetComment(postNum, blankList)
 				modalContentClick()	
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}// error end
		})//ajax end
	}//if end
}//function end

//답글 불러오기
function FunctionGetReply(commentNum, cnt){
	$.ajax({
		url: "/getreply",
		type: "post",
		data: {
			"commentNum" : commentNum,
			"postNum" : postNum
		},
		//asyns: false,
		dataType: "json",
		success: function(response){
			var list = [];
			for(var i in response){
				list.push(response[i])
			}//for end
			
			if(list.length!=0){
				for(var i=0; i<list.length; i++){
					var profileImagePath = FunctionGetContentProfileImage(list[i].id)

					var result = getReplyTotal(list[i].replyNum, i)
					var total = result[0]; // 총 좋아요 개수
					var RTState = result[1]; //좋아요 여부
					$("#seeReply_"+cnt+"").text("답글 "+list.length+"개");
					$("#replyList_"+cnt+"").append(
					"<div class=Reply1>"+
						"<div class=Reply1-1>"+
				            "<div class=oneReplyProfileImage>"+
				            	"<img class=commentImage src='"+profileImagePath+"' onclick=location.href='/profile?id="+list[i].id+"'>"+
				            "</div>"+
			            "</div>"+ // Reply1-1
			            "<div class=Reply1-2>"+
				            "<div class=ReplyIDX>"+
				                "<div class=ReplyID>"+
				             	   "<p id=ReplyID onclick=location.href='/profile?id="+list[i].id+"'>"+list[i].id+"</p>"+
				                "</div>"+
				                "<div class=ReplySet onclick='FunctionEditReply(\""+list[i].id+"\", "+list[i].replyNum+", "+cnt+", "+list[i].commentNum+", "+i+")'>"+
				                	"<i class='fas fa-ellipsis-h' id=ReplySet></i>"+
				                "</div>"+
				            "</div>"+
				            "<div class=ReplyDate>"+
				            	"<p id=ReplyDate>"+list[i].commentsDate+"</p>"+
				            "</div>"+			            	
			            "</div>"+ // Reply1-2
			        "</div>"+
			        "<div class=Reply2>"+
			            "<div class=ReplyContents id='replycomments_"+i+"'><p>"+list[i].comments+"</p></div>"+
			            "<div class=ReplyBox>"+
			                "<div class=ReplyLike>"+
			                    "<div class=ReplyLikeImage_"+i+" onclick='ClickReplyThumbsup("+list[i].replyNum+", "+i+")'></div>"+
			                    "<div class=ReplyTotalLike_"+i+"></div>"+
			                "</div>"+
			            "</div>"+
			        "</div>")	
					
					getReplyThumbsup(list[i].replyNum, i)
				}//for end
			}//if end
		},
		error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}//error end
	});
	$("#replyList_"+cnt+"").css("display","none")
// 	commentNum: 121 / comments: "대댓글1" / commentsDate: "2021-06-10 01:22:42" / id: "aiu10"/ postNum: 37 / replyNum: 1
// reply thumbsup > replyThumbsupNum / id / replyNum
} //function end

// 답글(대댓글) 보이기 / 숨기기
var ReplyDivState = 0;
function ShowReply(cnt){
	if(ReplyDivState==0){
		$("#replyList_"+cnt+"").css("display", "flex");	
		ReplyDivState = 1;
	} else {
		$("#replyList_"+cnt+"").css("display", "none");
		ReplyDivState = 0;
	}
}


//답글 수정 및 삭제
var cntReplyNum = 0; //넘어온 답글 번호
var cntRep = 0; // 넘어온 답글 일련번호 (cnt)
var cntRepCommentNum = 0;  // 넘어온 댓글 번호
var cntRepList = 0; // 넘어온 답글 번호
function FunctionEditReply(id, replyNum, cnt, commentNum, i){ // 댓글 옆 ... 누르기
	if(id!=myid){
		alert("수정 및 삭제 권한이 없습니다.")
	} else {
		$(".replyEditModal").css("display", "flex")
		$(".replyEditModal").fadeIn();
		editmodalState=1;
		cntReplyNum = replyNum;
		cntRep = cnt; 
		cntRepCommentNum = commentNum;
		cntRepList = i; 
	}
}

function replyUpdateEnterkey(){
	if(window.event.keyCode == 13){
		UpdateReply();
	}
}
function gotoUpdateReply(){ // 답글 수정창 띄우기
	if(confirm("답글을 수정하시겠습니까?")){
		//$("#redit").fadeOut();
		$("#rdelete").fadeOut();
		$("#updateMyReply").html(
		"<input id='replyupdatebox' type='text' value='"+$("#replycomments_"+cntRepList+"").text()+"' onkeyup='replyUpdateEnterkey()'>"+
		"<input id='sendBtn' type='button' value='작성' onclick='UpdateReply()'>")
	}
}

function UpdateReply(){ //답글 수정하기
	var update = String($("#replyupdatebox").val()) //답글입력창의 값을 추출
	if(update == null || update.trim() == ""){ //답글입력창에 값이 없을 경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("답글을 수정하시겠습니까?")){
		$.ajax({
			url: "/updatereply",
			type: "post",
			data : {
				"postNum": postNum,
				"comments": update,
				"id" : myid,
				"replyNum" : cntReplyNum
			},
			dataType : "text",
			success : function(){
				$("#replyList_"+cntRep+"").text("")				
				FunctionGetReply(cntRepCommentNum, cntRep)
				$("#myComment").val("") //댓글 등록후 작성창에 내용 삭제
				alert("답글 수정이 완료되었습니다.")
				modalContentClick()			
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}//function end

function DeleteReply(){ // 답글 (대댓글) 삭제하기
	if(confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url: "/deletereply",
			type: "post",
			data: {
				"id" : myid,
				"replyNum" : cntReplyNum
			},
			dataType: "text",
			success: function(){
				alert("삭제가 완료되었습니다.")
				var blankList = []
				$(".modalComment").html("")
 				FunctionGetComment(postNum, blankList)
 				modalContentClick()	
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}// error end
		})//ajax end
	}//if end
}//function end


// 답글 남기기
var writeReplyState = 0;
function writeReply(commentNum, cnt){ //commentID, 
	if(writeReplyState==0){
		$("#reply_"+cnt+"").html("답글취소");
		$("#replyBox_"+cnt+"").html(
		"<input type='text' class='writeReply' placeholder='답글을 입력하세요' onkeyup='Replyenterkey("+commentNum+", "+cnt+")'>"+
		"<input class='replyBtn' type='button' value='작성' onclick='addReply("+commentNum+", "+cnt+")'>");
		$(".replyBox").on('click', function(e){
			e.preventDefault();
			e.stopPropagation();
		});	
		writeReplyState = 1;
	} else {
		$("#reply_"+cnt+"").html("답글달기")
		$("#replyBox_"+cnt+"").html("")
		writeReplyState = 0;
	}
}


// 답글 남길때 엔터키 누르기
function Replyenterkey(commentNum, cnt){
	if(window.event.keyCode == 13){
		addReply(commentNum, cnt);
	}
}// function end

// 답글 추가하기
function addReply(commentNum, cnt){
	var text = $(".writeReply").val(); // 답글입력창 값 추출
	if(text == null || text.trim() == ""){ // 입력창에 값이 없을경우
		alert("내용을 입력해주세요!")
	}
	else if(confirm("답글을 작성하시겠습니까?")){
		$.ajax({
			url: "/addreply",
			type: "post",
			data:{
				"postNum": postNum,
				"commentNum": commentNum,
				"comments": text,
				"id": myid
			},
			success:function(response){
				$("#replyList_"+cnt+"").text("") // 답글창 초기화
				FunctionGetReply(commentNum, cnt) // 답글 불러오기 함수
				alert("답글 작성이 완료되었습니다.")
				$(".writeReply").val("") //답글 등록후 작성창에 내용 삭제
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}// error end
		}) //ajax end
	}// if end
}

function getReplyTotal(replyNum, i){ //답글 좋아요 개수 불러오기
	var total = 0;
	var ReplyThumbsupState = 0
	$.ajax({
		url: "/getreplythumbsup",
		type: "post",
		data: {
			"replyNum" : replyNum
		},
		async: false,
		dataType: "json",
		success: function(response){
			total = response.length;
			for(var i=0; i<response.length; i++){
				if(response[i].id == myid){
					ReplyThumbsupState = 1	
				}//if end
			}//for end
// 			list.push(total)
// 			list.push(ReplyThumbsupState)
		},
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}// error end
	}) // ajax end
	return {total, ReplyThumbsupState};
}

function getReplyThumbsup(replyNum, i){ //답글에 좋아요 불러오기
	var cnt = i; // 답글 일련번호(?)
	var total = 0;
	var ReplyThumbsupState = 0;
	$.ajax({
		url: "/getreplythumbsup",
		type: "post",
		data: {
			"replyNum" : replyNum
		},
		dataType: "json",
		success: function(response){
			total = response.length;
			for(var i=0; i<response.length; i++){
				if(response[i].id == myid){
					ReplyThumbsupState = 1	
				}//if end
			}//for end
			if(ReplyThumbsupState == 0){
				$(".ReplyLikeImage_"+cnt+"").html("<i class='far fa-heart'></i> 좋아요 "+total+"개")
// 				$(".ReplyTotalLike_"+cnt+"").html("좋아요 "+total+"개")
			}//if end
			else if(ReplyThumbsupState = 1){ // 이미 좋아요를 눌러뒀음
				$(".ReplyLikeImage_"+cnt+"").html("<i class='fas fa-heart'></i> 좋아요 "+total+"개")
// 				$(".ReplyTotalLike_"+cnt+"").html("좋아요 "+total+"개")
			}//else if end		
		},
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}// error end
	}) // ajax end
} //function end

//답글 좋아요 누르기
function ClickReplyThumbsup(replyNum, i){
	getReplyTotal(replyNum, i) // [total, ReplyThumbsupState]
	var total = getReplyTotal(replyNum, i).total
	var ReplyThumbsupState = getReplyTotal(replyNum, i).ReplyThumbsupState
	if(ReplyThumbsupState == 0){ //좋아요가 눌려져 있지 않은 경우
		$.ajax({
			url: "/replythumbsplus",
			type: "get",
			data: {
				"replyNum" : replyNum,
				"id" : myid
			},
			async: false,
			success: function(){
				var cntTotal = total+1;
				$(".ReplyLikeImage_"+i+"").removeAttr("onclick") //클릭 속성 제거
 				$(".ReplyLikeImage_"+i+"").attr("onclick", "ClickReplyThumbsup("+replyNum+", "+i+")") //클릭 속성 내 Check~값 변경
				$(".ReplyLikeImage_"+i+"").html("<i class='fas fa-heart'></i> 좋아요 "+cntTotal+"개")
// 				$(".ReplyTotalLike_"+i+"").html("좋아요 "+cntTotal+"개")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}// error end
		}); // ajax end
	}// if end
	else if(ReplyThumbsupState == 1){ //좋아요가 눌려있는경우
		$.ajax({
			url: "/replythumbsminus",
			type: "get",
			data: {
				"replyNum" : replyNum,
				"id" : myid
			},
			success: function(){
				var cntTotal = total-1;				
	 			$(".ReplyLikeImage_"+i+"").removeAttr("onclick") //클릭 속성 제거
	 			$(".ReplyLikeImage_"+i+"").attr("onclick", "ClickReplyThumbsup("+replyNum+", "+i+")") //클릭 속성 내 Check~값 변경
				$(".ReplyLikeImage_"+i+"").html("<i class='far fa-heart'></i> 좋아요 "+cntTotal+"개")
// 				$(".ReplyTotalLike_"+i+"").html("좋아요 "+cntTotal+"개")
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}// error end
		}); // ajax end
	}// else if end
}// function end	

///////////////////////////////여기까지 모달 관련 코드///////////////////////////////////

			function postModalClick(){
				$(".postModal").fadeOut();
				$("body").css("overflow-y", "scroll")
				$("html").css("overflow-y", "scroll")
			}//postModalClick() end	
		
var contents = ""; //팔로워 저장하는 리스트
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
		dataType: "json",
		processData: false,	// data 파라미터 강제 string 변환 방지!!
		contentType: false,	// application/x-www-form-urlencoded; 방지!!
		success: function (response) {
			//console.log(response) //{filename: "eunsu.jpg"}
			var fileName = response.filename
			console.log(fileName)
			//sessionStorage.setItem("updateProfileImg", fileName)
			
//				var json = JSON.parse(response)
//				var fileName = json.fileName
//				console.log(json.fileName);  //undefined
			
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
	success: function (response) {
				alert("프로필 사진을 저장했습니다!")
	},
	error: function (request, status, error) {
		//alert("success에 실패 했습니다.");
		alert("프로필 이미지를 등록해주세요!")
		console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error); //200에러 
	}
});	//ajax end


} //updateProfileImage() end
function follow(){
	var from_user = sessionStorage.getItem("user")
	var to_user = getParam("id")
	
	$.ajax({
		url: '/follow',
		type: 'post',
		data: {"from_user": from_user, "to_user": to_user},
		dataType: "json",
		success: function(response){
			alert(response.data)
		}
	})
}
</script>	
</head>
<body>

				<div id="main">
					<div id="mainPBox0">
					
					
					
					
		<!-- 프로필과 게시물 영역 구분 -->
						<svg class="line" >
							<path id="line" d="M 0 0 L 1920 0" style="display:none;">
							</path>
						</svg>
						
	<!-- <1> 회원 간단 정보(DB) - 고정 : 프로필 사진 | 회원 아이디 | 프로필 편집  -->
				<div id="mainPBox1">
					<div class="profilePBox">
					
					
					<!-- 프로필 이미지 박스  -->
						<div class="profileimgbox">
								 
							<!-- 프로필 이미지 라인 -->
<!-- 								<svg class="roundBright"> -->
<!-- 									<rect id="roundBright" rx="137.5" ry="137.5" x="0" y="0" width="275" height="275"> -->
<!-- 									</rect> -->
<!-- 								</svg> -->
								
							<!-- 이미지 -->

									<div id="uploadSettingBox">
										<canvas id="imagecanvas" width=250 height=250></canvas>
<!-- 									<img id="unnamed_2" src="unnamed_2.png" srcset="unnamed_2.png 1x, unnamed_2@2x.png 2x"> -->								
										<span><img id="upload" src="/profileImage/uploadicon.png" ></span>
										<span><button id="settingprofile" onclick="saveProfileImage()"><img id="save" src="/profileImage/saveicon.png" ></button></span>
									
							
							<!-- 캔버스 -->
<!-- 							<svg class="roundLine"> -->
<!-- 								<ellipse id="roundLine" rx="7.6vw" ry="7.6vw" cx="7.77vw" cy="7.77vw"> -->
<!-- 								</ellipse> -->
<!-- 							</svg> -->
								
							<!-- 파일 업로드 라벨 -->

<!-- 							<svg class="Heart" viewBox="0.025 0.025 54.201 47.83"> -->
								
<!-- 								<path id="Heart" d="M 49.89359664916992 4.357705116271973 C 44.11665725708008 -1.419235110282898 34.94151306152344 -1.419235110282898 29.16457176208496 4.357705116271973 L 27.12564849853516 6.396624565124512 L 25.08672904968262 4.357705116271973 C 19.30978775024414 -1.419234871864319 10.13464736938477 -1.419234871864319 4.357705593109131 4.357705116271973 C -1.419235467910767 10.13464832305908 -1.419235467910767 19.30978584289551 4.357705593109131 25.08672523498535 L 27.12564849853516 47.85467529296875 L 49.89359664916992 25.08672714233398 C 55.6705322265625 19.30978584289551 55.6705322265625 10.13464832305908 49.89359664916992 4.357705116271973"> -->
<!-- 								</path> -->
<!-- 							</svg> -->
							
							
							<!-- 이미지 업로드 구현 -->	
							<form name="imageform" id="imageform" ENCTYPE="multipart/form-data" method="post">
								<label id="fileimage" for="inputProfile"><img id="plus" src="/profileImage/plus.png"></label>
								<input name="file" type="file" id="inputProfile" style="display:none;" ><br>
								<input type="hidden" name ="target_url">
							</form>
							
							</div>
						</div>
						
				</div>
								
								
								
							
				<!-- 프로필 사진 옆 프로필 정보들 -->
							<div id="idFontPBox">
								<div class="idFontBox">
								
							<!-- 회원아이디, 프로필 편집 줄 --> 	
									<div id="accountBox">
										<span id="accountId"> &nbsp; </span>
        								<span><button type="button" id="profileedit" onclick="location.href='profile/editform'">&nbsp;프로필 편집</button></span>
									</div>
									
							<!-- 게시물 | 팔로워 | 팔로우 수는 저장된 데이터의 수 그대로 불러오기 -->
									<div id="pff">
										<span class="secondline" id="profileposts">&nbsp;게시물&nbsp; </span>
				        				<span class="secondline" id="follower">&nbsp;팔로워 &nbsp; </span>
				        				<span onclick="follow()" class="secondline" id="follow">&nbsp;팔로우 &nbsp; </span>
									</div>
									
							<!-- 게시물 업로드 줄 -->
									<div id="postupload">
										<span><button><label id="postfont"> 게시물 업로드 </label></button></span>
									</div>
									
							<!-- 프로필 편집 창에서 입력한 소개글 DB 저장 그대로 불러와 -->
									<div id="introduction">
										<span>회원이 작성한 소개글</span>
									</div>
								</div>
								
								
								<svg class="space0">
									<rect id="space0" rx="0" ry="0" x="0" y="0" width="99" height="280">
									</rect>
								</svg>
							</div>
							

<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->							
							
							
				<!-- 북마크 -->
							<div id="bookmarkPbox0">
								<div id="bookmarkPbox1">
									<div id="bookmarkPbox2">
										<svg class="markRoundShadow">
											<rect id="markRoundShadow" rx="4.2206vw" ry="4.2206vw" x="0" y="0" width="8.4597vw" height="8.4597vw">
											</rect>
										</svg>
										<svg class="bookmarkRBox" viewBox="0 0 162.427 162.427">
											<path id="bookmarkRBox" d="M 81.21342468261719 0 C 126.0663833618164 0 162.4268493652344 36.3604850769043 162.4268493652344 81.21342468261719 C 162.4268493652344 126.0663833618164 126.0663833618164 162.4268493652344 81.21342468261719 162.4268493652344 C 36.3604850769043 162.4268493652344 0 126.0663833618164 0 81.21342468261719 C 0 36.3604850769043 36.3604850769043 0 81.21342468261719 0 Z">
											</path>
										</svg>
										<svg class="markRoundBright" viewBox="0 0 200 200">
											<path id="markRoundBright" d="M 81.21342468261719 0 C 126.0663833618164 0 162.4268493652344 36.3604850769043 162.4268493652344 81.21342468261719 C 162.4268493652344 126.0663833618164 126.0663833618164 162.4268493652344 81.21342468261719 162.4268493652344 C 36.3604850769043 162.4268493652344 0 126.0663833618164 0 81.21342468261719 C 0 36.3604850769043 36.3604850769043 0 81.21342468261719 0 Z">
											</path>
										</svg>
									</div>
								</div>
								<svg class="bookmark2" viewBox="6 0 40 64">
									<path id="bookmark2" d="M 42 64 L 26.00000190734863 41.99999618530273 L 10.00000095367432 64 C 7.792000293731689 64 6.000001430511475 62.20800018310547 6.000001430511475 59.99999618530273 L 6.000001430511475 4 C 6.000001430511475 1.791999936103821 7.792000293731689 0 10.00000095367432 0 L 42 0 C 44.20800399780273 0 46.00000381469727 1.791999936103821 46.00000381469727 4 L 46.00000381469727 59.99999618530273 C 46.00000381469727 62.20800018310547 44.20800399780273 64 42 64 Z M 41.00000381469727 4 L 11.00000095367432 4 C 10.44800090789795 4 10.00000095367432 4.447999477386475 10.00000095367432 5 C 10.00000095367432 5.551999568939209 10.44800090789795 5.999999523162842 11.00000095367432 5.999999523162842 L 41.00000381469727 5.999999523162842 C 41.55199813842773 5.999999523162842 42 5.551999568939209 42 5 C 42 4.447999477386475 41.55199813842773 4 41.00000381469727 4 Z">
									</path>
								</svg>
							</div>
							
							
							
							
							
				<!-- 스토리 하이라이트 -->
							<div class="space1"></div>
								<div class="subImgPBox">
									<div id="subImgBox">
									<!-- img {{id}} 1~6 |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| -->
<!-- 											<img id="subImg1" src="unnamed.png" srcset="/profileImage/unnamed.png 1x, unnamed@2x.png 2x"> -->
<!-- 											<img id="subImg2" src="/profileImage/charlie-and-the-chocolate-fact.png" srcset="charlie-and-the-chocolate-fact.png 1x, charlie-and-the-chocolate-fact@2x.png 2x"> -->
<!-- 											<img id="subImg3" src="/profileImage/p213.png" srcset="p213.png 1x, p213@2x.png 2x"> -->
<!-- 											<img id="subImg4"  src="/profileImage/v7d54yxm8g5v5099e65k.png" srcset="v7d54yxm8g5v5099e65k.png 1x, v7d54yxm8g5v5099e65k@2x.png 2x"> -->
<!-- 											<img id="subImg5" src="/profileImage/ID990BEA335B3490DD32.png" srcset="ID990BEA335B3490DD32.png 1x, ID990BEA335B3490DD32@2x.png 2x"> -->
<!-- 											<img id="subImg6" src="/profileImage/unnamed_1.png" srcset="unnamed_1.png 1x, unnamed_1@2x.png 2x"> -->
									</div>
									
									<div id="subImgFont">
										<div id="working">
											<span></span>
										</div>
										<div id="dancing">
											<span></span>
										</div>
										<div id="qwee">
											<span></span>
										</div>
										<div id="TT">
											<span></span>
										</div>
										<div id="LOL">
											<span></span>
										</div>
										<div id="aiii">
											<span></span>
										</div>
									</div>
					
								</div>
								
								
								
								<div class="space2"></div>
							</div>


<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	<!-- 게시물 버튼과 게시물 보여주기 -->

				<!-- 게시물 바로 위 버튼들 -->
							<div id="mainboardPBox">
							
							
								<!-- 게시물 목록들 수직정렬 -->
								<svg class="dashboard1" viewBox="0 0 53.119 52.118">
									<path id="dashboard1" d="M 0 0 L 0 13.02941513061523 L 53.11922454833984 13.02941513061523 L 53.11922454833984 0 L 0 0 Z M 9.959855079650879 9.772060394287109 L 3.31995153427124 9.772060394287109 L 3.31995153427124 3.257353782653809 L 9.959855079650879 3.257353782653809 L 9.959855079650879 9.772060394287109 Z M 0 32.57353591918945 L 53.11922454833984 32.57353591918945 L 53.11922454833984 19.54412078857422 L 0 19.54412078857422 L 0 32.57353591918945 Z M 3.31995153427124 22.80147552490234 L 9.959855079650879 22.80147552490234 L 9.959855079650879 29.31618118286133 L 3.31995153427124 29.31618118286133 L 3.31995153427124 22.80147552490234 Z M 0 52.11766052246094 L 53.11922454833984 52.11766052246094 L 53.11922454833984 39.08824157714844 L 0 39.08824157714844 L 0 52.11766052246094 Z M 3.31995153427124 42.3455924987793 L 9.959855079650879 42.3455924987793 L 9.959855079650879 48.86029815673828 L 3.31995153427124 48.86029815673828 L 3.31995153427124 42.3455924987793 Z">
									</path>
									
									
									
								</svg>
									<div id="dashboard1Button" >
									</div>
									
									
								<!-- 게시물 목록들 수평, 수직 정렬 --> 	
								<svg class="dashboard2">
									<rect id="dashboard2" rx="0" ry="0" x="0" y="0" width="55" height="55">
									</rect>
								</svg>
								<div class="dashboard2Box">
									<svg class="dashboard2sub1">
										<rect id="dashboard2sub1" rx="2" ry="2" x="0" y="0" width="20.625" height="20.625">
										</rect>
									</svg>
									<svg class="dashboard2sub2">
										<rect id="dashboard2sub2" rx="2" ry="2" x="0" y="0" width="20.625" height="20.625">
										</rect>
									</svg>
									<svg class="dashboard2sub3">
										<rect id="dashboard2sub3" rx="2" ry="2" x="0" y="0" width="20.625" height="20.625">
										</rect>
									</svg>
									<svg class="dashboard2sub4">
										<rect id="dashboard2sub4" rx="2" ry="2" x="0" y="0" width="20.625" height="20.625">
										</rect>
									</svg>
								</div>
								
								
								
								
									<div id="dashboard2Button" >
									</div>
									
									
								
								<!-- 잉? 뭐에다 쓰지? -->
								<svg class="dashboard3" viewBox="0 0 55.119 41.339">
									<path id="dashboard3" d="M 51.44460678100586 3.172242202253983e-08 C 52.36326217651367 3.172242202253983e-08 53.28191375732422 0.4593269824981689 53.74124526977539 0.9186539649963379 C 54.65989685058594 1.837307810783386 55.11922454833984 2.296634674072266 55.11922454833984 3.674615621566772 L 55.11922454833984 38.12413787841797 C 55.11922454833984 39.04279327392578 54.65989685058594 39.96144485473633 54.20056915283203 40.42076873779297 C 53.28191757202148 40.88009643554688 52.82259368896484 41.33942413330078 51.44460678100586 41.33942413330078 L 3.674614906311035 41.33942413330078 C 2.296634674072266 41.33942413330078 1.837307453155518 40.88009643554688 0.9186537265777588 40.42076873779297 C 0.4593268632888794 39.50211715698242 0 39.04279327392578 0 37.66481018066406 L 0 3.674615621566772 C 0 2.755961894989014 0.4593268632888794 1.837307810783386 0.9186537265777588 1.377981066703796 C 1.837307453155518 0.4593269824981689 2.296634674072266 3.172242202253983e-08 3.674614906311035 3.172242202253983e-08 L 51.44460678100586 3.172242202253983e-08 Z M 15.61711597442627 8.267884254455566 C 14.69845962524414 7.349231243133545 13.32047939300537 6.889904022216797 11.94249820709229 6.889904022216797 C 10.56451797485352 6.889904022216797 9.186538696289063 7.349231243133545 8.267884254455566 8.267884254455566 C 7.34922981262207 9.186538696289063 6.88990306854248 10.56451988220215 6.88990306854248 11.94250011444092 C 6.88990306854248 13.32048034667969 7.34922981262207 14.69846057891846 8.267884254455566 15.61711692810059 C 9.186537742614746 16.53576850891113 10.56451797485352 16.99509620666504 11.94249820709229 16.99509620666504 C 13.32047843933105 16.99509620666504 14.69845962524414 16.53576850891113 15.61711406707764 15.61711692810059 C 16.53576850891113 14.69846057891846 16.99509620666504 13.32048034667969 16.99509620666504 11.94250011444092 C 16.99509620666504 10.56451988220215 16.53576850891113 9.186538696289063 15.61711597442627 8.267884254455566 Z M 48.22932434082031 34.44952011108398 L 34.44952011108398 13.77980804443359 L 22.04769325256348 29.85625267028809 L 13.77980613708496 23.88500022888184 L 6.88990306854248 34.44952011108398 L 48.22932434082031 34.44952011108398 Z">
									</path>
								</svg>
								
								
									<div id="dashboard3Button" >
									</div>
									
								
								
								<!-- 검색창과 연결 -->	
								<svg class="searchBar">
									<rect id="searchBar" rx="12" ry="12" x="0" y="0" width="567" height="85">
									</rect>
								</svg>
								
								
									<div id="searchBarButton" >
									</div>
								<svg class="searchIcon" viewBox="0 0 66 65.253">
									<path id="searchIcon" d="M 66 59.50708770751953 L 52.30187225341797 45.96408843994141 C 56.0377197265625 41.03936004638672 58.11320495605469 35.29383850097656 58.11320495605469 28.72755241394043 C 58.11320495605469 12.72220230102539 45.24527359008789 -3.551532046230932e-08 29.05660247802734 -3.551532046230932e-08 C 12.86792469024658 -3.551532046230932e-08 0 12.72220230102539 0 28.72755241394043 C 0 44.73291015625 12.86792469024658 57.45510482788086 29.05660247802734 57.45510482788086 C 35.69809341430664 57.45510482788086 41.50942230224609 55.40312957763672 46.49055862426758 51.7095832824707 L 60.18868255615234 65.25257873535156 L 66 59.50708770751953 Z M 8.301884651184082 28.72755241394043 C 8.301884651184082 17.23652648925781 17.43396186828613 8.207873344421387 29.05660247802734 8.207873344421387 C 40.67925262451172 8.207873344421387 49.81130599975586 17.23652648925781 49.81130599975586 28.72755241394043 C 49.81130599975586 40.21857452392578 40.67925262451172 49.24724578857422 29.05660247802734 49.24724578857422 C 17.43396186828613 49.24724578857422 8.301884651184082 40.21857452392578 8.301884651184082 28.72755241394043 Z">
									</path>
								</svg>
								
								
									<div id="searchButton" >
									</div>
									
									
								<svg class="space3">
									<rect id="space3" rx="0" ry="0" x="0" y="0" width="245" height="260">
									</rect>
								</svg>
								
							</div>
			
<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////			 -->
			
						
						
		<!-- 게시물 --> 
							<div id="post-container">
						
								 <div class="flex-container">
						            <div class="flex-item" id="card-body"></div>
						        </div>
						         
							</div>       	
			
			
						<div class="postModal" onclick="postModalClick()">
							<div class="postModalContent" onclick="postModalContentClick()">
							</div>
						</div>
			

			
					</div>
				</div>
</div>
	
	<!-- 모달창 띄우기 -->
	
	<div class="modal" onclick="modalClick()">
		<div class="modalContent" onclick="modalContentClick()">
		</div>
	</div>
	
	<div class="commentEditModal">
	  <div id="cedit" onclick='gotoUpdateComment()'><p class=cedit>댓글 수정</p></div>
	  <div id="cdelete" onclick='DeleteComment()'><p class=cedit>댓글 삭제</p></div>
	  <div id='updateMyComment'></div> <!-- 0.5초 또는 1초 있다가 나오게 변경해야할듯 -->
	</div>
		
	<div class="replyEditModal">
	  <div id="redit" onclick='gotoUpdateReply()'><p class=redit>답글 수정</p></div>
	  <div id="rdelete" onclick='DeleteReply()'><p class=rdelete>답글 삭제</p></div>
	  <div id='updateMyReply'></div> <!-- 0.5초 또는 1초 있다가 나오게 변경해야할듯 -->
	</div>
	
	<i class="fas fa-arrow-circle-up fa-3x" id="goToTopBtn" onclick="window.scrollTo(0,0)"></i>

</body>
</html>