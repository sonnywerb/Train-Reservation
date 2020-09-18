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
			
			out.print("<br><b> Employee Management </b><br>");
			out.print("Click <a href = 'addCustomerReps.jsp'> here</a> to add a new customer representative employee. <br>");
			out.print("Click <a href = 'editCustomerReps_select.jsp'> here</a> to modify information pertaining to customer representatives. <br>");
			out.print("Click <a href = 'deleteCustomerReps_select.jsp'> here</a> to delete customer representatives. <br>");
					
			out.print("<br><b> Sales and Revenue Data </b><br>");
			out.print("Click <a href = 'viewSalesReports.jsp'> here</a> to obtain sales reports per month. <br>");
			out.print("Click <a href = 'viewAllReservations.jsp'> here</a> to view reservations. <br>");
			out.print("Click <a href = 'viewRevenue.jsp'> here</a> to produce a listing of revenue. <br>");
			
			out.print("<br><b> Data Breakdown </b><br>");
			out.print("Click <a href = 'viewBestData.jsp'> here</a> for information on the best customer and transit lines.<br>");
	
			out.print("<br> <a href='logout.jsp'> Log out</a>");
		}
	%>

</body>
</html>