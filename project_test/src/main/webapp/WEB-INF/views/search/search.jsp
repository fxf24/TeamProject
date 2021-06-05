<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String searchword = request.getParameter("searchWord");
	if(searchword==null){
		searchword = "";
	}
	String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<link href="/css/search/search.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="https://kit.fontawesome.com/5e5186ce3e.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<head>
<meta charset="UTF-8">
<title>HashHershe</title>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){ 
	//id, name, hashtag 버튼 클릭시 각각의 화면 출력
	$("#idbutton").on('click', function(){
		$('#idSearch').css("display", "block");
		$('#nameSearch').css("display", "none");
		$('#hashtagSearch').css("display", "none");
	})
	
	$("#namebutton").on('click', function(){
		$('#idSearch').css("display", "none");
		$('#nameSearch').css("display", "block");
		$('#hashtagSearch').css("display", "none");
	})
	
	$("#hashtagbutton").on('click', function(){
		$('#idSearch').css("display", "none");
		$('#nameSearch').css("display", "none");
		$('#hashtagSearch').css("display", "block");
	})
			
	var searchMessage = $("#searchbar").val();
	//main에서 넘어오는 search값 전달, id 검색	
	if(searchMessage==null||searchMessage==""){ //검색어가 없을 때
		$(".idSearchList").html("<div class=resultNone>검색어를 입력하세요.</div>");
	} else {
		$.ajax({
			url :"/idsearch",
			type : "get",
			data : {"id" : searchMessage},
			dataType : "json",
			success : function(response){
				//console.log(response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$(".idSearchList").html("<div class=resultNone>검색 결과가 없습니다.</div>");
				} else {
					for(var i in list){ //결과 반환
						var userImage = list[i].profileImage
						var userID = list[i].id
						if(userImage==null){
							$(".idSearchList").append
							("<div class=oneProfile>"+
							"<div class=profileImage>"+
							"<img src='/images/basicprofileimage.jpg' class='profileimage' onclick=moveToID('"+userID+"')></div>"+
							"<p class=profileList><a href='profile?id="+userID+"'>"+userID+"</a></p></div>");	
						} else {
							var userImagepath = userImage.split("/")
							$(".idSearchList").append
							("<div class=oneProfile>"+
							"<div class=profileImage><img src='/upload/"+userImagepath[userImagepath.length-1]+"' class='profileimage'></div>"+
							"<p class=profileList><a href='profile?id="+userID+"'>"+userID+"</a></p></div>");
						}//else end
					}// for end
				} 
			}, // success end
			error : function(e){
				console.log(e)
			} // error end
		}) // ajax end
	} //else end
 			 
	
	//main에서 넘어오는 search값 전달, name 검색
	if(searchMessage==null||searchMessage==""){ //검색어가 없을때
		$(".nameSearchList").html("<div class=resultNone>검색어를 입력하세요.</div>");
	} else {
		$.ajax({
			url :"/namesearch",
			type : "get",
			data : {"name" : searchMessage},
			dataType : "json",
			success : function(response){
				//console.log(response)
				var list = response;
				if(list.length==0){ // 검색결과가 없을때
					$(".nameSearchList").html("<div class=resultNone>검색 결과가 없습니다.</div>");
				} else {
					for(var i in list){ //결과 반환
						var userImage = list[i].profileImage
						var userName = list[i].name
						if(userImage==null){
							$(".nameSearchList").append
							("<div class=oneProfile>"+
							"<div class=profileImage>"+
							"<img src='/images/basicprofileimage.jpg' class='profileimage' onclick=moveToName('"+userName+"')></div>"+
							"<p class=profileList><a href='profile?name="+userName+"'>"+userName+"</a></p></div>");	
						} else {
							var userImagepath = userImage.split("/")
							$(".idSearchList").append
							("<div class=oneProfile>"+
							"<div class=profileImage><img src='/upload/"+userImagepath[userImagepath.length-1]+"' class='profileimage'></div>"+
							"<p class=profileList><a href='profile?name="+userName+"'>"+userName+"</a></p></div>");
						}//else end
					}// for end
				}  //else end
			}, // success end
			error : function(e){
				console.log(e)
			} // error end
		}) // ajax end
	} //else end
	
	
	// main에서 넘어오는 search값 전달, hashtag 검색
	var length = searchMessage.length; //검색어의 길이
	var hashtagArr = []; //검색어의 중복을 방지하기 위한 array
	if(searchMessage==null||searchMessage==""){ //검색어가 없을때
		$(".hashtagSearchList").html("<div class=resultNone>검색어를 입력하세요.</div>");
	} else {
		$.ajax({
			url :"/hashtagsearch",
			type : "get",
			data : {"hashtag" : searchMessage},
			dataType : "json",
			success : function(response){
				//console.log(response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$(".hashtagSearchList").html("<div class=resultNone>검색어를 입력하세요.</div>");
				} else {
					for(var i in list){
						var hashtag = list[i].hashtag.substr(1,).split("#"); //hashtag 검색 결과를 #를 기준으로 나눔
						console.log(response)
						for(var tag in hashtag){
							if(!hashtagArr.includes(hashtag[tag]) && //중복된 태그 검사 && 검색어와 태그 일치 여부 검사
								searchMessage == hashtag[tag].substring(0, length)){
									hashtagArr.push(hashtag[tag]);
									hashtagArr.sort();																	
							} // if end								
						}// for tag end
					} // for i end
					if(hashtagArr.length==0){ //위 조건과 맞는 결과가 없을 때
						$(".hashtagSearchList").html("<div class=resultNone>검색 결과가 없습니다.</div>");
					} else {
						for(var i in hashtagArr){ //결과 반환
							$(".hashtagSearchList").append
							("<p><a class=hashtagList href='hashtagresult?hashtag="+hashtagArr[i]+"'>"+"#"+hashtagArr[i]+"</a></p>");		
						}// for end
					}// else end
				}// else
			}, // success end
			error : function(e){
						console.log(e)
					} // error end
			}) // ajax end
		} //else end
}); //ready end


//search버튼 클릭 시 검색결과 반환 함수
function search(){ 
	var searchMessage = $("#searchbar").val(); // 검색어 입력
	// 검색결과 초기화
	$(".idSearchList").text("");
	$(".nameSearchList").text("");
	$(".hashtagSearchList").text(""); 
	
	// id 검색결과
	if(searchMessage==null || searchMessage==""){ //검색어가 없을 때
		$(".idSearchList").html("<div class=resultNone>검색어를 입력하세요.</div>");
	} else {
		$.ajax({
			url :"/idsearch",
			type : "get",
			data : {"id" : searchMessage},
			dataType : "json",
			success : function(response){
				//console.log("idsearch = "+response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$(".idSearchList").html("<div class=resultNone>검색 결과가 없습니다.</div>");
				} else {
					for(var i in list){ //결과 반환
						var userImage = list[i].profileImage
						var userID = list[i].id
						if(userImage == null){
							$(".idSearchList").append
							("<div class=oneProfile>"+
							"<div class=profileImage>"+
							"<img src='/images/basicprofileimage.jpg' class='profileimage' onclick=moveToID('"+userID+"')></div>"+
							"<p class=profileList><a href='profile?id="+userID+"'>"+userID+"</a></p></div>");
						} else {
							var userImagepath = userImage.split("/")
							//console.log(userImagepath)
							$(".idSearchList").append
							("<div class=oneProfile>"+
							"<div class=profileImage><img src='/upload/"+userImagepath[userImagepath.length-1]+"' class='profileimage'></div>"+
							"<p class=profileList><a href='profile?id="+userID+"'>"+userID+"</a></p></div>");
						} // else end
					}// for end
				}// else end 
			}, // success end
			error : function(e){
				console.log(e)
			} // error end
		}) // ajax end
	} //else end	
	
	// name 검색 결과
	if(searchMessage==null || searchMessage==""){ //검색어가 없을 때
		$(".nameSearchList").html("<div class=resultNone>검색어를 입력하세요.</div>");
	} else {
		$.ajax({
			url :"/namesearch",
			type : "get",
			data : {"name" : searchMessage},
			dataType : "json",
			success : function(response){
				//console.log("namesearch = "+response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$(".nameSearchList").html("<div class=resultNone>검색 결과가 없습니다.</div>");
				} else {
					for(var i in list){ //결과 반환
						$(".nameSearchList").append
						var userImage = list[i].profileImage
						var userName = list[i].name
						if(userImage==null){
							$(".nameSearchList").append
							("<div class=oneProfile>"+
							"<div class=profileImage>"+
							"<img src='/images/basicprofileimage.jpg' class='profileimage' onclick=moveToName('"+userName+"')></div>"+
							"<p class=profileList><a href='profile?name="+userName+"'>"+userName+"</a></p></div>");	
						} else {
							var userImagepath = userImage.split("/")
							$(".nameSearchList").append
							("<div class=oneProfile>"+
							"<div class=profileImage><img src='/upload/"+userImagepath[userImagepath.length-1]+"' class='profileimage'></div>"+
							"<p class=profileList><a href='profile?name="+userName+"'>"+userName+"</a></p></div>");
						}//else end					
					}// for end
				} // else end
			}, // success end
			error : function(e){
				console.log(e)
			} // error end
		}) // ajax enda
	} //else end
	
	// hashtag 검색결과
	var length = searchMessage.length; //검색어의 길이
	var hashtagArr = []; //검색어의 중복을 방지하기 위한 array
	if(searchMessage==null||searchMessage==""){ //검색어가 없을 때
		$(".hashtagSearchList").html("<div class=resultNone>검색어를 입력하세요.</div>");
	} else {
		$.ajax({
			url :"/hashtagsearch",
			type : "get",
			data : {"hashtag" : searchMessage},
			dataType : "json",
			success : function(response){
				//console.log("hashtag result = "+response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$(".hashtagSearchList").html("<div class=resultNone>검색 결과가 없습니다.</div>");
				} else {
					for(var i in list){
						var hashtag = list[i].hashtag.substr(1,).split("#"); //hashtag 검색 결과를 #를 기준으로 나눔
						//console.log("HASHTAG = "+hashtag)
						for(var tag in hashtag){
							if(searchMessage == hashtag[tag].substring(0, length)){
								hashtagArr.push(hashtag[tag]);
								hashtagArr.sort();
							} // for end							
						}// for tag end
					} // for i end
					if(hashtagArr.length==0){ //위 조건과 맞는 결과가 없을 때
						$(".hashtagSearchList").html("<div class=resultNone>검색 결과가 없습니다.</div>");
					} else {
						var hashtagSet = new Set(hashtagArr)
						console.log(hashtagSet)
						for(let i of hashtagSet){ //결과 반환
							$(".hashtagSearchList").append
							("<p><a class=hashtagList href='hashtagresult?hashtag="+i+"'>"+"#"+i+"</a></p>");
							//("<p><a class=hashtagList href='hashtagresult?hashtag="+hashtagArrtest[i]+"'>"+"#"+hashtagArrtest[i]+"</a></p>");
						}// for end
					}// else end
				}// else
			}, // success end
			error : function(e){
						console.log(e)
					} // error end
			}) // ajax end
		} //else end
	}// search function end

function enterkey(){
	//  엔터키 입력(a - 97  0 - 48 엔터키 - 13)하면 send  함수 동일 효과
	if(window.event.keyCode == 13){
		search();
	}
}	
	
function moveToID(value){
	console.log(value)
	var url = "/profile?id="+value;
	location.href = url;
}

function moveToName(value){
	console.log(value)
	var url = "/profile?name="+value;
	location.href = url;
}

</script>
</head>
<body>
	<input type="text" id="searchbar" value="<%=searchword%>" onkeyup="enterkey()" placeholder="검색어를 입력하세요">
	<i class="fas fa-search fa-3x" id=fa-search type="submit" id="searchbutton" onclick="search()"></i>
	
	<button id="idbutton">아이디</button>
	<button id="namebutton">이름</button>
	<button id="hashtagbutton">해시태그</button><br>
<!-- 색상은 구분을 위해 임시 지정 , css 스타일 적용 필요 -->
<div id="messageWindow">
	<div id="idSearch"> <!-- default view -->
		<div class=idSearchList id=idSearchList></div>
	</div>
	<div id="nameSearch">
		<div class=nameSearchList></div>
	</div>
	<div id="hashtagSearch">
		<div class=hashtagSearchList></div>
	</div>
</div>

</body>
</html>