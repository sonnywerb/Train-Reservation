<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Reservations</title>
</head>
<body>
<b>View Reservations</b>
	<br>
	Go<a href="adminHomepage.jsp"> back</a>.
	<br>

	<%
		if(session.getAttribute("user") == null) {
			out.print("You have been logged out, please <a href='login.jsp'> log in</a> again.");
		} else {
			try {
				//Connection to database
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
				//mySQL statement
				Statement stmt = con.createStatement();
				
				String listBy = request.getParameter("listBy");
				String query;
				
				if (listBy.equals("transitLine"))
				{
					query = "SELECT  b.res_number, r.date, r.departure_time, r.arrival_time, r.trip_type, r.fare, r.passenger_name, r.discount_status, r.originSt, r.destSt, r.trainID, r.transitLine, r.travel_time ";  
					query += "FROM Bookings b JOIN Reservations r ON b.res_number=r.res_number ";
				  	query += "ORDER BY r.transitLine asc;";
				}
				else
				{
					query = "SELECT  b.res_number, r.date, r.departure_time, r.arrival_time, r.trip_type, r.fare, r.passenger_name, r.discount_status, r.originSt, r.destSt, r.trainID, r.transitLine, r.travel_time ";  
					query += "FROM Bookings b JOIN Reservations r ON b.res_number=r.res_number ";
				  	query += "ORDER BY r.passenger_name asc;";
				}
				
					
				ResultSet resultSet = stmt.executeQuery(query);
				out.println("<b> Reservations: </b><br>");
				String previous = "";
				while(resultSet.next())
				{
					int resNum = resultSet.getInt("b.res_number");
					String date = resultSet.getString("r.date");
					String departTime = resultSet.getString("r.departure_time");
					String arrivTime = resultSet.getString("r.arrival_time");
					String tripType = resultSet.getString("r.trip_type");
					double fare = resultSet.getDouble("r.fare");
					String passName = resultSet.getString("r.passenger_name");
					String passStatus = resultSet.getString("r.discount_status");
					String originSt = resultSet.getString("r.originSt");
					String destSt = resultSet.getString("r.destSt");
					int trainID = resultSet.getInt("r.trainID");
					String transitLine = resultSet.getString("r.transitLine");
					String travelTime = resultSet.getString("r.travel_time");
					
					if (listBy.equals("transitLine"))
					{
						if (!previous.equals(transitLine))
						{
							out.print("<br>" + transitLine);
							out.print("<br>======================================================================================<br>");
							previous = transitLine;
						}
					}
					else
					{
						if (!previous.equals(passName))
						{
							out.print("<br>" + passName);
							out.print("<br>======================================================================================<br>");
							previous = passName;
						}
					}
				
					out.print("<b>Reservation Number: </b>" + resNum + "<br>");
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
					
					out.print("<br>--------------------<br>");
				}
				
				//Close connection
				resultSet.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				out.print(e);
				out.print("Error fetching reservation data.");	
			}
		}
	%>

</body>
</html>