<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file= "../blind/connect.jsp" %>

<%
String strSQL = "DELETE FROM calendar WHERE no = " + request.getParameter("no");
stmt.executeUpdate(strSQL);

stmt.close();
conn.close();

%>	
