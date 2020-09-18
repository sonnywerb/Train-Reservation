<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Searching...</title>
</head>
<body>

<%
	
	try{
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		String originSt = request.getParameter("originSelect");
		String destSt = request.getParameter("destinationSelect");
		String odSearch = "";
		
		//out.println(destSt);
		//out.println(originSt);
		
		if(originSt.equals("BUS")) {
			if(destSt.equals("BUS")) {
				out.print("Error, origin and destination are the same, please choose a different destination. ");
				
				//B, REXL
			} else if(destSt.equals("LIV")) {
				out.print("Transit Schedules from Busch to Livingston: <br>");
				odSearch = "SELECT t. train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', t.arrival_time as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='B' UNION ";
				odSearch +=	"SELECT t. train_ID as 'Train Number',s.transit_line as 'Transit Line', s.stop2 as 'Origin', s.stop3 as 'Destination',";	
				odSearch +=	"t.date as 'Date', t.departure_time as 'Departure Time', t.arrival_time as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time2, arrival_time3), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
			//A, LX, WKND
			} else if(destSt.equals("CA")){
				out.print("Transit Schedules from Busch to College Ave: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='A' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
				odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', t.arrival_time as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time2), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='LX' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
				odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time2), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND';";
			//WKND
			} else {
				out.print("Transit Schedules from Busch to Cook/Douglass: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
				odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', s.arrival_time3 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time3), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line ";
				odSearch += "WHERE s.transit_line='WKND';";
			}
			
		//LIV	
		} else if (originSt.equals("LIV")) {
			if(destSt.equals("LIV")) {
				out.print("Error, origin and destination are the same, please choose a different destination. ");
					
			//LX, WKND	
			} else if(destSt.equals("BUS")) {
				out.print("Transit Schedules from Livingston to Busch: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line ";
				odSearch += "WHERE s.transit_line='LX' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND'";	
			//WKND
			} else if(destSt.equals("CA")) {
				out.print("Transit Schedules from Livingston to College Ave: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop2 as 'Destination', ";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time2), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND';";		
			//WKND
			} else {
				out.print("Transit Schedules from Livingston to Cook/Douglass: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop3 as 'Destination', ";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time3 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time3), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND';";
			}
		
		//CA
		} else if(originSt.equals("CA")) {
			if(destSt.equals("CA")) {
				out.print("Error, origin and destination are the same, please choose a different destination. ");
				
			//H, REXB, REXL	
			} else if (destSt.equals("BUS")) {
				out.print("Transit Schedules from College Ave to Busch: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination', ";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='H' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
				odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', t.arrival_time as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time2), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXB' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop2 as 'Destination',";
				odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time2), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
			//REXL
			} else if(destSt.equals("LIV")) {
				out.print("Transit Schedules from College Ave to Livingston: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop1 as 'Origin', s.stop3 as 'Destination',";
				odSearch += "t.date as 'Date', s.departure_time1 as 'Departure Time', s.arrival_time3 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time1, arrival_time3), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
			//EE, WKND
			} else {
				out.print("Transit Schedules from College Ave to Cook/Douglass: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='EE' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.stop2 as 'Origin', s.stop3 as 'Destination',";
				odSearch += "t.date as 'Date', s.departure_time2 as 'Departure Time', t.arrival_time as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, departure_time2, arrival_time3), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='WKND'";
			}
		
		//CD
		} else {
			if(destSt.equals("CD")) {
				out.print("Error, origin and destination are the same, please choose a different destination. ");
			
			//REXB, REXL
			} else if(destSt.equals("BUS")) {
				out.print("Transit Schedules from Cook/Douglass to Busch: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop2 as 'Destination', ";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time2), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXB' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop2 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time2 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time2), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
			//REXL
			} else if(destSt.equals("LIV")) {
				out.print("Transit Schedules from Cook/Douglass to Livingston: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop3 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', t.arrival_time as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time3), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXL';";
			//F, REXB, REXL
			} else {
				out.print("Transit Schedules from Cook/Douglass to College Ave: <br>");
				odSearch = "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='F' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
				odSearch += "FROM Stops s join Train_Schedule t on s.transit_line=t.transit_line WHERE s.transit_line='REXB' UNION ";
				odSearch += "SELECT t.train_ID as 'Train Number', s.transit_line as 'Transit Line', s.origin as 'Origin', s.stop1 as 'Destination',";
				odSearch += "t.date as 'Date', t.departure_time as 'Departure Time', s.arrival_time1 as 'Arrival Time' ";
				odSearch += ",CONCAT(TIMESTAMPDIFF(MINUTE, t.departure_time, s.arrival_time1), ' minutes') AS 'Travel Time', t.fare as 'Total Fare' ";
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
			query[count][8] = "$" + odResult.getDouble("Total Fare");
			count++;
		}
		odResult.close();
		
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
		out.print("<td><b>Total Fare</b></td>");     
		
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
		
		
		
		stmt.close();
		conn.close();
	}catch (Exception e) {
		out.println(e);
	}
	
	
	out.println("<br><br>Click <a href='customerRepHP.jsp'> here</a> to return to the home page.");

%>
</body>
</html>