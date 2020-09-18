<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Deleting...</title>
</head>
<body>
	
	<%
		try{
			
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			
			String delTrainID, delDate, delDepartTime, delArrTime;
			delTrainID = request.getParameter("delTrainID");
			delDate = request.getParameter("delDate");
			delDepartTime = request.getParameter("delDepartTime");
			delArrTime = request.getParameter("delArrivalTime");
			
			String delete = "DELETE FROM Train_Schedule WHERE train_ID = ? AND date = ? AND departure_time = ? AND arrival_time = ?;";
			PreparedStatement ps = conn.prepareStatement(delete);
			ps.setString(1, delTrainID);
			ps.setString(2, delDate);
			ps.setString(3, delDepartTime);
			ps.setString(4, delArrTime);
			ps.executeUpdate();
			
			ps.close();
			conn.close();
		} catch (Exception e) {
			out.println("Deletion failed <br>" + e);
		}
	
	out.println("Success! The train schedule has now been deleted.");
	out.println("<br><br> Click <a href='selectSchedules.jsp'> here</a> to return to the previous page.");
	%>
	
	
</body>
</html>