<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new account</title>
</head>

<body>
	<b>Account Registration</b>
		<br>
		Already have an account? Login <a href="login.jsp"> here</a>.
			<form method = "POST" action="createAccount_action.jsp">
				<table>
					<tr>
						<td> First name: </td> <td> <input type="text" name="firstname"> </td> 
					</tr>
					<tr>
						<td> Last name: </td> <td> <input type="text" name="lastname"> </td>
					</tr> 					
					<tr>
						<td> Username: </td> <td> <input type="text" name="username"> </td>
					</tr>
					<tr>
						<td> Email: </td> <td> <input type="email" name="email"> </td>
					</tr>
					<tr>
						<td> Password: </td> <td> <input type="password" name="password"> </td>
					</tr>
					
				</table>
				
				<!-- Create account button -->
				<input type="submit" value="Register">
			</form>
		<br>

</body>
</html>