<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Revenue</title>
</head>
<body>
<b>View Revenue</b>
	<br>
	Go <a href="adminHomepage.jsp"> back</a>.
	<br>
	<br>
	<b> Revenue: </b>
	<table>

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
				
				String listBy = request.getParameter("listBy");
				String query;
				
				if (listBy.equals("transitLine"))
				{
					query = "SELECT r.transitLine, SUM(r.fare) AS rev " +
							"FROM Reservations r " +
							"GROUP BY r.transitLine;";
				}
				else
				{
					query = "SELECT r.passenger_name, SUM(r.fare) AS rev " +
							"FROM Reservations r " +
							"GROUP BY r.passenger_name;";
				}
				
					
				ResultSet resultSet = stmt.executeQuery(query);
				String previous = "";
				while(resultSet.next())
				{
					String groupBy;
					if (listBy.equals("transitLine"))
					{
						groupBy = resultSet.getString("r.transitLine");
					}
					else
					{
						groupBy = resultSet.getString("r.passenger_name");
					}
					
					double rev = resultSet.getDouble("rev");
					
					%>
					<tr>
						<td> <%=groupBy %> </td> <td> <%=rev %> </td> 
					</tr>
					<% 
				}
				
				//Close connection
				resultSet.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				out.print(e);
				out.print("Error fetching reservation data.");	
			}
		}
	%>
	</table>

</body>
</html>