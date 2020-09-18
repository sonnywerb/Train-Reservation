<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Inbox</title>
</head>
<body>	
	<h1>Welcome to your inbox!</h1>
	
		
	</form>
	<br>
	<b> Customer Inquiries: </b>
	<br> =====================================================================================================<br>
	<% 
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		String getInquiries = "SELECT * FROM Customer_Service WHERE rep = 'null' AND (prevReply = -1) AND NOT(messageNum = -1) ORDER BY inquiryNum desc;";
		PreparedStatement ps = conn.prepareStatement(getInquiries);
		ResultSet inquiries = ps.executeQuery();
	
		while(inquiries.next()) {
	%>	
		Inquiry Number: <%=inquiries.getString("inquiryNum") %> <br>
		Title: <%=inquiries.getString("title") %> <br>
		Date:  <%=inquiries.getString("date") %> <br>
		Time:  <%=inquiries.getString("time") %> <br>
		User:   <%=inquiries.getString("custUser") %> <br>
		----------------------------------------------------<br>
		Message: <br>
		<%=inquiries.getString("message") %> <br>
		 
			<br>
		<form method="POST" action="seeReplies.jsp">
			<input type="hidden" name="messageNum" value="<%=inquiries.getInt("messageNum")%>"></input>
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
</body>
</html>