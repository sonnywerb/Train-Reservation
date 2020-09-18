<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Best Data</title>
</head>
<body>
<b>View Best Data</b>
	<br>
	Go <a href="adminHomepage.jsp"> back</a>.
	<br>

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
				
				out.print("<br> <b> Best Customer: </b>");
				
				String query = "SELECT rev_per_cust.cust AS bestCust, rev_per_cust.rev AS bestRev FROM " +
								"(SELECT r.passenger_name AS cust, SUM(r.fare) AS rev " +
								"FROM Reservations r " +
								"GROUP BY r.passenger_name) AS rev_per_cust " +
								"HAVING rev_per_cust.rev = MAX(rev_per_cust.rev);";
					
				ResultSet resultSet = stmt.executeQuery(query);
				while(resultSet.next())
				{
					String bestCust = resultSet.getString("bestCust");
					double bestRev = resultSet.getDouble("bestRev");
					out.print("<br>" + bestCust + " produced $" + bestRev + " in total revenue.");
				}
				
				out.print("<br><br>======================================================================================<br>");
				
				out.print("<br> <b> Top Active Transit Lines: </b>");
				
				query = "SELECT res_per_tl.tl AS transitLine, res_per_tl.resCount AS resCount FROM " +
						"(SELECT r.transitLine AS tl, COUNT(*) AS resCount " +
						"FROM Reservations r " +
						"GROUP BY r.transitLine " +
						"ORDER BY resCount desc) AS res_per_tl " +
						"LIMIT 5;";
						
				resultSet = stmt.executeQuery(query);
				int count = 1;
				while(resultSet.next())
				{
					String transitLine = resultSet.getString("transitLine");
					int resCount = resultSet.getInt("resCount");
					out.print("<br>" + count + ". " + transitLine + " has " + resCount + " total reservations.");
					count++;
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

</body>
</html>