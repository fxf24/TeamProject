<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String hashtag = request.getParameter("hashtag");
	//String id = (String)session.getAttribute("id");
%>

<!DOCTYPE html>
<html>
<script src="https://kit.fontawesome.com/5e5186ce3e.js" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<link href="/css/search/modal.css" rel="stylesheet" type="text/css">
<title>HashHershe</title>
<style>
.listImage{
	width:300px;
	height:300px;
}

</style>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	//좋아요순, 최신순 화면 출력
	$("#favoriteBtn").on('click', function(){
		$("#thumbsupView").css("display", "block");
		$("#recentView").css("display", "none");
	});
	
	$("#recentUpdateBtn").on('click', function(){
		$("#thumbsupView").css("display", "none");
		$("#recentView").css("display", "block");
	});
	
	var hashtagtest = "#"+$("#searchbar").val();
	var hashtagArr = []; //검색어의 중복을 방지하기 위한 array
//	var list = "";
		$.ajax({
			url :"/hashtagsearch",
			type : "get",
			data : {"hashtag" : hashtagtest},
			dataType : "json",
			success : function(response){
				console.log(response);
				var list = response;
				//console.log(response);
				var totalHashtag = list.length; //검색결과 총 갯수
				$("#totalhashtag").text(totalHashtag+"개 게시물");

				//좋아요순으로 정렬
				$(".thumbsupList").text("");
				var thumbsupList = list.sort(function(a, b){
					return b.thumbsup - a.thumbsup;
				});
				for(var i=0; i<thumbsupList.length; i++){
					var imageName = thumbsupList[i].imagepath.split("/");
					var postNumber = thumbsupList[i].postNum

					$(".thumbsupList").append
						("<div class=imageFrame><img class='listImage' src='/upload/"+imageName[imageName.length-1]+
								"' onclick='clickimage("+postNumber+")'></div>");
				} //for end
				
				
				//최신순으로 정렬
				var recentList = list.sort(function(a, b){
					return new Date(b.postDate) - new Date(a.postDate);
				});
				
				for(var i=0; i<recentList.length; i++){
					var imageName = recentList[i].imagepath.split("/");
					var postNumber = recentList[i].postNum
					
					$(".recentList").append
						("<div class=imageFrame><img class='listImage' src='/upload/"+imageName[imageName.length-1]+"' onclick='clickimage("+postNumber+")'></div>");					
				} // for end
			}, // success end
			error : function(e){
					console.log(e);
				} // error end
		}); // ajax end
}); //ready function end

var CheckThumbsup = 0; //모달창을 띄웠을 때 기존에 좋아요를 눌렀는지 체크
var myid = "ajenn"; // 현재 로그인한 아이디를 세션에서 받아옴, 현재 테스트용 admin으로 설정
//var myid = sessionStorage.getItem("user") //로그인한 아이디를 세션에서 받아오는 방법
var postNum = 0; // 클릭한 이미지의 포스트번호 저장
var totalThumbs = 0; // 총 좋아요 개수 저장
var contents = []; // 좋아요 누른 사람을 저장하는 리스트

function clickimage(postNumber){ // 이미지 클릭시 게시글 모달창으로 나타냄
	$(".modal").fadeIn();
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
			
			FunctionGetComment(postNum, commentList) // 댓글 가져오기
			
			$(".modalContent").append("<div class='postDate'>게시일 : "+contents.postDate+"</div>");
			$(".modalContent").append("<div class='postID'>아이디 : <a href='/profile?id="+contents.id+"'>"+contents.id+"</a></div>");
			$(".modalContent").append
				("<div class='postImage'>"+
				"<img class='contentsImage' src='/upload/"+imageName[imageName.length-1]+"' ondblclick='thumbsup()'></div>"+ // admin을 이후 세션 id값으로 변경
				"<div class=comments><div class=commentsTitle>댓글"+
				"<div class='commentsList'></div>"+
				"<div class='postComment'><input id='myComment' type='text' onkeyup='enterkey(\""+contents.postNum+"\")' placeholder='댓글을 입력하세요'>"+
	 			"<input id='commentBtn' type='button' value='작성' onclick='addComment(\""+contents.postNum+"\")'></div>"+
				"</div></div>")
			$(".modalContent").append("<p class='postContents'>내용 : "+contents.contents+"</p>");
			$(".modalContent").append("<div class='postHashtag'></div>")
			for(var i in hashtag){
				$(".modalContent").append(
						$(".postHashtag").append(
								"<a class=hashtagLink href='https://search.shopping.naver.com/search/all?query="
						+hashtag[i]+"&cat_id=&frm=NVSHATC' target='_blank'>#"+hashtag[i]+"</a>&nbsp"));
			} // for end			
			FunctionThumbsupSearch(postNum) // 좋아요 불러오기
		}, //success end
		error : function(e){
			console.log(e)
		} // error end
	}); //outer ajax end
}// function end

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
				$(".postThumbsup").text(" 좋아요 : "+totalThumbs+"명이 좋아합니다.")
				//console.log("토탈 : "+totalThumbs)
				$(".thumbsupButton").html("<i class='fas fa-heart fa-2x'></i>")
			},
			error : function(e){
				console.log(e)
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
				$(".postThumbsup").text(" 좋아요 : "+totalThumbs+"명이 좋아합니다.")
				//console.log("토탈 : "+totalThumbs)
				$(".thumbsupButton").html("<i class='far fa-heart fa-2x'></i>")
			},
			error : function(e){
				console.log(e)
			} // error end
		}); // ajax end
	}// else end
} // function thumbsup end


// 댓글 작성 기능
function addComment(postNum){
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
				$(".commentsList").text("")
				FunctionGetComment(postNum, commentList)
			},
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error
		}) //ajax end
	}//if end
}//addComment end

//엔터키 입력(a - 97  0 - 48 엔터키 - 13)하면 send  함수 동일 효과
function enterkey(postNum){
	if(window.event.keyCode == 13){
		addComment(postNum);
	}
}//function end


var modalStatus = 0; // 모달창을 클릭한 것인지, 배경을 클릭한 것인지 구분
function modalClick(){
	if(modalStatus==0){
		$(".modal").fadeOut();
	} else if(modalStatus==1) {
		modalStatus = 0;
	} // elseif end
} // modalClick end

function modalContentClick(){
	modalStatus = 1;
} // modalContentClick end


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
				$(".modalContent").append
				("<div class='thumbsupBox'><span class='thumbsupButton' onclick='thumbsup()'>"+
				"<i class='far fa-heart fa-2x'></i></span>"+
				"<span class='postThumbsup'> 좋아요 : "+totalThumbs+"명이 좋아합니다.</span></div>");
			} else { //좋아요가 눌려져 있음
				$(".modalContent").append
				("<div class='thumbsupBox'><span class='thumbsupButton' onclick='thumbsup()'>"+
				"<i class='fas fa-heart fa-2x'></i></span>"+
				"<span class='postThumbsup'> 좋아요 : "+totalThumbs+"명이 좋아합니다.</span></div>");						
			}// if else end	
		},
		error : function(e){
			console.log(e)
		} // error end 
	}); // inner ajax end
}

// 댓글 내용 반환 
function FunctionGetComment(postNum, commentList){
	$.ajax({ //댓글 불러옴
		url: "/getcomment",
		type: "post",
		data : {"postNum" : postNum},
		dataType : "json",
		success: function(response){
			for(var i=0; i<response.length; i++){
				//console.log(response[i])
				commentList.push(response[i])
			}
			//console.log(commentList)
			if(commentList.length==0){
				$(".commentsList").html("<p class=commentEmpty>댓글이 없습니다.</p>")
			} // if end
			else { // 댓글 불러오기
				// 프로필 사진 불러오기
				for(var i=0; i<commentList.length; i++){
					FunctionGetProfileImage(commentList[i])
				}// for end
			}
		},//success end
		error : function(e){
			console.log(e)
		}//error end
	})//ajax end
} //function end


// 댓글 프로필 이미지 반환, 내용 작성
function FunctionGetProfileImage(commentList){
	$.ajax({ 
		url: "/getprofileimage",
		type: "post",
		data: {"id" : commentList.id},
		dataType: "text",
		success: function(response){					
			if(response=="0"){ //프로필 사진이 없을 때
				profileImage = '/images/basicprofileimage.jpg';
			}
			else {
				var imagePath = response.split("/")
				//console.log("경로 : "+ imagePath)
				var imageName = imagePath[imagePath.length-1]
				//console.log("이미지이름 : "+ imageName)
				profileImage = '/upload/'
				profileImage += imageName
			}//else end

			$(".commentsList").append
			("<div><image class='commentImage' src='"+profileImage+"'>"+
			"<p class=oneComment>"+commentList.id+" : "+commentList.comments+"<br>작성일 : "+commentList.commentsDate+"</p></div>")
			console.log($('.commentsList').val())
		},
		error: function(e){
			console.log(e)
		}//error end
	})//ajax end	
}// function end

</script>
</head>
<body>
<h1>해시태그 검색 리스트</h1>
<form action="/search" method="post">
<div class="bar">
	<input type="text" id=searchbar name="searchWord" value=<%=hashtag %>>
<!-- 	<input type="submit" value="search"> -->
	<i class="fas fa-search fa-3x" id=fa-search type="submit"></i>
</div>
	
</form>
<span id=searchresult>#<%=hashtag %> </span><span>검색결과</span><br>
<span id=totalhashtag></span>

<div id="searchBtn">
	<button id="favoriteBtn">인기 게시물</button>&nbsp;&nbsp;
	<button id="recentUpdateBtn">최근 게시물</button>
</div>

<div id=thumbsupView>
	<div class="thumbsupBlock">
		<div class="thumbsupList"></div>
	</div>		
</div>

<div id=recentView>
	<div class="recentBlock">
		<div class="recentList"></div>	
	</div>
</div>

<div class="modal" onclick="modalClick()">
	<div class="modalContent" onclick="modalContentClick()">	
	</div>
</div>

</body>
</script>
</html>