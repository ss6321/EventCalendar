<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%
//check the session information
if(session.getAttribute("user")==null)
	response.sendRedirect("../member/member.jsp");
%>
<HTML>
<HEAD>
<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	{font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->
</style>
<script>
function logout(){
	out.println("ssss");
}

</script>
<TITLE> Event Calendar </TITLE>
</HEAD>
<BODY>

<%

java.util.Calendar cal = java.util.Calendar.getInstance();

//get current date, and display it to the main page
String strYear = request.getParameter("year");
String strMonth = request.getParameter("month");


int year = cal.get(java.util.Calendar.YEAR);
int month = cal.get(java.util.Calendar.MONTH);
int date = cal.get(java.util.Calendar.DATE);


if(strYear != null)
{
  	year = Integer.parseInt(strYear);
	month = Integer.parseInt(strMonth);
}

cal.set(year, month, 1);

int startDay = cal.getMinimum(java.util.Calendar.DATE);

int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
int newLine = 0;
int j = 0;

%>
<div>
<%
//display user id and level to the main page
out.println("user: "+session.getAttribute("user"));
out.println(", ");
out.println("\nlevel: ");
out.println((session.getAttribute("level").equals("2"))?"Guest":"Admin"); 
%>
<form name="logout" action="../member/logout.jsp" method="post">
<input type="submit" value="logout"/>
</form>
</div>
<center><font size='5'><b> Event Calendar </b></font></TD>
<!-- display monthly view of calendar with current date -->
<TABLE border='0' width='800' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE> 
<br>

<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
	<TR> 
   	   	<TD> 

        	<a href="main.jsp?year=<%=year-1%>&month=<%=month%>">◀</a>
        	<STRONG><%=year%> year </STRONG> <a href="main.jsp?year=<%=year+1%>&month=<%=month%>">▶</a>  
      		</TD>
      		<TD>
        	<DIV align="center">
        	<a href="main.jsp?year=<%=year%>&month=<%=month - 1%>">◀</a>  
        	<STRONG><%=month + 1%> month </STRONG><a href="main.jsp?year=<%=year%>&month=<%=month + 1%>">▶</a> 
        	</DIV>
      		</TD>
      		<TD> 
        	<DIV align="right">
        	<a href=main.jsp></a><STRONG><%=year + "-" + (month + 1) + "-" + date%></STRONG>
        	</DIV>
      		</TD> 
    	</TR>
</TABLE>
<BR>

<TABLE width="100%" border="1" cellspacing="0" cellpadding="0">
    	<TR> 
      		<TD width='14%' height='34'align='center' bgcolor='cccccc'> 
        	<DIV align="center"><font color="red">date</font></DIV>
     		</TD>
      		<TD width='14%' height='34'align='center' bgcolor='cccccc'> 
        	<DIV align="center">Sun</DIV>
      		</TD>
      		<TD width='14%' height='34'align='center' bgcolor='cccccc'> 
        	<DIV align="center">Tue</DIV>
      		</TD>
      		<TD width='14%' height='34'align='center' bgcolor='cccccc'> 
        	<DIV align="center">Wed</DIV>
      		</TD>
      		<TD width='14%' height='34'align='center' bgcolor='cccccc'> 
        	<DIV align="center">Thu</DIV>
      		</TD>
      		<TD width='14%' height='34'align='center' bgcolor='cccccc'> 
        		<DIV align="center">Fri</DIV>
      		</TD>
      		<TD width='14%' height='34'align='center' bgcolor='cccccc'> 
        		<DIV align="center"><font color="blue">Sat</DIV>
      		</TD>
    	</TR>
<%
for(int index = 1; index < start ; index++ )
{
  	out.print("<TD>&nbsp;</TD>");
  	newLine++;
}

for(int index = 1; index <= endDay; index++)
{
  	String color = (newLine == 0)?"RED":"BLACK";
 
%>
      <TD width='14%' height='70' align='left' valign='top'>
	  	<font size='2'><b><a href='write.jsp?year=<%=year%>&month=<%=month+1%>&day=<%=index%>'>
	  	<font color = <%=color %>><%=index%></a>
	  
<%
//connect to the AWS that has mysql database
URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE" + "/event/main.jsp");
HttpURLConnection httpCon = (HttpURLConnection) url
		.openConnection();
httpCon.setDoOutput(true);
httpCon.setRequestMethod("POST");
OutputStreamWriter outt = new OutputStreamWriter(httpCon.getOutputStream());
//get the event contents form database
outt.write("year="+year+"&month="+month+"&index="+index); 
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

JSONParser parser = new JSONParser();
JSONObject jsonObject = (JSONObject) parser.parse(rslt);
JSONArray features = (JSONArray) jsonObject.get("result");
Iterator itr=features.iterator();

//get each event content from database
while(itr.hasNext()){
    JSONObject featureJsonObj = (JSONObject)itr.next();
    String no = (String)featureJsonObj.get("no");
    String day = (String) featureJsonObj.get("day");
    String strTitle = (String) featureJsonObj.get("title");
    String s_time = (String) featureJsonObj.get("s_time");
    String e_time = (String) featureJsonObj.get("e_time");
    String position = (String) featureJsonObj.get("position");
    String content = (String) featureJsonObj.get("content");
%>
<!-- display brief information about content -->
<a href=content.jsp?year=<%=year%>&month=<%=month+1%>&day=<%=index%>&no=<%=no%> 
   onMouseOver='toggle(document.all.<%="HideShow" + j%>);' 
   onMouseOut='toggle(document.all.<%="HideShow" + j%>);'>
   <font size="5">▶</font> 
<%	
	//String strTitle = rs.getString("title");
	//out.println(strTitle);
%>

</a><br>
                        
<DIV id='<%= "HideShow" + j%>'style="visibility:hidden;position:
                                absolute;left:369px; top:227px; width:157px; 
                                height:74px; z-index:1"> 
  					
<TABLE height='100' width='200' border='1' cellspacing='1' bgcolor='cccccc'>	
	<TR> 
		<TD colspan='2' bgcolor='cccccc' align='center' height='25'>
		<font size='2'><b>Detail Info</b></TD>
	</TR>
	<TR> 
		<TD width='20%'  height='25' bgcolor='cccccc' align='center'>
		<font size='2'><b>Title</b></TD>
		<TD bgcolor='cccccc'><font size='2'>
		<b><%=strTitle%></b></TD>

	</TR>
	<TR> 
		<TD width='20%'  height='25' bgcolor='cccccc' align='center'>
		<font size='2'><b>Time</b></TD>
		<TD bgcolor='cccccc'><font size='2'>
		<b><%=s_time%>~<%=e_time%></b></TD>	
	</TR>
	<TR> 
		<TD width='20%'  height='25' bgcolor='cccccc' align='center'>
		<font size='2'><b>Location</b></TD>
		<TD bgcolor='cccccc'><font size='2'>
		<b><%=position%></b></TD>
	</TR>
	<TR> 
		<TD width='20%'  height='25' bgcolor='cccccc' align='center'>
		<font size='2'><b>Event</b></TD>
		<TD bgcolor='cccccc'><font size='2'>
		<b><%=content%></b></TD>
	</TR>
</TABLE></DIV>
  			
<%
j = j+1;		
}
%>

	  
<%
newLine++;

if(newLine == 7){
	out.print("</TR>");
if(index <= endDay){
	out.print("<TR>");
}
newLine=0;
}
}

while(newLine > 0 && newLine < 7)
{
	out.print("<TD>&nbsp;</TD>");
	newLine++;
}
%>
</TABLE>
  
<SCRIPT LANGUAGE="JavaScript">
<!--
function toggle(e) {
   if(e.style.visibility=="hidden") {
      e.style.top = event.y;
      e.style.left = event.x;
      e.style.visibility="visible";
     }
     else
     {
       e.style.visibility="hidden";
     }
}
-->
</SCRIPT>

</BODY>
</HTML>
