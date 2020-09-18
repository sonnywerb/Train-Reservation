<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Train Schedule Info</title>
</head>
<body>
	
	<form method="POST" action="editTrainSchedule_action.jsp">
	<h1> Edit Train Schedule </h1>
	
	<%
	try {
		
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		String getTransitLine = request.getParameter("edit_transitline");
		session.setAttribute("transitlineStops", getTransitLine);
				
		String queryTL = "SELECT * FROM Train_Schedule WHERE transit_line= '" + getTransitLine + "';";
		ResultSet tlEdit = stmt.executeQuery(queryTL);
		
		while(tlEdit.next()) {
	%>
		Editing information for Transit Line: <b> <%=tlEdit.getString("transit_line")%> </b><br>
		<fieldset>
			
				<label for="newTrainID"> Train ID: </label>
				<input type="text" name="newTrainID" value="<%=tlEdit.getInt("train_ID")%>"> <br>
			
		
			
				<label for="newDate">  Date:  </label>
				<input type="text" name="newDate" value="<%=tlEdit.getString("date")%>"> <br>
			
			
			
				<label for="newDepartTime"> Departure Time: </label>
				<input type="text" name="newDepartTime" value="<%=tlEdit.getString("departure_time")%>"> <br>
			
			
			
				<label for="newArrivalTime"> Arrival Time: </label> 
				<input type="text" name="newArrivalTime" value="<%=tlEdit.getString("arrival_time")%>"> 
			
		</fieldset>
		
		
		
		<input type="hidden" name="ogTrainID" value = <%=tlEdit.getInt("train_ID")%>>
		<input type="hidden" name="ogDate" value = <%=tlEdit.getString("date")%>>	
		<input type="hidden" name="ogDepartTime" value= <%=tlEdit.getString("departure_time")%> >
		<input type="hidden" name="ogArrivalTime" value= <%=tlEdit.getString("arrival_time")%>>
		
		<br>
		<center>
		<input type="submit" name="updateTrains" value="Save">
		</center>
		
		
	<%
		}
		
	tlEdit.close();
	conn.close();
	stmt.close();
		
	}catch (Exception e){
		out.println(e);
	}
	%>
	

	<br><br>
	Click <a href="customerRepHP.jsp"> here</a> to return to the home page.
	</form>
	
</body>
</html>