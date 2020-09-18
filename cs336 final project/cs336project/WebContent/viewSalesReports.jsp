<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sales Reports</title>
</head>
<body>
<b>Sales Reports by Month</b>
	<br>
	Go <a href="adminHomepage.jsp"> back</a>.
	<br>
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
				
				//Query 1
				String query = "SELECT EXTRACT(year FROM r.date) AS yr, MONTHNAME(r.date) AS mon, SUM(r.fare) AS sales " +
						"FROM Reservations r " +
						"GROUP BY EXTRACT(year FROM r.date), EXTRACT(month FROM r.date) " +
						"ORDER BY yr, EXTRACT(month from r.date);";
				
				//Execute statement to fetch sales reports by month
				ResultSet resultSet = stmt.executeQuery(query);
				
				//If there is no such entry, redirect to error page.
				if (!resultSet.next())
				{
					out.print("Unable to fetch sales data.");
					out.print("Please <a href='adminHomepage.jsp'> go back</a>.");
				}
				
				else
				{
					resultSet.beforeFirst();
					while (resultSet.next())
					{
						String yr = resultSet.getString("yr");
						String mon = resultSet.getString("mon");
						String sales = resultSet.getString("sales");
						
						%>
							<tr>
								<td> <%=mon %> </td> <td> <%=yr %> </td> <td> $<%=sales %> </td> 
							</tr>
						<% 
					}	
			
				}
				
				//Close connection
				resultSet.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				out.print(e);
				out.print("Error fetching sales data.");	
			}
		}
	%>
	</table>

</body>
</html>