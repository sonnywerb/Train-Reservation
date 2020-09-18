<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservation Confirmation</title>
</head>
<body>

<%
	try {
		
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
	
		
		Object username = session.getAttribute("user");
		Object originStation = session.getAttribute("originSt");
		Object destStation = session.getAttribute("destSt");
		
		//String transitLine = request.getParameter("transitLine");
		String tripType = request.getParameter("tripType");
		String passStatus = request.getParameter("passStatus");
		String user = (String) username;
		String originSt = (String) originStation;
		String destSt = (String) destStation;
		
	
		//Sets reservation number
		String resNum = "SELECT IF(MAX(res_number) IS NULL, 1, MAX(res_number)+1) as nextResNumber FROM Reservations;";
		ResultSet rs = stmt.executeQuery(resNum);
		int resNumber = 0;
		if(rs.next()) {
			resNumber = rs.getInt("nextResNumber");
		}
		session.setAttribute("resNumber", resNumber);

		
		//Gets passenger's name from username
		String getName = "";
		getName = "SELECT CONCAT(firstname, CONCAT(' ',lastname)) AS 'Passenger Name' FROM Customers WHERE'" + user + "'= username";
		ResultSet fullName = stmt.executeQuery(getName);	
		String passName = "";
		while(fullName.next()) {
			passName = fullName.getString("Passenger Name");
		}
		
		
		out.println("Thank you! Here are your reservation details. <br><br>");
		out.println("<b> Passenger Name: </b>" + passName + "<br>" );
		out.println("<b>Reservation Number: </b>" + resNumber + "<br>");		
		out.println("<b>Trip Type: </b>" + tripType + "<br>");
		
		int row = Integer.parseInt(request.getParameter("entryNum"));
		String[][] entryRes = (String[][])session.getAttribute("odResult");	
		out.println("<b>Train Number: </b>" + entryRes[row][0] + "<br>");
		out.println("<b>Transit Line: </b>" + entryRes[row][1] + "<br>");
		out.println("<b>Origin Station: </b>" + entryRes[row][2] + "<br>");
		out.println("<b>Destination Station: </b>" + entryRes[row][3] + "<br>");
		out.println("<b>Date: </b>" + entryRes[row][4] + "<br>");
		out.println("<b>Departure Time: </b>" + entryRes[row][5] + "<br>");
		out.println("<b>Arrival Time: </b>" + entryRes[row][6] + "<br>");
		out.println("<b>Travel Time: </b>" + entryRes[row][7] + "<br>");
		
		
		//Transit line of selected train reservation
		String transitLine = entryRes[row][1];
		session.setAttribute("transitLine", transitLine);
		
		//Gets the fare per stop for each transit line
		String getFare = "";
		getFare = "SELECT fare_per_stop FROM Train_Schedule WHERE transit_line = '" + transitLine + "';"; 
		ResultSet farePerStop = stmt.executeQuery(getFare);
		
		double fare = 0;
		while(farePerStop.next()) {
			fare = farePerStop.getDouble("fare_per_stop");
		}
		//Fare for individual transit line
		//Busch 
		if(originSt.equals("BUS")) {
			if(destSt.equals("LIV") || destSt.equals("CA")) {
				fare = fare * 1;
			//Destination is Cook/Douglass
			} else { 
				fare = fare * 2;
			}
		//Livingston 
		} else if(originSt.equals("LIV")) {
			if(destSt.equals("BUS")) {
				fare = fare * 1;
			} else if(destSt.equals("CA")) {
				fare = fare * 2;
			} else {
				fare = fare * 3;
			}
		//College Ave 		
		} else if(originSt.equals("CA")) {
			if(destSt.equals("BUS") || destSt.equals("CD")) {
				fare = fare * 1;
			} else {
				fare = fare * 2;
			}	
		//Cook/Douglass 
		} else {
			if(destSt.equals("CA")) {
				fare = fare * 1;
			} else if(destSt.equals("BUS")) {
				fare = fare * 2;
			} else {
				fare = fare * 3;
			}
		}
		
		//One way or round trip fare
		if(tripType.equals("Round trip")) {
			fare = 2 * fare;
		} else {
			fare = 1 * fare;
		}
			
		if(passStatus.equals("Senior")) {
			fare = fare * .65;
		} else if(passStatus.equals("Child")) {
			fare = fare * .75;
		} else if(passStatus.equals("Disabled")) {
			fare = fare * .5;
		} else {
			fare = fare * 1;
		}
		
		out.println("<b>Total fare: </b>$" + fare + "<br>");
		
		//Insert into Reservations Table
		String addRes = "";
		addRes = "INSERT INTO Reservations VALUES(" + resNumber + ",'" + entryRes[row][4] + "','" + entryRes[row][5] + "','" + entryRes[row][6] + "','" + tripType +  "'," + fare + ",'" + passName + "','" + passStatus + "','" + entryRes[row][2] + "','" + entryRes[row][3] + "','" + entryRes[row][0] + "','" + entryRes[row][1] + "','" + entryRes[row][7] + "');";
		stmt.executeUpdate(addRes);
		
		//Insert into Bookings Table(Connects Customers to Reservations)
		String bookings = "";
		bookings = "INSERT INTO Bookings VALUES(" + resNumber + ",'" + user + "');";
		stmt.executeUpdate(bookings);
	
		rs.close();
		fullName.close();
		farePerStop.close();
		conn.close();
		stmt.close();
		
		out.println("<br><br>Made a mistake? Click <a href=\"cancelReservation.jsp\"> here</a> to cancel the reservation.");
		out.println("<br><br>Want to make another reservation? Click <a href=\'selectStation.jsp\'> here</a>!");
		out.println("<br><br>Click <a href=\'viewReservations.jsp\'> here</a> to view all your reservations.");
		
	} catch (NullPointerException e) {
		out.println(e + "Missing information, lease click <a href=\'selectStation.jsp\'> here</a> to try again.");
		
	} catch (Exception e) {
		out.println(e + "<br><br>Error making reservaiton, please click <a href=\'selectStation.jsp\'> here</a> to try again.");
	}


%>

</body>
</html>