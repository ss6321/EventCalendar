<%@page contentType="text/html;charset=UTF-8"%>
<%@include file= "../blind/connect.jsp"%>
<%
String strSQL = "SELECT * FROM attendance WHERE event_id='"+ request.getParameter("event_id")+"' AND member_id='"+ request.getParameter("member_id")+"'";
ResultSet rs =stmt.executeQuery(strSQL);

if(!rs.next()){
	String strSQL2 = "INSERT INTO attendance (event_id,member_id,status) VALUES('" + request.getParameter("event_id")+"','"+ request.getParameter("member_id")+"','"+request.getParameter("status")+"')";
	stmt.executeUpdate(strSQL2);
}else{


		String strSQL3 = "UPDATE attendance SET status='"+request.getParameter("status")+"' WHERE member_id='"+request.getParameter("member_id")+"' AND event_id='"+request.getParameter("event_id")+"'";
		stmt.executeUpdate(strSQL3);
	}



stmt.close();
conn.close();

%>	
