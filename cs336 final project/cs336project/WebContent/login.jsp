<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>

<body>
	
	<b> Login </b>
	<br>
	<form method="POST" action="login_action.jsp"> 
		<table>
			<tr>
				<td> Username: </td> <td> <input type="text" name="username"> </td>
			</tr>
			<tr>
				<td> Password: </td> <td> <input type="password" name="password"> </td>
			</tr>
		
		</table>
		
		<!--  Submit button -->
		<input type="submit" value="Login">
	</form>
	
	<br>
	Don't have an account? Click <a href="createAccount.jsp"> here</a> to create one!
	
	<br>
	<a href="loginAdmin.jsp"> Admin Login</a>
	
	<br>
	<a href="loginCustomerRep.jsp"> Customer Representative Login </a>
	
</body>
</html>