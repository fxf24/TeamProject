<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/5e5186ce3e.js" crossorigin="anonymous"></script>
<script src="/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){

});
</script>
</head>
<body>
<br><br><br><br><br><br><br><br>
<form action="/search" method="post" >
	<input type="text" name="searchWord">
	<input type="submit" value="search">
</form>
<i class='fas fa-heart'>s는 찬 하트</i>
<i class='far fa-heart'>r은 빈 하트</i>
</body>
</html>