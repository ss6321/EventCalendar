<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//check session
if(session.getAttribute("user")==null)
	response.sendRedirect("../member/member.jsp");

//get session information
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String no = request.getParameter("no");
String id = session.getAttribute("user").toString();
//String level=session.getAttribute("level").toString();

//connect to the AWS that has mysql database
URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE"+"/event/content.jsp");
HttpURLConnection httpCon = (HttpURLConnection) url
		.openConnection();
httpCon.setDoOutput(true);
httpCon.setRequestMethod("POST");
OutputStreamWriter outt = new OutputStreamWriter(
		httpCon.getOutputStream());
//get event contents and send member_id to save log data
outt.write("no="+no+"&member_id="+id); 
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
//get event contents and display it to the main calendar
String strTitle="",s_time="",e_time="",mapLocation="",content="";
while(itr.hasNext()){
    JSONObject featureJsonObj = (JSONObject)itr.next();
   // String no = (String)featureJsonObj.get("no");
   // String day = (String) featureJsonObj.get("day");
     strTitle = (String) featureJsonObj.get("title");
     s_time = (String) featureJsonObj.get("s_time");
     e_time = (String) featureJsonObj.get("e_time");
     mapLocation = (String) featureJsonObj.get("position");
     content = (String) featureJsonObj.get("content");
}
%>
<HTML>
<HEAD>
<TITLE>Event Schedule</TITLE>
<!-- use google map to display event location -->
 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCHMXpxPOJ9aM2mfYkjooe0CSjn7swvgyw" type="text/javascript"></script>
<script language="javascript">
<!--
function send(form)
{
	form.submit();
}
function backtomain(form){
	location.href="main.jsp?&year="+form.year.value+"&month="+(form.month.value-1);
}
function send1(no)
{
	//warining message before delete the content
	ans = confirm(" Are you sure to delete this Event?");
	if(ans==true){
		location.href="del.jsp?&no="+no
	} else {
		return false;
	} 
}
function attend(form,status,no)
{
	//location.href="attend.jsp?&status="+status+"&event_id="+no+"&member_id="+id;
	form.action="attend.jsp?&status="+status+"&event_id="+no
			+"&year="+form.year.value+"&month="+form.month.value+"&day="+form.day.value;
	//alert(form.action);
	form.submit();
}
-->
</script>
<!--<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>--> 

<!-- google map -->
<script type="text/javascript">
var map = null;
var geocoder = null;
function initialize(mapLocation) {
	//alert(mapLocation);
	if (GBrowserIsCompatible()) {
		map = new GMap2(document.getElementById("map_canvas"));// display google map at map_canvas
 		map.setCenter(new GLatLng(37.4419, -122.1419), 1);
 		map.setUIToDefault();
  		geocoder = new GClientGeocoder();
  		showAddress(mapLocation);
  		}
  }
function showAddress(address){
	if (geocoder) {
		geocoder.getLatLng(address,
		function(point) {
			if (!point) {
				alert(address + " not found");
			} else {
				map.setCenter(point, 15);
				var marker = new GMarker(point, {draggable: true});
				map.addOverlay(marker);
				GEvent.addListener(marker, "dragend", function() {
				 marker.openInfoWindowHtml(marker.getLatLng().toUrlValue(6));
				});
				GEvent.addListener(marker, "click", function() {
				marker.openInfoWindowHtml(marker.getLatLng().toUrlValue(6));
				});
				GEvent.trigger(marker, "click");
			}
		}
		);
	}
}
</script>
</HEAD>

<BODY onload="initialize('<%=mapLocation%>')" onunload="GUnload()">
	<center>
		<font size='5'> <b><%=year%> / <%=month%> / <%=day%> Event
		</b></font>
		</p>

		<TABLE border='0' width='800' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr size='1' noshade></TD>
			</TR>
		</TABLE>
		<br>

			<FORM Name='calendar1' method='post'
				action='edit.jsp?&year=<%=year%>&month=<%=month%>&day=<%=day%>&no=<%=no%>'>
				<input type="hidden" value=<%=year%> name="year"/>
				<input type="hidden" value=<%=month%> name="month"/>
				<input type="hidden" value=<%=day%> name="day"/>
				<TABLE border='1' width='800' cellpadding='0' cellspacing='0'>
					<TR>
						<TD bgcolor='cccccc' width='100' height='30'><p
								align='center'>
								<input type='hidden' name='cp_type' value='input'> <font
									size='2'><b>Title</b></font></TD>
						<TD bgcolor='ededed'><font size='2'><b><%=strTitle%></TD>
					</TR>
					<TR>
						<TD bgcolor='cccccc' width='100' height='30'><p
								align='center'>
								<font size='2'><b>Date</b></font></TD>
						<TD bgcolor='ededed'><font size='2'> <b><%=year%>
									/ <%=month%> / <%=day%></b></font></TD>
					</TR>
					<TR>
						<TD bgcolor='cccccc' width='100' height='30'><p
								align='center'>
								<font size='2'><b>Time</b></font></TD>
						<TD bgcolor='ededed'><font size='2'><b><%=s_time%>
									▶ <%=e_time%></TD>
					</TR>
					<TR>
						<TD bgcolor='cccccc' width='100' height='30'><p
								align='center'>
								<font size='2'><b>Location</b></font></TD>
						<TD bgcolor='ededed'><font size='2'><b><%=mapLocation%></TD>
					</TR>
					<TR>
						<TD height='118' bgcolor='cccccc'><p align='center'>
								<font size='2'><b>Event</b></font></TD>
						<TD height='118' bgcolor='ededed'><p>
								<font size='2'><b><%=content%></TD>
					</TR>
				</TABLE>
				<br>
					<div id="map_canvas" style="width: 500px; height: 300px;"></div>

					<TABLE border='0' cellpadding='0' cellspacing='0' width='800'>
						<TR>
							<TD height='40' colspan='2'><p align='center'>
									<input type='button' value='Update' onclick='send(this.form)'> <!-- when update, go to edit.jsp page -->
										<input type='button' value='Delete' onclick="send1('<%=no%>')"><!-- if click delete, display message to ensure -->
											<input type='reset' value='Go back'
											onclick='backtomain(this.form)'></TD> <!-- if click go back, go back to main page -->
						</TR>
					</TABLE>
								<TABLE border='0' cellpadding='0' cellspacing='0' width='800'>
						<TR>
						<!-- check the attendance and save it to the database -->
							<TD height='40' colspan='2'><p align='center'>
									<input type='button' value='Join' onclick="attend(this.form,true,'<%=no%>')">
										<input type='button' value='Decline' onclick="attend(this.form,false,'<%=no%>')">
						</TR>
					</TABLE>
			</FORM> 
</BODY>
</HTML>
