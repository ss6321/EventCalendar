<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%

//connect to the AWS that has mysql database
URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE"+"/event/del.jsp");
HttpURLConnection httpCon = (HttpURLConnection) url
		.openConnection();
httpCon.setDoOutput(true);
httpCon.setRequestMethod("POST");
OutputStreamWriter outt = new OutputStreamWriter(
		httpCon.getOutputStream());
//delete the event contents
outt.write("no="+ request.getParameter("no")); 
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
out.println(rslt);
System.out.println(rslt);
inStrm.close();

httpCon.disconnect();

//after delete go to main page
response.sendRedirect("main.jsp");
%>	
