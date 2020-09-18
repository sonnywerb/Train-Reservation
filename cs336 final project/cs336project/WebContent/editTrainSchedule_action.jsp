<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Updating...</title>
</head>
<body>
	<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			
			Object transitlineStops = session.getAttribute("transitlineStops");
			String tls = (String) transitlineStops;
			
			String ogTrainID, ogDate, ogDepartTime, ogArrTime;
			ogTrainID = request.getParameter("ogTrainID");
			ogDate = request.getParameter("ogDate");
			ogDepartTime = request.getParameter("ogDepartTime");
			ogArrTime = request.getParameter("ogArrivalTime");
			
			String newTrainID, newDate, newDepartTime, newArrTime;
			newTrainID = request.getParameter("newTrainID");
			newDate = request.getParameter("newDate");
			newDepartTime=request.getParameter("newDepartTime");
			newArrTime = request.getParameter("newArrivalTime");
			
			String update = "UPDATE Train_Schedule SET train_ID = ?, date = ?, departure_time = ?, arrival_time = ? ";
			update += "WHERE train_ID = ? AND date = ? AND departure_time = ? AND arrival_time = ?;";
			
			//Prepared Statement - inserts String in ?
			PreparedStatement ps = conn.prepareStatement(update);
			ps.setString(1, newTrainID);
			ps.setString(2, newDate);
			ps.setString(3, newDepartTime);
			ps.setString(4, newArrTime);
			ps.setString(5, ogTrainID);
			ps.setString(6, ogDate);
			ps.setString(7, ogDepartTime);
			ps.setString(8, ogArrTime);
			ps.executeUpdate();
			
			String updateStops = "";
			if(tls.equals("A") || tls.equals("B") || tls.equals("EE") || tls.equals("F") || tls.equals("H")) {
				updateStops = "UPDATE Stops s JOIN Train_Schedule t ON (s.transit_line = t.transit_line) SET s.arrival_time1 = t. arrival_time FROM Stops s  ";
				updateStops = "WHERE transit_line = '" + tls + "';";
			} else if(tls.equals("LX") || tls.equals("REXB")) {
				String calcTTime = "";
				calcTTime = "SELECT TIMESTAMPDIFF(MINUTE, departure_time, arrival_time) as 'TTime' FROM Train_Schedule WHERE transit_line = '" + tls + "';";
				ResultSet travTime = stmt.executeQuery(calcTTime);
				String tTime = "";
				int timeDiff = 0;
				while(travTime.next()) {
					tTime = travTime.getString("TTime");
					timeDiff = Integer.parseInt(tTime);
					Math.round(timeDiff);
				}
				timeDiff = Math.round(timeDiff/2);
				
				updateStops = "UPDATE Stops s JOIN Train_Schedule t ON (s.transit_line=t.transit_line) SET s.arrival_time2 = t.arrival_time, s.arrival_time1 = TIMESTAMPADD(MINUTE, " + timeDiff + ", t.departure_time), s.departure_time1 = s.arrival_time1 ";
				updateStops += "WHERE s.transit_line ='" + tls + "';";
				stmt.executeUpdate(updateStops);
			} else {
				String calcTTime2 = "";
				calcTTime2 = "SELECT TIMESTAMPDIFF(MINUTE, departure_time, arrival_time) as 'TTime2' FROM Train_Schedule WHERE transit_line = '" + tls + "';";
				ResultSet travTime2 = stmt.executeQuery(calcTTime2);
				String tTime2 = "";
				int timeDiff2 = 0;
				while(travTime2.next()) {
					tTime2 = travTime2.getString("TTime2");
					timeDiff2 = Integer.parseInt(tTime2);
					Math.round(timeDiff2);
				}
				timeDiff2 = Math.round(timeDiff2/3);
				
				updateStops = "UPDATE Stops s JOIN Train_Schedule t ON (s.transit_line=t.transit_line) SET s.arrival_time3 = t.arrival_time, s.arrival_time1 = TIMESTAMPADD(MINUTE, " + timeDiff2 + ", t.departure_time), s.departure_time1 = s.arrival_time1, ";
				updateStops += "s.arrival_time2 = TIMESTAMPADD(MINUTE, " + timeDiff2 + ", s.arrival_time1), s.departure_time2 = s.arrival_time2 WHERE s.transit_line ='" + tls + "';";
				stmt.executeUpdate(updateStops);
			}
				
		
			stmt.close();
			ps.close();
			conn.close();
		} catch (Exception e) {
			out.print("Update failed<br>");
			out.print(e);
		}
	
	out.println("Success! The train schedule has now been updated.");
	out.println("<br><br> Click <a href='selectSchedules.jsp'> here</a> to return to the previous page.");
	
	
	
	%>

</body>
</html>