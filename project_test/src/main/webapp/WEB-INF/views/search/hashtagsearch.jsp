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
	
});

function search(){
	$("#searchbutton").on('click', function(){
		var searchMessage = $("#searchbar").val()
		$.ajax({
			url :"/idsearch",
			type : "get",
			data : {"searchmessage" : searchMessage},
			dataType : "json",
			success : function(idresponse){
				var searchval = idresponse;
				console.log(searchval);
			} // success end
		}) // ajax end
	})// onclick function end
}// search function end


</script>
</head>
<body>
<h1>검색페이지</h1>
<input type="text" id="searchbar">
<button id="searchbutton" onclick="search()">검색</button><br>
<div id="searchlist">	
	<button id="idbutton">아아디</button>&nbsp;&nbsp;
	<button id="namebutton">이름</button>&nbsp;&nbsp;
	<button id="hashtagbutton">해시태그</button><br>
</div>
<div id="idSearch"></div>
<div id="nameSearch"></div>
<div id="hashtagSearch"></div>

</body>
</html>