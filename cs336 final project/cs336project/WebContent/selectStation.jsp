<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservation</title>
</head>
<body>

	<form method="GET" action="makeReservation.jsp">
		<b>Make a Reservation</b>
		<br>
		<br>
		Origin Station:
		<select name='originStation'>			
			<option value='BUS'>Busch</option>
			<option value='LIV'>Livingston</option>
			<option value='CA'>College Ave</option>
			<option value='CD'>Cook/Douglass</option>		
		</select>
		<br>
		Destination Station:
		<select name='destinationStation'>		
			<option value='BUS'>Busch</option>
			<option value='LIV'>Livingston</option>
			<option value='CA'>College Ave</option>
			<option value='CD'>Cook/Douglass</option>			
		</select>
		<input type='submit' value='Submit'>
		<br>
		<br>
		(<i>BUS = Busch, LIV = Livingston, CA = College Ave, CD = Cook/Douglass</i>)
		<br>
		<br>
		Not making a reservation? Click <a href='customerHomepage.jsp'> here</a> to go back to the home page.

	</form>



</body>
</html>