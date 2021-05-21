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
</script>
<script type="text/javascript">
const name = "Mike"; // let 은 변수 변경 가능 , const 상수 수정 불가능(대문자로 가급적) 문자,숫자 $ _ 만 사용가능
const age = 30;

const message = "I'm a boy";
const message2 = `My name is ${name}, age is ${age}`;
console.log(message2); //or alert()
alert(message2);
</script>
</head>
<body>

</body>
</html>