<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Select Train Schedules</title>
</head>
<body>
	
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

<%
	try {
		
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
	
		String schedQuery = "";
		schedQuery = "SELECT * FROM Train_Schedule;";
		ResultSet rSched = stmt.executeQuery(schedQuery);
		
		while(rSched.next()) {
%>	
		<tr>
		<td> <%=rSched.getInt("train_ID")%> </td>
		<td> <%=rSched.getString("transit_line")%> </td>
		<td> <%=rSched.getString("origin")%> </td>
		<td> <%=rSched.getString("destination")%> </td>
		<td> <%=rSched.getString("date")%> </td>
		<td> <%=rSched.getString("departure_time")%> </td>
		<td> <%=rSched.getString("arrival_time")%> </td>
		<td> <%=rSched.getInt("stops")%> </td>
		<td> <%=rSched.getDouble("fare_per_stop")%> </td>
		<td>
			<form method="POST" action ="editTrainSchedule.jsp">
				<input type="hidden" name="editTrainID" value = <%=rSched.getInt("train_ID")%>>
				<input type="hidden" name="editDate" value = <%=rSched.getString("date")%>>	
				<input type="hidden" name="editDepartTime" value= <%=rSched.getString("departure_time")%> >
				<input type="hidden" name="editArrivalTime" value= <%=rSched.getString("arrival_time")%>>
			</form>
		</td>
		<td>
			<form method="POST" action="deleteTrainSchedule.jsp"> 
				<input type="hidden" name="deleteTrainID" value = <%=rSched.getInt("train_ID")%>>
				<input type="hidden" name="deleteDate" value = <%=rSched.getString("date")%>>	
				<input type="hidden" name="deleteDepartTime" value= <%=rSched.getString("departure_time")%> >
				<input type="hidden" name="deleteArrivalTime" value= <%=rSched.getString("arrival_time")%>>
			</form>
		</td>
		</tr>
<% 		
		
		}
		//Edit selection
		out.println("<form method=\'GET\' action=\"editTrainSchedule.jsp\">");
		out.println("Select the transit line that you would like to <b>EDIT</b> the information of: <br>");
		out.println("<select name=\'edit_transitline\'>");
			out.println("<option value=\'A\'>A</option>");
			out.println("<option value=\'B\'>B</option>");
			out.println("<option value=\'EE\'>EE</option>");
			out.println("<option value=\'F\'>F</option>");
			out.println("<option value=\'H\'>H</option>");
			out.println("<option value=\'LX\'>LX</option>");
			out.println("<option value=\'REXB\'>REXB</option>");
			out.println("<option value=\'REXL\'>REXL</option>");
			out.println("<option value=\'WKND\'>WKND</option>");
		out.println("</select>");
		out.println("<input type=\'submit\' value=\'Submit\'>");
		out.println("</form>");
		
		out.println("<br> <b> OR </b> <br>");
		
		//Delete selection
		out.println("<form method='GET' action=\"deleteTrainSchedule.jsp\">");
		out.println("Select the transit line that you would like to <b>DELETE</b>: <br>");
		out.println("<select name=\'delete_transitline\'>");
			out.println("<option value='A'>A</option>");
			out.println("<option value='B'>B</option>");
			out.println("<option value='EE'>EE</option>");
			out.println("<option value='F'>F</option>");
			out.println("<option value='H'>H</option>");
			out.println("<option value='LX'>LX</option>");
			out.println("<option value='REXB'>REXB</option>");
			out.println("<option value='REXL'>REXL</option>");
			out.println("<option value='WKND'>WKND</option>");
		out.println("</select>");
		out.println("<input type=\'submit\' value=\'Submit\'>");
		out.println("</form>");
		
		rSched.close();
		stmt.close();
		conn.close();
	} catch (Exception e) {
		out.println(e);
	}
	
%>
<br><br>
		Click <a href='customerRepHP.jsp'> here</a> to return to home page.
</body>
</html>