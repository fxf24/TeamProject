<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
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
}); //ready end

// main페이지에서 넘어온 검색값 받기
<%
	request.setCharacterEncoding("UTF-8");
	String searchword = request.getParameter("searchword");
%>

function search(){
	var searchMessage = $("#searchbar").val();
		// id 검색결과
		$.ajax({
			url :"/idsearch",
			type : "get",
			data : {"searchmessage" : searchMessage},
			//dataType : "json",
			success : function(idresponse){
				var searchval = idresponse;
				$("#idSearch").text(searchval);
			} // success end
		}) // ajax end	
		
		// name 검색결과		
		$.ajax({
			url :"/namesearch",
			type : "get",
			data : {"searchmessage" : searchMessage},
			success : function(idresponse){
				var searchval = idresponse;
				$("#nameSearch").text(searchval);
			} // success end
		})// ajax end
		
		// hashtag 검색결과
		$.ajax({ 
			url :"/hashtagsearch",
			type : "get",
			data : {"searchmessage" : searchMessage},
			success : function(idresponse){
				var searchval = idresponse;
				$("#hashtagSearch").text(searchval);
			} // success end
		})// ajax end
}// search function end


</script>
</head>
<body>
<h1>검색페이지</h1>
<input type="text" id="searchbar">
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