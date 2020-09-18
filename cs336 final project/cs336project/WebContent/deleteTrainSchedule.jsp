<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Train Schedule</title>
</head>
<body>

<form method="POST" action="deleteTrainSchedule_action.jsp">
	<h1> Delete Train Schedule </h1>
	
	<%
	try {
		
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		String getTransitLine = request.getParameter("delete_transitline");
				
		String queryTL = "SELECT * FROM Train_Schedule WHERE transit_line= '" + getTransitLine + "';";
		ResultSet tlDelete = stmt.executeQuery(queryTL);
		
		while(tlDelete.next()) {
	%>
	<b> WARNING </b>
	<br>
	Are you sure you want to delete transit line: <b> <%=tlDelete.getString("transit_line")%> </b> and the following information?
		<br>
		<fieldset>
		<table BORDER=0 CELLSPACING=0 CELLPADDING=5>
		<tr>
			<th>Train#</th>
			<th>Transit Line</th>
			<th>Origin</th>
			<th>Destination</th>
			<th>Date</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Stops</th>
			<th>Fare per Stop</th>
		</tr>
		<tr>
			<td> <%=tlDelete.getInt("train_ID")%> </td>
			<td> <%=tlDelete.getString("transit_line")%> </td>
			<td> <%=tlDelete.getString("origin")%> </td>
			<td> <%=tlDelete.getString("destination")%> </td>
			<td> <%=tlDelete.getString("date")%> </td>
			<td> <%=tlDelete.getString("departure_time")%> </td>
			<td> <%=tlDelete.getString("arrival_time")%> </td>
			<td> <%=tlDelete.getInt("stops")%> </td>
			<td> <%=tlDelete.getDouble("fare_per_stop")%> </td>
		</tr>
		</table>
		</fieldset>
		
		<input type="hidden" name="delTrainID" value = <%=tlDelete.getInt("train_ID")%>>
		<input type="hidden" name="delDate" value = <%=tlDelete.getString("date")%>>	
		<input type="hidden" name="delDepartTime" value= <%=tlDelete.getString("departure_time")%> >
		<input type="hidden" name="delArrivalTime" value= <%=tlDelete.getString("arrival_time")%>>
		
		<center>
		<input type="submit" value="Delete">
		</center>

	<%
		}
		
		
		conn.close();
		stmt.close();
		
		
	} catch (Exception e) {
		out.println(e + "<br>Deletion failed");
	}
	%>
	
	<br><br>
	Click <a href="customerRepHP.jsp"> here</a> to return to the home page.
	</form>
	
	</form>
</body>
</html>