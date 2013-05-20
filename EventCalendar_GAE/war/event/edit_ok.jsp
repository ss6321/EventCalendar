<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//get session information
String s_time = request.getParameter("s_time");
String e_time = request.getParameter("e_time");
String title = request.getParameter("title");
String position = request.getParameter("position");
String content = request.getParameter("content");
String no = request.getParameter("no");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

//connect to the AWS that has mysql database
URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE" + "/event/edit_ok.jsp");
HttpURLConnection httpCon = (HttpURLConnection) url
		.openConnection();
httpCon.setDoOutput(true);
httpCon.setRequestMethod("POST");
OutputStreamWriter outt = new OutputStreamWriter(
		httpCon.getOutputStream());
//write contents to the database
outt.write("no="+no+"&title="+title+"&s_time="+s_time+"&e_time="+e_time
		+"&position="+position+"&content="+content
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
out.println(rslt);
System.out.println(rslt);
inStrm.close();

httpCon.disconnect();

int imonth = Integer.parseInt(month);

response.sendRedirect ("content.jsp?&year="+year+ "&month="+ month+"&day="+day+"&no="+no);
%>	
