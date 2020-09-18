<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Deleting Customer Representatives</title>
</head>
<body>

	<%
		if(session.getAttribute("user") == null) {
			out.print("You have been logged out, please <a href='login.jsp'> log in</a> again.");
		} else {
			try {
				//Connection to database
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
				//mySQL statement
				Statement stmt = con.createStatement();
				
				//Inputs from delete customer representative page
				String ssn = request.getParameter("txt_ssn");
				
				//Query 
				String query = "DELETE FROM Employees WHERE ssn = ?;";
				
				//Created Prepared mySQL statement
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, ssn);
				ps.executeUpdate();
				
				//Close connection
				con.close();
				out.print("Customer representative successfully deleted!");
			} catch (Exception e) {
				out.print(e);
				out.print("Error deleting customer representative data.");
				
			}
			response.sendRedirect("deleteCustomerReps_success.jsp");
		}
	%>

</body>
</html>