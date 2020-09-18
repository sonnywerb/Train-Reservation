<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Reservations</title>
</head>
<body>
<% 

		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		
		String user = (String) session.getAttribute("user");
		String query = "SELECT  b.res_number, r.date, r.departure_time, r.arrival_time, r.trip_type, r.fare, r.passenger_name, r.discount_status, r.originSt, r.destSt, r.trainID, r.transitLine, r.travel_time ";  
				query += "FROM Bookings b JOIN Reservations r ON b.res_number=r.res_number ";
			  	query += "WHERE b.username = '" + user + "' ORDER BY res_number desc;";
			  	
		ResultSet queryRs = stmt.executeQuery(query);
		out.println("Click <a href='customerHomepage.jsp'> here</a> to return to the homepage. <br><br>");
		out.println("<b> Your most current reservation: </b><br>");
		while(queryRs.next()) {
			int resNum = queryRs.getInt("b.res_number");
			String date = queryRs.getString("r.date");
			String departTime = queryRs.getString("r.departure_time");
			String arrivTime = queryRs.getString("r.arrival_time");
			String tripType = queryRs.getString("r.trip_type");
			double fare = queryRs.getDouble("r.fare");
			String passName = queryRs.getString("r.passenger_name");
			String passStatus = queryRs.getString("r.discount_status");
			String originSt = queryRs.getString("r.originSt");
			String destSt = queryRs.getString("r.destSt");
			int trainID = queryRs.getInt("r.trainID");
			String transitLine = queryRs.getString("r.transitLine");
			String travelTime = queryRs.getString("r.travel_time");
		
		
		
			out.print("<b>Reservation Number: </b>" + resNum + "<br>");
			out.println("Passenger Name: " + passName);
			out.println("<br>Train Number: " + trainID);
			out.println("<br>Transit Line: " + transitLine);
			out.println("<br> Origin Station: " + originSt);
			out.println("<br> Destination Station: " + destSt);
			out.println("<br>Date: " + date);
			out.println("<br> Departure Time: " + departTime);
			out.println("<br Arrival Time: " + arrivTime);
			out.println("<br>Travel Time: " + travelTime);
			out.println("<br> Trip Type: " + tripType);
			if(passStatus.equals("Senior") || passStatus.equals("Child") || passStatus.equals("Disabled")) {
				out.println("<br>Passenger Accomodations: " + passStatus);
			}
			out.println("<br> Total Fare: $" + fare);
			
			out.print("<br><br>======================================================================================<br><br>");
		}
		
	
%>
<%
	queryRs.close();
	stmt.close();
	conn.close();
%>


</body>
</html>