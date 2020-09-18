<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Searching inbox...</title>
</head>
<body>

<%
	ApplicationDB db = new ApplicationDB();
	Connection conn = db.getConnection();
	Statement stmt = conn.createStatement();
	
	Object username = session.getAttribute("user");
	String user = (String) username;
	
	String search = request.getParameter("search");
%>

	<b> Your messages: </b>
	<br> =====================================================================================================<br>
	
	<%
		
		String getMessages = "SELECT inquiryNum, date, time, title, message, messageNum FROM Customer_Service WHERE custUser = ? AND(reply = -1) AND title LIKE '%" + search + "%' ORDER BY inquiryNum;";
		PreparedStatement ps = conn.prepareStatement(getMessages);
		ps.setString(1, user);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
	%>	
		Inquiry Number: <%=rs.getString("inquiryNum") %> <br>
		Title: <%=rs.getString("title") %> <br>
		Date: <%=rs.getString("date") %> <br>
		Time: <%=rs.getString("time") %> <br>
		----------------------------------------------------<br>
		Message: 
		<%=rs.getString("message") %> <br>
		
		<br>
		<form method="POST" action="seeReplies.jsp">
			<input type="hidden" name="messageNum" value="<%=rs.getInt("messageNum")%>"></input>
			<input type="submit" value="View"></input> 
		
		</form>
		<br>
		=====================================================================================================
		<br>
	<% 
		}
		ps.close();
		conn.close();
		stmt.close();
	
	%>
	Click <a href="customerHomepage.jsp"> here</a> to return to the home page.

</body>
</html>