<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Employee Homepage </title>
</head>
<body>
<%
	if(session.getAttribute("user") == null) {
		out.println("You have been logged out, please <a href='loginCustomerRep.jsp'> log in</a> again.");
	} else {
		out.println("<b> Welcome " + session.getAttribute("user") + " to your employee homepage.</b> <br>");
		
		out.println("<br><b> Train Schedules </b><br>");
		out.println("Click <a href='selectSchedules.jsp'> here</a> to edit or delete information for train schedules. <br>");
		out.println("Click <a href='stationSchedule.jsp'> here</a> to view schedules by station. <br>");
		out.println("Click <a href='transitLineRes.jsp'> here</a> to see reservations for each transit line. <br>");
				
		out.println("<br><b> Inbox </b><br>");	
		out.println("Click <a href='customerRepInbox.jsp'> here</a> to view messages and inquiries");
	
		out.println("<br><br> <a href='logout.jsp'> Log out</a>");
		
		
	}


%>	
	

</body>
</html>