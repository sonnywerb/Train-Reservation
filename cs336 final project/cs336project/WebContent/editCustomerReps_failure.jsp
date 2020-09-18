<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative Edit Failure</title>
</head>
<body>
		<b> Failed to find data for a customer representative with that SSN. </b>
		<br>
		Click <a href="editCustomerReps_select.jsp"> here</a> to try again.
		<br>
		Click <a href="adminHomepage.jsp"> here</a> to return to the homepage.
</body>
</html>