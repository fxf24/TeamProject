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
	function search(){
		window.location.href = '/profilesearch'
	}
});
</script>
</head>
<body>
<h1>해시태그 검색기능</h1>
<input type="text" id=searchbar name=searchbar>
<button type="button" onclick="search()">검색</button>
</body>
</html>