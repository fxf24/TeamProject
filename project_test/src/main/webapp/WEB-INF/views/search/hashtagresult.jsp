<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String hashtag = request.getParameter("hashtag");
%>
<!DOCTYPE html>
<html>
<head>
	<link href="/css/HHhead.css" rel="stylesheet" type="text/css">
	<link href="/css/profile/topmain.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>HashHershe</title>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
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
				console.log(response)
				var list = response;
				if(list.length==0){ //검색 결과가 없을 때
					$("#hashtagSearch").text("검색 결과가 없습니다.");
				} else {
					for(var i in list){
						var hashtag = list[i].hashtag.substr(1,).split("#"); //hashtag 검색 결과를 #를 기준으로 나눔
						//console.log("HASHTAG = "+hashtag)
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
});

function YesScroll () {
	const pagination = document.querySelector('.paginaiton'); // 페이지네이션 정보획득
	const fullContent = document.querySelector('.infinite'); // 전체를 둘러싼 컨텐츠 정보획득
	const screenHeight = screen.height; // 화면 크기
	let oneTime = false; // 일회용 글로벌 변수
	document.addEventListener('scroll', OnScroll, {passive:true}) // 스크롤 이벤트함수정의
	 function OnScroll (){ //스크롤 이벤트 함수
	   const fullHeight = fullContent.clientHeight; // infinite 클래스의 높이   
	   const scrollPosition = pageYOffset; // 스크롤 위치
	   if (fullHeight-screenHeight/2 <= scrollPosition && !oneTime) { // 만약 전체높이-화면높이/2가 스크롤포지션보다 작아진다면, 그리고 oneTime 변수가 거짓이라면
	     oneTime = true; // oneTime 변수를 true로 변경해주고,
	     madeBox(); // 컨텐츠를 추가하는 함수를 불러온다.
	   }
	}
}
	YesScroll()
</script>
</head>
<body>
<h1>해시태그 검색 리스트</h1>
<form action="/search" method="post" >
	<input type="text" name="searchWord">
	<input type="submit" value="search">
</form>
<div><%=hashtag %> 검색결과</div>
<div id="searchlist">
	<button id="favorite">인기 게시물</button>&nbsp;&nbsp;
	<button id="recentUpdate">최근 게시물</button>
</div>

<div class="infinite">
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
</div><!-- infinite end -->
<div class="pagenation">페이지네이션</div>
</body>
</html>