<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compose message</title>
</head>
<body>
	<!-- Customer Inquiry to Customer Representative -->
	Compose your message:
	
	<%String user = (String)session.getAttribute("user");%>
	<br>
	<form method="POST" action="sendMessage_action.jsp">
	<br>
		Title:
		<input type="text" name="title"> 
		<br>
		<br>
		Message:
		<br>
		<i><textarea rows = '5' cols = '51' name='message'></textarea></i>
		<br>
		
		<input type='hidden' name='cust' value=<%=user%>></input>
		<input type='hidden' name='rep' value=<%="null"%>></input>
		<input type='hidden' name='prev_reply' value=<%=-1%>></input>
		<input type='hidden' name='reply' value=<%=-1 %>></input>
		
		<input type='submit' value='Send'>
		
	</form>
	
	
	
	
	
	
	
	
	
</body>
</html>