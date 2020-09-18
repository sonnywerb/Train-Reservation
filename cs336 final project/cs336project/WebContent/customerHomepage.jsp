<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Page</title>
</head>

<body>
	
	<%
		if(session.getAttribute("user") == null) {
			out.print("You have been logged out, please <a href='login.jsp'> log in</a> again.");
		} else {
			out.print("<b> Welcome, " + session.getAttribute("user") + "!</b><br>");
			session.setAttribute("customer?", "true");
			
			out.print("<br><b> Train Schedules </b><br>");
			out.print("Click <a href = 'searchTrainSchedule.jsp'> here</a> to search for train schedules. <br>");
					
			out.print("<br><b> Train Reservations </b><br>");
			out.print("Click <a href = 'selectStation.jsp'> here</a> to make a reservation. <br>");
			out.print("Click <a href = 'viewReservations.jsp'> here</a> to view all your reservations.<br>");
			
			out.print("<br><b> Inbox </b><br> ");
			out.print("Click <a href='customerInbox.jsp'> here</a> to view your messages.<br>");
	
			out.print("<br> <a href='logout.jsp'> Log out</a>");
		}
	%>

</body>
</html>