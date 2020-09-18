<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Canceling Reservation</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		String removeRes = "";
		Object resNum = session.getAttribute("resNumber");
		int resNumber = (Integer) resNum;
		
		removeRes = "DELETE FROM Reservations WHERE res_number = '" + resNumber + "';";
		stmt.executeUpdate(removeRes);
		out.println("Your reservation has been cancelled.<br>");
		out.println("<br> Click <a href='customerHomepage.jsp'> here</a> to return to the homepage");
		
		conn.close();
		stmt.close();
		
	} catch (Exception e) {
		out.print(e + "<br> Error cancelling account.");
	}
%>

</body>
</html>