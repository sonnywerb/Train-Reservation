<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transit Line Reservation Results</title>
</head>
<body>

<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		String tline="";
		tline = request.getParameter("transitline");
		
		String query = "";
		
		query = "SELECT * FROM Reservations WHERE transitLine = '" +tline+ "';";
		
		
		
		
		ResultSet rs = stmt.executeQuery(query);
		rs.last();
		
		int row = rs.getRow();
		rs.beforeFirst();
		
		int count = 0;
		String[][] results = new String[row][13];
		while(rs.next()) {
			results[count][0] = "" + rs.getInt("res_number");
			results[count][1] = rs.getString("passenger_name");
			results[count][2] = rs.getString("date");
			results[count][3] = rs.getString("originSt");
			results[count][4] = rs.getString("destSt");
			results[count][5] = "" + rs.getInt("trainID");
			results[count][6] = rs.getString("transitLine");
			results[count][7] = rs.getString("departure_time");
			results[count][8] = rs.getString("arrival_time");
			results[count][9] = rs.getString("travel_time");
			results[count][10] = rs.getString("trip_type");
			results[count][11] = rs.getString("discount_status");
			results[count][12] = "$" + rs.getDouble("fare");
			count++;
		}
		rs.close();
		
		out.println("<table style='width:100%'>");
		out.print("<td><b>Entry</b></td>");
		out.print("<td><b>Reservation#</b></td>");
		out.print("<td><b>Passenger</b></td>");
		out.print("<td><b>Date</b></td>");
		out.print("<td><b>Origin</b></td>");
		out.print("<td><b>Destination</b></td>");
		out.print("<td><b>Train#</b></td>");
		out.print("<td><b>Transit Line</b></td>");
		out.print("<td><b>Departure Time</b></td>");
		out.print("<td><b>Arrival Time</b></td>");
		out.print("<td><b>Travel Time</b></td>");
		out.print("<td><b>Trip Type</b></td>");
		out.print("<td><b>Status</b></td>");
		out.print("<td><b>Fare</b></td>");     
		
		for(int i=0; i<row; i++) {
			out.print("<tr><td>" + (i+1) + "</td><td>" + results[i][0] + "</td>");
			out.print("<td>" + results[i][1] + "</td>");
			out.print("<td>" + results[i][2] + "</td>");
			out.print("<td>" + results[i][3] + "</td>");
			out.print("<td>" + results[i][4] + "</td>");
			out.print("<td>" + results[i][5] + "</td>");
			out.print("<td>" + results[i][6] + "</td>");
			out.print("<td>" + results[i][7] + "</td>");
			out.print("<td>" + results[i][8] + "</td>");
			out.print("<td>" + results[i][9] + "</td>");
			out.print("<td>" + results[i][10] + "</td>");
			out.print("<td>" + results[i][11] + "</td>");
			out.print("<td>" + results[i][12] + "</td></tr>");
		}
		out.println("</table>");
		
		stmt.close();
		conn.close();
	
	} catch (Exception e) {
		out.println(e);
		out.println("<br> <br><a href='customerRepHP.jsp'> Return </a>");
	}
	
out.println("<br><br>Click <a href='customerRepHP.jsp'> here</a> to return to the home page.");

%>

</body>
</html>