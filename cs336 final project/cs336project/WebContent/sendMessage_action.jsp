<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sending message...</title>
</head>
<body>

	<%
		
		try {
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			
			//Receives contents of message
			String title = request.getParameter("title");
			String message = request.getParameter("message");
			
			//Gets timestamp
			Calendar cal = Calendar.getInstance();
			String date = (cal.get(Calendar.YEAR)) + "-" + (cal.get(Calendar.MONTH)) + "-" + (cal.get(Calendar.DAY_OF_MONTH));
			String time = (cal.get(Calendar.HOUR_OF_DAY)) + ":" + (cal.get(Calendar.MINUTE)) + ":" + (cal.get(Calendar.SECOND));
			
			//Gets Customer Service SSN
			
			//Generates a inquiry number
			String inquiryQuery = "SELECT IF(MAX(inquiryNum) IS NULL, 1, MAX(inquiryNum) + 1) AS nextInquiryNum FROM Customer_Service;";
			ResultSet rs = stmt.executeQuery(inquiryQuery);
			int inquiryNum = 0;
			if(rs.next()) {
				inquiryNum = rs.getInt("nextInquiryNum");
			}
			session.setAttribute("inquiryNum", inquiryNum);
			
			//get messageType
			String query = "SELECT IF(MAX(messageNum) is NULL, 1, MAX(messageNum) + 1) AS nextMessageNum from Customer_Service;";
			ResultSet result = stmt.executeQuery(query);
			int messageNum = -1;
			if(result.next()) {
				messageNum = result.getInt("nextMessageNum");
			}
			
			String cust = request.getParameter("cust");
			String rep = request.getParameter("rep");
			String prevReply = (request.getParameter("prev_reply") + "");
			String reply = (request.getParameter("reply") + "");
			
			String insert = ("INSERT INTO Customer_Service (inquiryNum, date, time, messageNum, title, message, custUser, rep, prevReply, reply) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
			PreparedStatement ps = conn.prepareStatement(insert);
			ps.setString(1, inquiryNum + "");
			ps.setString(2, date);
			ps.setString(3, time);
			ps.setString(4, messageNum + "");
			ps.setString(5, title);
			ps.setString(6, message);
			ps.setString(7, cust);
			ps.setString(8, rep);
			ps.setString(9, prevReply + "");
			ps.setString(10, reply + "");
			ps.executeUpdate();
			
			//Checks to see who's sending message
			Object loggedIn = session.getAttribute("customer?");
			String log = (String) loggedIn;
			//customer
			if(log != null){
				out.println("Message has been sent. Click <a href='customerInbox.jsp'> here</a> to return to your inbox");
			//representative
			} else {
				out.println("Message has been sent. Click <a href='customerRepInbox.jsp'> here</a> to return to your inbox");
			}
			
			rs.close();
			result.close();
			ps.close();
			stmt.close();
			conn.close();
			
		} catch (Exception e) {
			out.println("Error sending message <br>" + e);
		}

	%>

</body>
</html>