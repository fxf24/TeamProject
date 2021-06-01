<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String hashtag = request.getParameter("hashtag");
%>
<!DOCTYPE html>
<html>
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
	})
	
	$("#recentUpdate").on('click', function(){
		$("#thumbsupView").css("display", "none");
		$("#recentView").css("display", "block");
	})
	
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
					console.log(i)
					if(i%3==0 || i%3==1){
						$(".thumbsupList").append
						//("<span class='thumbsupList'><img id='listimage' src='/upload/"+imageName[imageName.length-1]+"'></span>");
						("<img class='listImage' src='/upload/"+imageName[imageName.length-1]+"' onclick='clickimage("+postNumber+");'>");
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
						console.log(e)
					} // error end
			}) // ajax end
}); //ready function end

function clickimage(postNumber){ // 이미지 클릭시 게시글 모달창으로 나타냄
	$(".modal").fadeIn();
	$(".modalContent").text("")
	var postNum = parseInt(postNumber);
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
			for(var i in hashtag){console.log(hashtag[i])}
			$(".modalContent").append("등록일 : "+contents.postDate+"<br>");
			$(".modalContent").append("아이디 : <a href='/profile?id="+contents.id+"'>"+contents.id+"</a><br>");
			$(".modalContent").append("<img class='contentsImage' src='/upload/"+imageName[imageName.length-1]+"' onclick='thumbsup()'><br>");
			$(".modalContent").append("내용 : "+contents.contents+"<br>");
			$(".modalContent").append("해시태그 : ")
			for(var i in hashtag){
				$(".modalContent").append
				("<a href='https://search.shopping.naver.com/search/all?query="+hashtag[i]+"&cat_id=&frm=NVSHATC'>#"+hashtag[i]+"</a>&nbsp");
			} // for end
			$(".modalContent").append("<br>좋아요 : "+contents.thumbsup+"<br>");
		}, //success end
		error : function(e){
			console.log(e)
		} // error end
	}); //ajax end
}

var modalstatus = 0; // 모달창을 클릭한 것인지, 배경을 클릭한 것인지 구분
function modalClick(e){
	if(modalstatus==0){
		$(".modal").fadeOut();
	} else if(modalstatus==1) {
		modalstatus = 0;
	}
}

function thumbsup(e){
	alert("Clickimage")
	//e.stopPropagation();
}

function modalContentClick(){
	modalstatus = 1;
}

</script>
</head>
<body>
<h1>해시태그 검색 리스트</h1>
<form action="/search" method="post" >
	<input type="text" id=searchbar name="searchWord" value=<%=hashtag %>>
	<input type="submit" value="search">
</form>
<span id=searchresult>#<%=hashtag %></span><span>검색결과</span><br>
<span id=totalhashtag></span>
<div id="searchlist">
	<button id="favorite">인기 게시물</button>&nbsp;&nbsp;
	<button id="recentUpdate">최근 게시물</button>
</div>

<div id=thumbsupView style="background-color:#abcdef;
		width:1000px; height:1000px; overflow:scroll;">
	<div class="thumbsupList"></div>		
</div>

<div id=recentView style="display:none; background-color:yellow; 
	width:1000px; height:1000px; overflow:scroll;">
	<div class="recentList"></div>	
</div>

<div class="modal" onclick="modalClick()">
	<div class="modalContent" onclick="modalContentClick()"></div>
</div>
</body>
</html>