<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Select Transit Line</title>
</head>
<body>
	<form method ="GET" action="transitLineRes_action.jsp">
	 	Select the transit line that you would like to view the reservations of:
	 	<br>
		<b> Transit Line: </b>
		<select name="transitline">
			<option value="A">A</option>
			<option value="B">B</option>
			<option value="EE">EE</option>
			<option value="F">F</option>
			<option value="H">H</option>
			<option value="LX">LX</option>
			<option value="REXB">REXB</option>
			<option value="REXL">REXL</option>
			<option value="WKND">WKND</option>
		</select>
		
		<input type="submit" value="Submit">
		</form>
		<br>
		<br>
		=================================================================================
		<br>
		View reservations of transit lines by date:<br>
		<form method ="GET" action="transitLineResDate_action.jsp">
			<input type=search name="dateSearch" size="25">
			<input type="submit" value="Search">
		</form>
		<br>
		<br>
		Click <a href="customerRepHP.jsp"> here</a> to return to the home page.

</body>
</html>