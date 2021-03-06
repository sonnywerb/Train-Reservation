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
		<form method = "POST" action="editCustomerReps_action.jsp">
	
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
				
				//Inputs from edit customer representative select page
				String ssn = request.getParameter("ssn");
				
				//Query 1
				String query = "SELECT * FROM Employees e WHERE e.SSN = '" + ssn + "' AND e.type = 'CustomerRep';";
				
				//Execute statement to fetch by SSN
				ResultSet resultSet = stmt.executeQuery(query);
				
				//If there is no such entry, redirect to error page.
				if (!resultSet.next())
				{
					out.print("Unable to fetch Customer Representative with that SSN.");
					response.sendRedirect("editCustomerReps_failure.jsp");
				}
				
				else
				{
					ssn = resultSet.getString("SSN");
					String firstname = resultSet.getString("firstname");
					String lastname = resultSet.getString("lastname");
					String username = resultSet.getString("username");
					String password = resultSet.getString("password");
					
				%>
					
					<table>
						<tr>
							<td> First name: </td> <td> <input type="text" name="txt_firstname" value=<%=firstname %>> </td> 
						</tr>
						<tr>
							<td> Last name: </td> <td> <input type="text" name="txt_lastname" value=<%=lastname %>> </td>
						</tr> 					
						<tr>
							<td> Username: </td> <td> <input type="text" name="txt_username" value=<%=username %>> </td>
						</tr>
						<tr>
							<td> Password: </td> <td> <input type="text" name="txt_password" value=<%=password %>> </td>
						</tr>
						<tr>
							<td> SSN: </td> <td> <input type="text" name="txt_ssn" value=<%=ssn %>> </td>
						</tr>
						
					</table>
							
					<!-- Submit changes button -->
					<input type="hidden" name="original_ssn" value="<%=ssn %>">
					<input type="submit" value="Submit Changes">
			
				<% }
				
				//Close connection
				resultSet.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				out.print(e);
				out.print("Error editing customer representative data.");	
			}
		}
	%>
	
	</form>
	<br>

</body>
</html>