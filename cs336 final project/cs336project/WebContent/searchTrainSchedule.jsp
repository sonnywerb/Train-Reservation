<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Train Schedule</title>
</head>
<body>
	
	<form method="GET" action=searchTrainSchedule_action.jsp>
		<b> Search Train Schedules</b>
		<br>
		Search by:
		<select name="searchBy">
			<option value="origin">Origin</option>
			<option value="destination">Destination</option>
			<option value="date">Date</option>
		</select>
		Sort by:
		<select name="sortBy">
			<option value="arrivalTime">Arrival Time</option>
			<option value="departureTime">Departure Time</option>
			<option value="fare">Fare</option>
		</select>
		<br>
		<input type=search name="searchInput" size="50">
		<input type="submit" value="Search">
	<br>
	</form>
	<b>------------------------------------------------------------------------</b> <br>
	<form method="GET" action=transitLines_action.jsp>
	See all stops by transit line: 
	<select name="transitLine">
		<option value='A'>A</option>
		<option value='B'>B</option>
		<option value='EE'>EE</option>
		<option value='F'>F</option>
		<option value='H'>H</option>
		<option value='LX'>LX</option>
		<option value='REXB'>REXB</option>
		<option value='REXL'>REXL</option>
		<option value='WKND'>WKND</option>
	</select>
	
	<input type="submit" value="Submit">
	</form>
	<br>
	
	Click <a href="customerHomepage.jsp">here</a> to go back.

</body>
</html>