<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Inbox</title>
</head>
<body>
	<h1>Welcome to your inbox!</h1>

	<b>Compose message: </b><br>
	Click <a href='sendMessage.jsp'> here</a> to send a question or inquiry to our customer representatives. <br>
	<br>
	 <b>Search your inbox: </b><br> 
	<form method="POST" action="searchInbox.jsp">
		<input type="text" name="search">
		<input type ="submit" value="Search">
		
	</form>
	
	<br>
	<b> Your messages: </b>
	<br> =====================================================================================================<br>
	
	<%
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
		Object username = session.getAttribute("user");
		String user = (String) username;
		
		String getMessages = "SELECT inquiryNum, date, time, title, message, messageNum FROM Customer_Service WHERE custUser = ? AND(reply = -1) ORDER BY inquiryNum;";
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