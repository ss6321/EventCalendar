<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file= "../blind/connect.jsp" %> <!-- connect to database -->

<%
//delete event content from database
String strSQL = "DELETE FROM calendar WHERE no = " + request.getParameter("no");
stmt.executeUpdate(strSQL);

stmt.close();
conn.close();

%>	
