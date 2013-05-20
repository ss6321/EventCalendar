<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%
//String no = request.getParameter("no");
String uid = session.getAttribute("user").toString();
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
//connect to the AWS that has mysql database
URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE"+"/event/attend.jsp");
HttpURLConnection httpCon = (HttpURLConnection) url.openConnection();
httpCon.setDoOutput(true);
httpCon.setRequestMethod("POST");
OutputStreamWriter outt = new OutputStreamWriter(
		httpCon.getOutputStream());
//write attanence to the database with member_id, event_id and member's status
outt.write("member_id="+uid+"&event_id="+request.getParameter("event_id")+"&status="+request.getParameter("status")
		); 
outt.close();

InputStream inStrm = httpCon.getInputStream();
int ch;
String rslt = "";
while (((ch = inStrm.read()) != -1)) {
	char temp = (char) ch;
	String str = Character.toString(temp);
	rslt = rslt + str;
}
rslt = rslt.trim();
inStrm.close();
httpCon.disconnect();
httpCon.disconnect();
out.println(rslt);


response.sendRedirect ("content.jsp?&year="+year+ "&month="+ month+"&day="+day+"&no="+request.getParameter("event_id"));
%>	
rslt