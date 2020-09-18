<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>
<body>
	
	<%
	try {
		//connection to database
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		
		//create SQL statement
		Statement stmt = conn.createStatement();
		
		//search by parameters
		String searchBy = request.getParameter("searchBy");
		String sortBy = request.getParameter("sortBy");
		String searchInput = request.getParameter("searchInput");
		
		//Search SQL query
		String searchQuery = "";
		if(searchBy.equals("origin") && sortBy.equals("arrivalTime")) {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE origin LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY arrival_time;";
		
		} else if(searchBy.equals("origin") && sortBy.equals("departureTime")) {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE origin LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY departure_time;";
		
		} else if(searchBy.equals("origin") && sortBy.equals("fare")) {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE origin LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY fare;";
			
		} else if(searchBy.equals("destination") && sortBy.equals("arrivalTime")) {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE destination LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY arrival_time;";
		
		} else if(searchBy.equals("destination") && sortBy.equals("departureTime")) {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE destination LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY departure_time;";	
		
		} else if(searchBy.equals("destination") && sortBy.equals("fare")) {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE destination LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY fare;";
			
		} else if(searchBy.equals("date") && sortBy.equals("arrivalTime")) {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE date LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY arrival_time;";
			
		} else if(searchBy.equals("date") && sortBy.equals("departureTime")) {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE date LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY departure_time;";
		
		} else {
			searchQuery = "SELECT train_ID AS 'Train Number', transit_line AS 'Transit Line',";
			searchQuery += "fare AS 'Total Fare', CONCAT(TIMESTAMPDIFF(MINUTE, departure_time, arrival_time), ' minutes') AS 'Travel Time', stops AS 'Stops',";
			searchQuery += "origin AS 'Origin', destination AS 'Destination', date AS 'Date',";
			searchQuery += "departure_time AS 'Departure Time',";
			searchQuery += "arrival_time AS 'Arrival Time'";
			searchQuery += "FROM Train_Schedule WHERE date LIKE '%" + searchInput + "%'";
			searchQuery += "ORDER BY fare;";
		}
		
		ResultSet results = stmt.executeQuery(searchQuery);
		results.last();
		int row = results.getRow();
		results.beforeFirst();
		
		out.print("<b>Here are your search results:</b> <br>");
		
		//Creates matrix of results
		int count = 0;
		String[][] queryResult = new String[row][10];
		while(results.next()) {
			queryResult[count][0] = "" + results.getInt("Train Number");
			queryResult[count][1] = results.getString("Transit Line");
			queryResult[count][2] = results.getString("Origin");
			queryResult[count][3] = results.getString("Destination");
			queryResult[count][4] = results.getString("Date");
			queryResult[count][5] = results.getString("Departure Time");
			queryResult[count][6] = results.getString("Arrival Time");
			queryResult[count][7] = results.getString("Stops");
			queryResult[count][8] = results.getString("Travel Time");
			queryResult[count][9] = "$" + results.getDouble("Total Fare");
			count++;
		}
	
		results.close();
		
		session.setAttribute("results", results);
		session.setAttribute("searchBy", searchBy);
		session.setAttribute("sortBy", sortBy);
		session.setAttribute("searchInput", searchInput);
		
		//Creates table headers
		out.println("<table style='width:100%'>");
		out.print("<td><b>#</b></td>");
		out.print("<td><b>Train Number</b></td>");
		out.print("<td><b>Transit Line</b></td>");
		out.print("<td><b>Origin</b></td>");
		out.print("<td><b>Destination</b></td>");
		out.print("<td><b>Date</b></td>");
		out.print("<td><b>Departure Time</b></td>");
		out.print("<td><b>Arrival Time</b></td>");
		out.print("<td><b>Travel Time</b></td>");
		out.print("<td><b>Total Fare</b></td>");
                                               
    
        
        //Prints values into matrix
		for(int i=0; i<row; i++) {
			out.print("<tr><td>" + (i+1) + "</td><td>" + queryResult[i][0] + "</td>");
			out.print("<td>" + queryResult[i][1] + "</td>");
			out.print("<td>" + queryResult[i][2] + "</td>");
			out.print("<td>" + queryResult[i][3] + "</td>");
			out.print("<td>" + queryResult[i][4] + "</td>");
			out.print("<td>" + queryResult[i][5] + "</td>");
			out.print("<td>" + queryResult[i][6] + "</td>");
			out.print("<td>" + queryResult[i][7] + "</td>");
			out.print("<td>" + queryResult[i][8] + "</td></tr>");
		}
		out.println("</table>");
		out.println("<br>Click <a href=\"searchTrainSchedule.jsp\">here</a> to initiate new search.");
		
		stmt.close();
		conn.close();
	
	} catch(Exception e) {
		out.println("Search Error:" + e);
		
	}
	
	%>
	<br>
	

</body>
</html>