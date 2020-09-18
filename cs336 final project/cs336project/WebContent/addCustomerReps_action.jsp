<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Customer Representatives</title>
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
			
			//Inputs from add customer representative page
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String ssn = request.getParameter("ssn");
			String type = "CustomerRep";
			
			//Query 1
			String query = "INSERT INTO Employees(ssn, username, password, firstname, lastname, type) VALUES(?, ?, ?, ?, ?, ?);";
			
			//Created Prepared mySQL statement
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, ssn);
			ps.setString(2, username);
			ps.setString(3, password);
			ps.setString(4, firstname);
			ps.setString(5, lastname);
			ps.setString(6, type);  // Type 2 is CustomerRep
			ps.executeUpdate();
			
			//Query 2
			query = "INSERT INTO Customer_Representatives(CR_SSN) VALUES(?);";
			//Created Prepared mySQL statement
			ps = con.prepareStatement(query);
			ps.setString(1, ssn);
			ps.executeUpdate();
			
			//Close connection
			con.close();
			out.print("Customer representative successfully added!");
		} catch (Exception e) {
			out.print(e);
			out.print("Error creating customer representative data.");
			
		}
		response.sendRedirect("addCustomerReps_success.jsp");
	}
	%>

</body>
</html>