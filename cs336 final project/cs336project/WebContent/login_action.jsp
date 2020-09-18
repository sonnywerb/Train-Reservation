<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging in...</title>
</head>
<body>

	<% 
		try {
			
			//Connection to database
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			
			//SQL statement
			Statement stmt = conn.createStatement();
			
			//Check login parameters
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			//Check if user exists
			String userSearch = "SELECT username, password FROM Customers WHERE username ='" + username + "' and password = '" + password + "';";
			ResultSet credentials = stmt.executeQuery(userSearch);
			
			if(credentials.next()) {
				session.setAttribute("user", username);
				out.println("Welcome, " + username);
				response.sendRedirect("customerHomepage.jsp");
			} else {
				out.println("Invalid username or password. Return to <a href='login.jsp'> login</a> page, or click <a href='createAccount.jsp'> here</a> to create an account.");
			}
			
			credentials.close();
			stmt.close();
			conn.close();
			
		} catch(Exception e) {
			out.print(e + "<br>" + "Login failed, please try <a href='login.jsp'> again. </a>");
		}
	
	%>

</body>
</html>