<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Loading...</title>
</head>
<body>

	<% 
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			
			Statement stmt = conn.createStatement();
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String adminSearch = "SELECT username,password,type FROM Employees WHERE username = '" + username + "' and password = '" + password +"' and type = 'Admin';";
			ResultSet credentials = stmt.executeQuery(adminSearch);
			
			if(credentials.next()) {
				session.setAttribute("user", username);
				response.sendRedirect("adminHomepage.jsp");
			} else {
				out.println("Invalid username or password. Please try again <a href='loginAdmin.jsp'> here</a>. <br> Not an Admin? Click <a href='login.jsp'> here</a> to return to the login page.");		
			}
			
			credentials.close();
			stmt.close();
			conn.close();
						
		} catch(Exception e) {
			out.print(e + "<br>" + "Login failed, click <a href='login.jsp'> here</a> to go back to login page.");
		}
	%>

</body>
</html>