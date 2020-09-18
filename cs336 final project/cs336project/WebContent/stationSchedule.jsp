<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Station selection:</title>
</head>
<body>
	
	<form method="GET" action="stationSchedule_action.jsp">
	 Select the train station that you would like to view the schedule for: <br>
	<b>Origin Station:</b>
	<select name="originSelect">
		<option value="BUS">Busch</option>
		<option value="LIV">Livingston</option>
		<option value="CA">College Ave</option>
		<option value="CD">Cook/Douglass</option>
	</select>
	<br>
	<b>Destination Station:</b>
	<select name="destinationSelect">
		<option value="BUS">Busch</option>
		<option value="LIV">Livingston</option>
		<option value="CA">College Ave</option>
		<option value="CD">Cook/Douglass</option>
	</select>
	<input type="submit" value="Submit">
	<br>
	<br>
	Click <a href="customerRepHP.jsp"> here</a> to return to the homepage.
</form>
</body>
</html>