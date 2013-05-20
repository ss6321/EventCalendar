<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//check session information
if(session.getAttribute("user")==null)
	response.sendRedirect("../member/member.jsp");
%>
<HTML>
<HEAD>
<TITLE> Event Schedule </TITLE>

<script language="javascript">
<!--
function send(form)
{
	 if (calendar1.title.value.length < 1){
			alert("Please enter the title.");
			calendar1.title.focus();
			return false;
		}
	 if (calendar1.position.value.length < 1){
			alert("Please enter the Locatioin.");
			calendar1.position.focus();
			return false;
		}
	if (calendar1.content.value.length < 1){
			alert("Please enter the Event detail.");
			calendar1.content.focus();
			return false;
		}
form.submit();
}
-->
</script>

</HEAD>

<BODY>

<%
//get session information
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String no = request.getParameter("no");

//connect to the AWS that has mysql database
URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE"+"/event/content.jsp");
HttpURLConnection httpCon = (HttpURLConnection) url
		.openConnection();
httpCon.setDoOutput(true);
httpCon.setRequestMethod("POST");
OutputStreamWriter outt = new OutputStreamWriter(
		httpCon.getOutputStream());
//get the event contents with key
outt.write("no="+no); 
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
System.out.println(rslt);
inStrm.close();

httpCon.disconnect();

JSONParser parser = new JSONParser();
JSONObject jsonObject = (JSONObject) parser.parse(rslt);
JSONArray features = (JSONArray) jsonObject.get("result");
Iterator itr=features.iterator();
//get the event informtion from database
String strTitle="",s_time="",e_time="",mapLocation="",content="";
while(itr.hasNext()){
    JSONObject featureJsonObj = (JSONObject)itr.next();
     strTitle = (String) featureJsonObj.get("title");
     s_time = (String) featureJsonObj.get("s_time");
     e_time = (String) featureJsonObj.get("e_time");
     mapLocation = (String) featureJsonObj.get("position");
     content = (String) featureJsonObj.get("content");
}
%> 
<!-- provide all the information  -->
<center><font size='5'><b><%=year%>/ <%=month%>/ <%=day%> Event </b>
        </font></p>

<TABLE border='0' width='800' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE> 
<br>

<FORM Name="calendar1" Method="post" Action="edit_ok.jsp?&year=<%=year%>&month=<%=month%>&day=<%=day%>&no=<%=no%>">
<TABLE border='1' width='800' cellpadding='0' cellspacing='0'>
    	<TR>
       		<TD bgcolor='cccccc' width='100' height='30'><p align='center'>
		<input type='hidden' name='cp_type' value='input'>            
		<font size='2'><b>Title</b></font></TD>
        	<TD bgcolor='ededed'>
        	<input type="text" name="title" maxlength="200" 
                size="38" value='<%=strTitle%>'> </TD>
    	</TR>
   	<TR>
        	<TD bgcolor='cccccc' width='100' height='30'><p align='center'>
        	<font size='2'><b>Date</b></font></TD>
        	<TD bgcolor='ededed'>
        	<font size='2'><b><%=year%>/ <%=month%>/ <%=day%></b>
         	</font></TD>
   	</TR>
  	<TR>
        	<TD bgcolor='cccccc' width='100' height='30'><p align='center'>
        	<font size='2'><b>Time</b></font></TD>
        	<TD bgcolor='ededed'>
        	<input type='text' size='5' maxlength='5' 
                name='s_time' value='<%=s_time%>'> ▶  
        	<input type='text' size='5' maxlength='5' 
                name='e_time' value='<%=e_time%>'>
        	</TD>
 	</TR>
 	<TR>
       		<TD bgcolor='cccccc' width='100' height='30'><p align='center'>
        	<font size='2'><b>Location</b></font></TD>
        	<TD bgcolor='ededed'>
        	<input type="text" name="position" maxlength="200" 
                size="38" value='<%=mapLocation%>'> </td>
    	</TR>
 	<TR>
        	<TD height='118' bgcolor='cccccc'><p align='center'>
        	<font size='2'><b>Event</b></font></TD>
        	<TD height='118' bgcolor='ededed'><p>
        	<textarea name='content' rows='5' cols='70'><%=content%></textarea> </TD>
    	</TR>
</TABLE>
<br>

<TABLE border='0' cellpadding='0' cellspacing='0' width='800'>  
    	<TR>  
    		<TD height='40' colspan='2'><p align='center'>
           	<input type='button' value='Save' OnClick="send(this.form)"> <!-- if click save, go to edit_ok to check verification -->
           	<input type='reset' value='Cancel' OnClick="javascript:history.back()"></TD><!-- if click cancel, go back  -->
    	</TR>
</TABLE>
</FORM>


</BODY>
</HTML> 
