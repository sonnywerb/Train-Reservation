<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Replies</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		Statement stmt = conn.createStatement();
		
	%>
		<b> Original Post: </b>
		<br><br>
	
	<%	
	
		//iterates through each message
		int messageNum = Integer.parseInt((String)request.getParameter("messageNum"));
		int nextMessageNum;
		
		PreparedStatement ps;
		String getInquiries = "SELECT * FROM Customer_Service WHERE messageNum = ?";
		ps = conn.prepareStatement(getInquiries);
		ps.setInt(1, messageNum);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
	%>	
		Inquiry Number: <%=rs.getString("inquiryNum")%> <br>
		Title: <%=rs.getString("title")%> <br>
		Date: <%=rs.getString("date")%> <br>
		Time: <%=rs.getString("time")%> <br>
		User: <%=rs.getString("custUser")%> 
		<br>----------------------------------------------------<br>
		Message: <br>
		<%=rs.getString("message")%> <br>
		
		<%nextMessageNum = rs.getInt("prevReply"); %>
		<br>=================================================================================================================
		<br><b>Replies: </b><br> <br>
	
	<%
		
		while(nextMessageNum != -1) {
			
			String getReplies = "SELECT * FROM Customer_Service WHERE messageNum = ?";
			ps = conn.prepareStatement(getReplies);
			ps.setInt(1, nextMessageNum);
			rs = ps.executeQuery();
			rs.next();
		}
		
	%>	
	
		Title: <%=rs.getString("title")%> <br>
		Date: <%=rs.getString("date")%> <br>
		Time: <%=rs.getString("time")%> <br>
		RUTransit Customer Representative 	
	<br>----------------------------------------------------<br>
		Message: <br>
		<%=rs.getString("message") %> <br>
		
		<% messageNum = nextMessageNum;
		nextMessageNum = rs.getInt("prevReply");%>
	
	<% 
	Object emp = session.getAttribute("user");
	String user = (String) emp;
	String query = "";
	query = "SELECT username FROM Employees WHERE username = '" + user + "';";
	ResultSet empcredentials = stmt.executeQuery(query);
	
	if(empcredentials.next()) {
	%>
		<form method="POST" action="sendReply.jsp">
		<input type="hidden" name="title" value=<%=rs.getString("title") %> >
		<input type="hidden" name="reply" value=<%=messageNum%> >
		<input type="submit" value="Reply">
	
		</form>
	<% } 
	%>
	<br>=================================================================================================================
	<% if(empcredentials.next()) { 
		out.println("<br> Click <a href='customerRepInbox.jsp'> here</a> to return to inbox.");
	} else {
		out.println("<br> Click <a href='customerInbox.jsp'> here</a> to return to inbox.");
	}
	%>
</body>
</html>