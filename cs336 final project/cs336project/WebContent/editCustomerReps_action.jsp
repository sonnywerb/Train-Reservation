<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Editing Customer Representatives</title>
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
				
				//Inputs from edit customer representative page
				String old_ssn = request.getParameter("original_ssn");
				String firstname = request.getParameter("txt_firstname");
				String lastname = request.getParameter("txt_lastname");
				String username = request.getParameter("txt_username");
				String password = request.getParameter("txt_password");
				String ssn = request.getParameter("txt_ssn");
				
				//Query 
				String query = "UPDATE Employees SET ssn = ?, username = ?, password = ?, firstname = ?, lastname = ? WHERE ssn = ?;";
				
				//Created Prepared mySQL statement
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, ssn);
				ps.setString(2, username);
				ps.setString(3, password);
				ps.setString(4, firstname);
				ps.setString(5, lastname);
				ps.setString(6, old_ssn);  // Type 2 is CustomerRep
				ps.executeUpdate();
				
				//Close connection
				con.close();
				out.print("Customer representative successfully changed!");
			} catch (Exception e) {
				out.print(e);
				out.print("Error editing customer representative data.");
				
			}
			response.sendRedirect("editCustomerReps_success.jsp");
		}
	%>

</body>
</html>