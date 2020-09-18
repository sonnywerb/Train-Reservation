<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transit Line Info</title>
</head>
<body>

	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		String transitLine = request.getParameter("transitLine");
		
		String transitQuery = "";
		if(transitLine.equals("A")) {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) AS 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line='A';";
		} else if(transitLine.equals("B")) {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) AS 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line= 'B';";
		} else if(transitLine.equals("EE")) {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) AS 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line= 'EE';";
		} else if(transitLine.equals("F")) {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) AS 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line= 'F';";
		} else if(transitLine.equals("H")) {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) AS 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line= 'H';";
		} else if(transitLine.equals("LX")) {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(s.arrival_time1,'%k:%i %p'))) AS 'First Stop',"; 
			transitQuery += "CONCAT(s.stop2, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) as 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line='LX';";
		} else if(transitLine.equals("REXB")) {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(s.arrival_time1,'%k:%i %p'))) AS 'First Stop',"; 
			transitQuery += "CONCAT(s.stop2, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) as 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line='REXB';";
		} else if(transitLine.equals("REXL")) {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(s.arrival_time1, '%k:%i %p'))) AS 'First Stop',"; 
			transitQuery += "CONCAT(s.stop2, CONCAT(' - ', TIME_FORMAT(s.arrival_time2, '%k:%i %p'))) AS 'Second Stop',";
			transitQuery += "CONCAT(s.stop3, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) as 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line='REXL';";
		} else {
			transitQuery = "SELECT s.transit_line AS 'Transit Line', s.num_stops AS 'No. Stops',";
			transitQuery += "CONCAT(s.origin, CONCAT(' - ', TIME_FORMAT(t.departure_time, '%k:%i %p'))) AS 'Origin Station',";
			transitQuery += "CONCAT(s.stop1, CONCAT(' - ', TIME_FORMAT(s.arrival_time1, '%k:%i %p'))) AS 'First Stop',"; 
			transitQuery += "CONCAT(s.stop2, CONCAT(' - ', TIME_FORMAT(s.arrival_time2, '%k:%i %p'))) AS 'Second Stop',";
			transitQuery += "CONCAT(s.stop3, CONCAT(' - ', TIME_FORMAT(t.arrival_time, '%k:%i %p'))) AS 'Destination Station',";
			transitQuery += "CONCAT('$', t.fare_per_stop) as 'Fare per Stop' ";
			transitQuery += "FROM Stops s JOIN Train_Schedule t ON s.transit_line=t.transit_line ";
			transitQuery += "WHERE s.transit_line='WKND';";
		}
		
		ResultSet results = stmt.executeQuery(transitQuery);
		
		out.println("<table>");
		while(results.next()) {	
			if(transitLine.equals("A") || transitLine.equals("B") || transitLine.equals("EE") || transitLine.equals("F") || transitLine.equals("H")) {				
				
			
				
				out.println("<tr><td><b>Transit Line: </b></td><td>" + results.getString("Transit Line") + "</td>");
				out.println("<tr><td><b>No. Stops: </b></td><td>" + results.getString("No. Stops") + "</td>");
				out.println("<tr><td><b>Origin Station: </b></td><td>" + results.getString("Origin Station") + "</td>");
				out.println("<tr><td><b>Destination Station: </b></td><td>" + results.getString("Destination Station") + "</td>");
				out.println("<tr><td><b>Fare per Stop: </b></td><td>" + results.getString("Fare per Stop") + "</td>");
				
			
				
			} else if(transitLine.equals("LX") || transitLine.equals("REXB")) {
				out.println("<tr><td><b>Transit Line: </b></td><td>" + results.getString("Transit Line") + "</td>");
				out.println("<tr><td><b>No. Stops: </b></td><td>" + results.getString("No. Stops") + "</td>");
				out.println("<tr><td><b>Origin Station: </b></td><td>" + results.getString("Origin Station") + "</td>");
				out.println("<tr><td><b>First Stop: </b></td><td>" + results.getString("First Stop") + "</td>");
				out.println("<tr><td><b>Destination Station: </b></td><td>" + results.getString("Destination Station") + "</td>");
				out.println("<tr><td><b>Fare per Stop: </b></td><td>" + results.getString("Fare per Stop") + "</td>");
			} else {	
				out.println("<tr><td><b>Transit Line: </b></td><td>" + results.getString("Transit Line") + "</td>");
				out.println("<tr><td><b>No. Stops: </b></td><td>" + results.getString("No. Stops") + "</td>");
				out.println("<tr><td><b>Origin Station: </b></td><td>" + results.getString("Origin Station") + "</td>");
				out.println("<tr><td><b>First Stop: </b></td><td>" + results.getString("First Stop") + "</td>");			
				out.println("<tr><td><b>Second Stop: <b></td><td>" + results.getString("Second Stop") + "</td>");
				out.println("<tr><td><b>Destination Station: </b></td><td>" + results.getString("Destination Station") + "</td>");
				out.println("<tr><td><b>Fare per Stop: </b></td><td>" + results.getString("Fare per Stop") + "</td>");
			}
		}
		out.println("</table>");
		out.println("<br>(<i>BUS = Busch, LIV = Livingston, CA = College Ave, CD = Cook/Douglass</i>)");
		
		results.close();
		stmt.close();
		conn.close();
		
	} catch(Exception e) {
		out.println("Error:" + e);
	}
	
	%>

</body>
</html>