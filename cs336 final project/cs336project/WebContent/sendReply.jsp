<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reply to message</title>
</head>
<body>
	Reply to customer: <br>
	
	<%
		String user = (String)session.getAttribute("user");
		String reply = request.getParameter("reply");
	%>
	
	<br>
	<form method="POST" action="sendReply_action.jsp">
		 <input type = "hidden" name ="title" value = <%=request.getParameter("title")%> >
     	 <input type = "hidden" name ="reply" value = <%=reply%> >
    	 <input type = "hidden" name ="prevReply" value = <%=-1%> >
    	 
    <%
    	String checkCust = (String)session.getAttribute("customer?");
		Object custRep = session.getAttribute("user");
		String custRepUser = (String) custRep;
		if(checkCust == null) {
			
	%>
			<input type="hidden" name="cust" value=<%= "null" %> >
			<input type="hidden" name="rep" value="RUTransit Customer Representative" >
	<%	} else {
	%>
		<input type="hidden" name="cust" value=<%= "user" %> >
		<input type="hidden" name="rep" value=<%="null"%> >
	<%
		}
	%>
	Reply: <br>
	<textarea rows="5" cols = "55" name="reply"></textarea>
	<input type="submit" value="Submit">
	
	
	</form>
	
</body>
</html>