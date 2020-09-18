<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Insert title here</title>
</head>
<body>
	
	<%
	try {
		
		//Connection to database
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		//mySQL statement
		Statement stmt = con.createStatement();
		
		//Inputs from account creation page
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		//Query
		String query = "INSERT INTO Customers(username, password, firstname, lastname, email) VALUES(?, ?, ?, ?, ?);";
		
		//Created Prepared mySQL statement
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, username);
		ps.setString(2, password);
		ps.setString(3, firstname);
		ps.setString(4, lastname);
		ps.setString(5, email);
		ps.executeUpdate();
		
		//Close connection
		con.close();
		out.print("Account successfully created!");
	} catch (Exception e) {
		out.print(e);
		out.print("Error creating account");
		
	}
	
	response.sendRedirect("createAccount_success.jsp");
	
	%>

</body>
</html>