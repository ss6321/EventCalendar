<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file= "../blind/connect.jsp" %> <!-- connect to database -->

<%
String s_time = request.getParameter("s_time");
String e_time = request.getParameter("e_time");
String title = request.getParameter("title");
String position = request.getParameter("position");
String content = request.getParameter("content");
String no = request.getParameter("no");
String year = request.getParameter("year");
String month = request.getParameter("month");

//update event content in the database
String strSQL = "UPDATE calendar SET title='" + title + "', position='" + position + "',";
strSQL = strSQL + " content='" + content + "',s_time='" + s_time + "',e_time='" + e_time + "' WHERE no=" + no;

stmt.executeUpdate(strSQL);

stmt.close();
conn.close();

//int imonth = Integer.parseInt(month);

//response.sendRedirect ("main.jsp?&year=" + year + "&month=" + (imonth - 1));
%>	
