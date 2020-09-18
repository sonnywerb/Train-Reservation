<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Customer Representatives</title>
</head>

<body>

	<b>Edit Customer Representatives</b>
		<br>
		Go <a href="adminHomepage.jsp"> back</a>.
		<br>
		Enter the SSN of the Customer Representative whose data you wish to change.
			<form method = "POST" action="editCustomerReps.jsp">
				<table>
					<tr>
						<td> SSN: </td> <td> <input type="text" name="ssn"> </td>
					</tr>
				</table>
				
				<!-- Create account button -->
				<input type="submit" value="Fetch">
			</form>
		<br>

</body>
</html>