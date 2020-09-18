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

	<%
		try {
			
			//DB connection
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			
			//SQL statement
			Statement stmt = conn.createStatement();
		
			//Selection paramters
			String originSt = request.getParameter("originStation");
			String destSt = request.getParameter("destinationStation");
			
			String odSearch = "";
			
			//BUS
			if(originSt.equals("BUS")) {
				if(destSt.equals("BUS")) {
					out.print("Error, origin and destination are the same, please choose a different destination. ");
					out.print("Click <a href=\'selectStation.jsp\'> here</a> to go back.<br>");	
					//B, REXL
				} else if(destSt.equals("LIV")) {
					out.print("Transit lines from Busch to Livingston: <br>");
					odSearch = "SELECT t. train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', t.arrival_time as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='B' UNION ";
					odSearch +=	"SELECT t. train_ID as 'Train Number',s.transit_line as 'Transit Line', s.stop2 as 'Origin', s.stop3 as 'Destination',";	
					odSearch +=	"t.date as 'Date', t.departure_time as 'Departure Time', t.arrival_time as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time2, arrival_time3), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
				//A, LX, WKND
				} else if(destSt.equals("CA")){
					out.print("Transit lines from Busch to College Ave: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='A' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
					odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', t.arrival_time as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time2), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='LX' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
					odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time2), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND';";
				//WKND
				} else {
					out.print("Transit lines from Busch to Cook/Douglass: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
					odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', s.arrival_time3 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time3), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line ";
					odSearch += "WHERE s.transit_line='WKND';";
				}
				
			//LIV	
			} else if (originSt.equals("LIV")) {
				if(destSt.equals("LIV")) {
					out.print("Error, origin and destination are the same, please choose a different destination. ");
					out.print("Click <a href=\'selectStation.jsp\'> here</a> to go back. <br>");	
				//LX, WKND	
				} else if(destSt.equals("BUS")) {
					out.print("Transit lines from Livingston to Busch: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line ";
					odSearch += "WHERE s.transit_line='LX' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND'";	
				//WKND
				} else if(destSt.equals("CA")) {
					out.print("Transit lines from Livingston to College Ave: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop2 as 'Destination', ";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time2), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND';";		
				//WKND
				} else {
					out.print("Transit lines from Livingston to Cook/Douglass: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop3 as 'Destination', ";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time3 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time3), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND';";
				}
			
			//CA
			} else if(originSt.equals("CA")) {
				if(destSt.equals("CA")) {
					out.print("Error, origin and destination are the same, please choose a different destination. ");
					out.print("Click <a href=\'selectStation.jsp\'> here</a> to go back. <br>");	
				//H, REXB, REXL	
				} else if (destSt.equals("BUS")) {
					out.print("Transit lines from College Ave to Busch: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination', ";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='H' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
					odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', t.arrival_time as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time2), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXB' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
					odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time2), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
				//REXL
				} else if(destSt.equals("LIV")) {
					out.print("Transit lines from College Ave to Livingston: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop3 as 'Destination',";
					odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', s.arrival_time3 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time3), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
				//EE, WKND
				} else {
					out.print("Transit lines from College Ave to Cook/Douglass: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='EE' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop2 as 'Origin', s.stop3 as 'Destination',";
					odSearch += "t.date as 'Date', s.departure_time2 as 'Departure Time', t.arrival_time as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time2, arrival_time3), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND'";
				}
			
			//CD
			} else {
				if(destSt.equals("CD")) {
					out.print("Error, origin and destination are the same, please choose a different destination. ");
					out.print("Click <a href=\'selectStation.jsp\'> here</a> to go back. <br>");	
				//REXB, REXL
				} else if(destSt.equals("BUS")) {
					out.print("Transit lines from Cook/Douglass to Busch: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop2 as 'Destination', ";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time2), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXB' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop2 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time2), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
				//REXL
				} else if(destSt.equals("LIV")) {
					out.print("Transit lines from Cook/Douglass to Livingston: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop3 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', t.arrival_time as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time3), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
				//F, REXB, REXL
				} else {
					out.print("Transit lines from Cook/Douglass to College Ave: <br>");
					odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='F' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXB' UNION ";
					odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
					odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
					odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare_per_stop as 'Fare per Stop' ";
					odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
				}
			}
			
			ResultSet odResult = stmt.executeQuery(odSearch);
			odResult.last();
			int row = odResult.getRow();
			odResult.beforeFirst();
			
			int count = 0;
			String[][] query = new String[row][9];
			while(odResult.next()) {
				query[count][0] = "" + odResult.getInt("Train Number");
				query[count][1] = odResult.getString("Transit Line");
				query[count][2] = odResult.getString("Origin");
				query[count][3] = odResult.getString("Destination");
				query[count][4] = odResult.getDate("Date").toString();
				query[count][5] = odResult.getString("Departure Time");
				query[count][6] = odResult.getString("Arrival Time");
				query[count][7] = odResult.getString("Travel Time");
				query[count][8] = "$" + odResult.getDouble("Fare per Stop");
				count++;
			}
			odResult.close();
			
			session.setAttribute("transitLine", "Transit Line");
			session.setAttribute("travelTime", "Travel Time");
			session.setAttribute("odResult", query);
			session.setAttribute("originSt", originSt);
			session.setAttribute("destSt", destSt);
			
			out.println("<table style='width:100%'>");
			out.print("<td><b>#</b></td>");
			out.print("<td><b>Train Number</b></td>");
			out.print("<td><b>Transit Line</b></td>");
			out.print("<td><b>Origin Station</b></td>");
			out.print("<td><b>Destination Station</b></td>");
			out.print("<td><b>Date</b></td>");
			out.print("<td><b>Departure Time</b></td>");
			out.print("<td><b>Arrival Time</b></td>");
			out.print("<td><b>Travel Time</b></td>");
			out.print("<td><b>Fare per Stop</b></td>");                  
	    
	        
	        //Prints values into matrix
			for(int i=0; i<row; i++) {
				out.print("<tr><td>" + (i+1) + "</td><td>" + query[i][0] + "</td>");
				out.print("<td>" + query[i][1] + "</td>");
				out.print("<td>" + query[i][2] + "</td>");
				out.print("<td>" + query[i][3] + "</td>");
				out.print("<td>" + query[i][4] + "</td>");
				out.print("<td>" + query[i][5] + "</td>");
				out.print("<td>" + query[i][6] + "</td>");
				out.print("<td>" + query[i][7] + "</td>");
				out.print("<td>" + query[i][8] + "</td></tr>");
			}
			out.println("</table>");
				
			out.println("<form method=\"GET\" action=\"confirmReservation.jsp\">");
			out.println("<br> Please select the entry # of the train you would like to book: ");
			out.println("<select name=\"entryNum\">");
				for(int i=0; i<row; i++) {
					out.println("<option value=\"" + i + "\">" + (i+1) + "</option>");
				}
			out.println("</select>");
			
			out.println("<br> Trip type: ");
			out.println("<select name=\"tripType\">");
			out.println("<option value=\"One way\">One way</option> <option value=\"Round trip\">Round trip</option>");
			out.println("</select>");
			
			out.println("<br> Do you belong to any of the following: ");
			out.println("<select name=\"passStatus\">");
			out.println("<option value=\"N/A\">N/A</option> <option value=\"Senior\">Senior</option> <option value=\"Child\">Child</option> <option value=\"Disabled\">Disabled</option>");
			out.println("</select>");
			
			out.println("<br> <input type=\"submit\" value=\"Submit\">");
			
			out.println("<br><br><br>Wrong origin or destination? Click <a href=\"selectStation.jsp\">here</a> to go back.");
			out.println("</form>");
			
	
			conn.close();
			stmt.close();
			

			
		} catch(Exception e) {
			out.print(e); 
		}
	%>

			

</body>
</html>