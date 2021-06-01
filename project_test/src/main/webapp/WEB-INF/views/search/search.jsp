<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String searchword = request.getParameter("searchWord");
%>
<!DOCTYPE html>
<html>
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
		$("#idSearch").text("검색어를 입력하세요.");
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
					$("#idSearch").text("검색 결과가 없습니다.");
				} else {
					for(var i in list){ //결과 반환
						$("#idSearch").append
						("<img src='#' class='profileimage'><a href='profile?id="+list[i].id+"'>"+list[i].id+"</a><br>");		
						// 이미지 경로 및 css 수정 필요
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
		$("#nameSearch").text("검색어를 입력하세요.");
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
					$("#nameSearch").text("검색 결과가 없습니다.");
				} else {
					for(var i in list){ //결과 반환
						$("#nameSearch").append
						("<img src='#' class='profileimage'><a href='profile?name="+list[i].name+"'>"+list[i].name+"</a><br>");				
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
		$("#hashtagSearch").text("검색어를 입력하세요.");
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
					$("#hashtagSearch").text("검색 결과가 없습니다.");
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
						$("#hashtagSearch").append("검색 결과가 없습니다.");
					} else {
						for(var i in hashtagArr){ //결과 반환
							$("#hashtagSearch").append
							("<a href='hashtagresult?hashtag="+hashtagArr[i]+"'>"+"#"+hashtagArr[i]+"</a><br>");
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
	$("#idSearch").text(""); 
	$("#nameSearch").text("");
	$("#hashtagSearch").text(""); 
	
	// id 검색결과
	if(searchMessage==null || searchMessage==""){ //검색어가 없을 때
		$("#idSearch").text("검색어를 입력하세요.");
	} else {
		$.ajax({
			url :"/idsearch",
			type : "get",
			data : {"id" : searchMessage},
			dataType : "json",
			success : function(response){
				console.log(response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$("#idSearch").text("검색 결과가 없습니다.");
				} else {
					for(var i in list){ //결과 반환
						$("#idSearch").append
						("<img src='#' class='profileimage'><a href='profile?id="+list[i].id+"'>"+list[i].id+"</a><br>");				
					}// for end
				} 
			}, // success end
			error : function(e){
				console.log(e)
			} // error end
		}) // ajax end
	} //else end	
	
	// name 검색 결과
	if(searchMessage==null || searchMessage==""){ //검색어가 없을 때
		$("#nameSearch").text("검색어를 입력하세요.");
	} else {
		$.ajax({
			url :"/namesearch",
			type : "get",
			data : {"name" : searchMessage},
			dataType : "json",
			success : function(response){
				console.log(response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$("#nameSearch").text("검색 결과가 없습니다.");
				} else {
					for(var i in list){ //결과 반환
						$("#nameSearch").append
						("<img src='#' class='profileimage'><a href='profile?name="+list[i].name+"'>"+list[i].name+"</a><br>");				
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
		$("#hashtagSearch").text("검색어를 입력하세요.");
	} else {
		$.ajax({
			url :"/hashtagsearch",
			type : "get",
			data : {"hashtag" : searchMessage},
			dataType : "json",
			success : function(response){
				console.log(response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$("#hashtagSearch").text("검색 결과가 없습니다.");
				} else {
					for(var i in list){
						var hashtag = list[i].hashtag.substr(1,).split("#"); //hashtag 검색 결과를 #를 기준으로 나눔
						//console.log("HASHTAG = "+hashtag)
						for(var tag in hashtag){
							if(!hashtagArr.includes(hashtag[tag]) &&
								searchMessage == hashtag[tag].substring(0, length)){ //중복된 태그 검사 && 검색어와 태그 일치 여부 검사
									hashtagArr.push(hashtag[tag]);
									hashtagArr.sort();																	
							} // if end								
						}// for tag end
					} // for i end
					if(hashtagArr.length==0){ //위 조건과 맞는 결과가 없을 때
						$("#hashtagSearch").append("검색 결과가 없습니다.");
					} else {
						for(var i in hashtagArr){ //결과 반환
							$("#hashtagSearch").append
							("<a href='hashtagresult?hashtag="+hashtagArr[i]+"'>"+"#"+hashtagArr[i]+"</a><br>");
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

</script>
</head>
<body>
<h1>검색페이지</h1>
<input type="text" id="searchbar" value="<%=searchword%>" onkeyup="enterkey()">
<input type="submit" id="searchbutton" value="검색" onclick="search()"><br>
<div id="searchlist">
	<button id="idbutton">아이디</button>&nbsp;&nbsp;
	<button id="namebutton">이름</button>&nbsp;&nbsp;
	<button id="hashtagbutton">해시태그</button><br>
</div>

<!-- 색상은 구분을 위해 임시 지정 , css 스타일 적용 필요 -->
<div id="messageWindow">
	<div id="idSearch" style="background-color:#abcdef;
		width:500px; height:600px; overflow:scroll;"> <!-- default view -->
	</div>
	<div id="nameSearch" style="display:none; background-color:yellow; 
	width:500px; height:600px; overflow:scroll;"> 
	</div>
	<div id="hashtagSearch" style="display:none; background-color:orange;
	width:500px; height:600px; overflow:scroll;">
	</div>
</div>

</body>
</html>