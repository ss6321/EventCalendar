<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<HTML>
<HEAD>
<TITLE> MEMBER LOGIN </TITLE> 
</HEAD>

<META http-equiv="Content-Type" content="text/html; charset-UTF-8">
<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	         {font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->
</style>

<BODY>

<center><font size='3'><b> MEMBER LOGIN </b></font>   

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>


<TABLE cellSpacing='0' cellPadding='30' align='center' border='0' >
	
<%
//get session information
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String sessionID = "yes";

try{
if (id == "" || pass == "") {
%>
<TR>
	<TD align='center'>
	<font size=2>Please enter the ID and Password.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<a href="member.jsp">[Login]</a>
	</TD>
</TR>
<%
} else {
	//connect to the AWS that has mysql database
	URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE"+"/member/member_ok.jsp");
	HttpURLConnection httpCon = (HttpURLConnection) url
			.openConnection();
	httpCon.setDoOutput(true);
	httpCon.setRequestMethod("POST");
	OutputStreamWriter outt = new OutputStreamWriter(
			httpCon.getOutputStream());
	outt.write("id="+id+"&pass="+pass); 
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
	

	//out.println("["+rslt+"]"); //xml?

//	String logid = "id";//rs.getString("id");
//	String logpass ="pass";// rs.getString("pass");
//	if (!id.equals(logid)){
	if(rslt.equals("false")||rslt.equals("null")){//check if it is member or not
%>

<TR>
	<TD align="center">
	<font size='2'>You are not the member.</font>
	</TD>
</TR>
<TR>
	<TD align="center">
	<a href="member.jsp">[Login]</a>
	</TD>
</TR>
<%
	} else { //when password is not matched
		if (rslt.equals("wrongpw")){
%>

<TR>
	<TD align='center'>
	<font size=2>Password is not matched.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<a href="member.jsp">[Login]</a><!-- go back to log in page -->
	</TD>
</TR>

<%
		} else{ //if(!rslt.equals("true")){

JSONParser parser = new JSONParser();
JSONObject jsonObject = (JSONObject) parser.parse(rslt);
JSONArray features = (JSONArray) jsonObject.get("result");
Iterator itr=features.iterator();

String level = "";
while(itr.hasNext()){
    JSONObject featureJsonObj = (JSONObject)itr.next();
   // String no = (String)featureJsonObj.get("no");
   // String day = (String) featureJsonObj.get("day");
     level = (String) featureJsonObj.get("level");
}
//save user id and level to session
			session.setAttribute("user",id);
			session.setAttribute("level",level);
			response.sendRedirect("../event/main.jsp");
		}
	}	
}

} catch(Exception e){
%>
error.<% e.printStackTrace(); %>
<TR>
	<TD align="center">
	<font size='2'>You are not the member. </font>
	</TD>
</TR>
<TR>
	<TD align="center">
	<a href="member.jsp">[Login]</a><!-- if not member, go back to log-in page -->
	</TD>
</TR>

<%
}
%>

</TABLE>

</BODY>
</HTML>
