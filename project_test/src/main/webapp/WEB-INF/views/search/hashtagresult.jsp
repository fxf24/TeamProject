<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String hashtag = request.getParameter("hashtag");
	String id = (String)session.getAttribute("id");
%>

<!DOCTYPE html>
<html>
<script src="https://kit.fontawesome.com/5e5186ce3e.js" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>HashHershe</title>
<style>
.listImage{
	width:300px;
	height:300px;
}

.contentsImage{
	width:500px;
	height:500px;
}

.modal{ 
	position:absolute;
	width:100%; 
	height:100%; 
	background: rgba(0,0,0,0.8); 
	top:0; 
	left:0; 
	display:none; 
}

.modalContent{
  width:800px; height:800px;
  background:#fff; border-radius:10px;
  position:absolute; top:50%; left:50%;
  margin-top:-100px; margin-left:-200px;
  text-align:center;
  box-sizing:border-box; padding:74px 0;
  line-height:23px; cursor:pointer;
}

</style>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	//좋아요순, 최신순 화면 출력
	$("#favorite").on('click', function(){
		$("#thumbsupView").css("display", "block");
		$("#recentView").css("display", "none");
	});
	
	$("#recentUpdate").on('click', function(){
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

					if(i%3==0 || i%3==1){
						$(".thumbsupList").append
						//("<span class='thumbsupList'><img id='listimage' src='/upload/"+imageName[imageName.length-1]+"'></span>");
						("<img class='listImage' src='/upload/"+imageName[imageName.length-1]+"' onclick='clickimage("+postNumber+")'>");
					} else {
						$(".thumbsupList").append
						//("<span class='thumbsupList'><img id='listimage' src='/upload/"+imageName[imageName.length-1]+"'></span><br>");
						("<img class='listImage' src='/upload/"+imageName[imageName.length-1]+"' onclick='clickimage("+postNumber+")'><br>");
					} // else end
				} //for end
				
				
				//최신순으로 정렬
				var recentList = list.sort(function(a, b){
					return new Date(b.postDate) - new Date(a.postDate);
				});
// 				for(var i=0; i<recentList.length; i++){
//					console.log(recentList[i].postDate);					
//				}	
				for(var i=0; i<recentList.length; i++){
					var imageName = recentList[i].imagepath.split("/");
					var postNumber = thumbsupList[i].postNum
					if(i%3==2){
						$(".recentList").append
						("<img class='listImage' src='/upload/"+imageName[imageName.length-1]+"' onclick='clickimage("+postNumber+")'><br>");					
					} else {
						$(".recentList").append
						("<img class='listImage' src='/upload/"+imageName[imageName.length-1]+"' onclick='clickimage("+postNumber+")'>");
					} // else end
				} // for end
			}, // success end
			error : function(e){
					console.log(e);
				} // error end
		}); // ajax end
}); //ready function end

var CheckThumbsup = 0; //모달창을 띄웠을 때 기존에 좋아요를 눌렀는지 체크
var myid = "admin2"; // 현재 로그인한 아이디를 세션에서 받아옴, 현재 테스트용 admin으로 설정
var postNum = 0; // 클릭한 이미지의 포스트번호 저장
var totalThumbs = 0; // 총 좋아요 개수 저장
var contents = []; // 좋아요 누른 사람을 저장하는 리스트

function clickimage(postNumber){ // 이미지 클릭시 게시글 모달창으로 나타냄
	$(".modal").fadeIn();
	$(".modalContent").text("")
	postNum = parseInt(postNumber);
//	myid = "admin"; 
	
	$.ajax({ //전달받은 postNum 조회
		url :"/postnumsearch",
		type : "get",
		data : {"postNum" : postNum},
		dataType : "json",
		success : function(response){
			var contents = response[0];
			var imageName = contents.imagepath.split("/")
			var hashtag = contents.hashtag.split("#")
			hashtag.shift(0)
			//for(var i in hashtag){console.log(hashtag[i])}
			$(".modalContent").append("<div class='postDate'>게시일 : "+contents.postDate+"</div>");
			$(".modalContent").append("<div class='postID'>아이디 : <a href='/profile?id="+contents.id+"'>"+contents.id+"</a></div>");
			$(".modalContent").append("<div class='postImage'><img class='contentsImage' src='/upload/"+imageName[imageName.length-1]+"' ondblclick='thumbsup()'></div>"); // admin을 이후 세션 id값으로 변경
			$(".modalContent").append("<div class='postContents'>내용 : "+contents.contents+"</div>");
			$(".modalContent").append("<div class='postHashtag'></div>")
			for(var i in hashtag){
				$(".modalContent").append(
						$(".postHashtag").append(
								"<a class=hashtagLink href='https://search.shopping.naver.com/search/all?query="
						+hashtag[i]+"&cat_id=&frm=NVSHATC' target='_blank'>#"+hashtag[i]+"</a>&nbsp"));
			} // for end
			
			$.ajax({ // 좋아요 개수, 좋아요 누른 사람 반환
				url : "/thumbsupsearch",
				type : "get",
				data : {"postNum" : postNum},
				dataType : "json",
				success : function(response){
					contents = []
					CheckThumbsup = 0; //현재 게시물 좋아요를 눌렀는지 판단
					for(var i in response){
						contents.push(response[i]);
						console.log(contents)
						if(response[i].id == myid){ //현재는 admin 계정으로 간주, 이후 세션 id값으로 변경
							CheckThumbsup = 1; 							
						} //if end
					}//for end
					totalThumbs = contents.length; // 좋아요 개수
					//console.log(totalThumbs)
					if(CheckThumbsup == 0){ //좋아요가 눌려져 있지 않음
						$(".modalContent").append
						("<div class='#'><span class='thumbsupButton' onclick='thumbsup()'><i class='far fa-heart'></i></span>"+
						"<span class='postThumbsup'> 좋아요 : "+totalThumbs+"명이 좋아합니다.</span></div>");
					} else { //좋아요가 눌려져 있음
						$(".modalContent").append
						("<div class='#'><span class='thumbsupButton' onclick='thumbsup()'><i class='fas fa-heart'></i></span>"+
						"<span class='postThumbsup'> 좋아요 : "+totalThumbs+"명이 좋아합니다.</span></div>");						
					}// if else end	
				},
				error : function(e){
					console.log(e)
				} // error end 
			}); // inner ajax end
			
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
				$(".thumbsupButton").html("<i class='fas fa-heart'></i>")
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
				$(".thumbsupButton").html("<i class='far fa-heart'></i>")
			},
			error : function(e){
				console.log(e)
			} // error end
		}); // ajax end
	}
} // function thumbsup end


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


</script>
</head>
<body>
<h1>해시태그 검색 리스트</h1>
<form action="/search" method="post">
	<input type="text" id=searchbar name="searchWord" value=<%=hashtag %>>
	<input type="submit" value="search">
</form>
<span id=searchresult>#<%=hashtag %> </span><span>검색결과</span><br>
<span id=totalhashtag></span>

<div id="searchlist">
	<button id="favorite">인기 게시물</button>&nbsp;&nbsp;
	<button id="recentUpdate">최근 게시물</button>
</div>

<div id=thumbsupView style="background-color:#abcdef;
		width:1000px; height:1000px; overflow:scroll;">
	<div class="thumbsupBlock">
		<div class="thumbsupList"></div>
	</div>		
</div>

<div id=recentView style="display:none; background-color:yellow; 
	width:1000px; height:1000px; overflow:scroll;">
	<div class="recentBlock">
		<div class="recentList"></div>	
	</div>
</div>

<div class="modal" onclick="modalClick()">
	<div class="modalContent" onclick="modalContentClick()">
	</div>
</div>

<!-- <div class="thumbsupModal" onclick="thumbsupModal()"> -->
<!-- 	<div class="ifTotalZero"></div> -->
<!-- 	<div class="thumbsupTitle"></div> -->
<!-- 	<div class="thumbsupSearch"></div> -->
<!-- 	<div class="clickThumbsupIdList"> -->
<!-- 		<span class="profileImage"></span><span class="idList"></span> -->
<!-- 	</div> -->
<!-- </div> -->

</body>
<script type="text/javascript">
var count = 0;
window.onscroll = function(e){ //스크롤 바닥 감지
	//window height + window scroll Y 값이 document height보다 클 경우
	if((window.innerHeight + window.scrollY) >= document.body.offsetHeight){
		// Add Contents 
		count++;
		var addContent = "<div class='thumbsupList'></div>";
		$(".thumbsupList").append(addContent);
	}
}
</script>
</html>