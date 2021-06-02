<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.project.tfa.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/resources/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	
});
</script>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String password = request.getParameter("password");
String name = request.getParameter("name");
String email = request.getParameter("email");
String telephone = request.getParameter("telephone");

Connection conn = DBUtil.getMySQLConnection();

String sql = "insert into member(id, password, email, name, telephone) values(?, ?, ?, ?, ?)";
PreparedStatement pre =  conn.prepareStatement(sql);

pre.setString(1, id);
pre.setString(2, password);
pre.setString(3, email);
pre.setString(4, name);
pre.setString(5, telephone);
pre.executeUpdate();

DBUtil.close(pre);
DBUtil.close(conn);
%>
</body>
</html>