<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Revenue </title>
</head>
<body>
<b>View Revenue </b>
	<br>
	Go <a href="adminHomepage.jsp"> back</a>.
	<br>
	
	<form method="GET" action=viewRevenue_action.jsp>
	See total revenue by: 
	<select name="listBy">
		<option value='transitLine'>Transit Line</option>
		<option value='customerUsername'>Customer Username</option>
	</select>
	
	<input type="submit" value="Go">
	</form>

</body>
</html>