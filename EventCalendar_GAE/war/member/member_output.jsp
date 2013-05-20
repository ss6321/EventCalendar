<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<HTML>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
//must check id whether it is used by other member
	String check_ok = "yes";

	if (id == "")
		check_ok = "no";

	if (pass == "")
		check_ok = "no";

	if (name == "")
		check_ok = "no";
	//connect to the AWS that has mysql database
	URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE" + "/member/checkid.jsp");
	HttpURLConnection httpCon = (HttpURLConnection) url.openConnection();
	httpCon.setDoOutput(true);
	httpCon.setRequestMethod("POST");
	OutputStreamWriter outt = new OutputStreamWriter(httpCon.getOutputStream());
	outt.write("id="+id); //json type
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
	
	if(rslt.equals("null"))
		check_ok = "yes";
	else
		check_ok = "no";

	if (check_ok == "yes") {
		//connect to the AWS that has mysql database
		url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE"+"/member/member_output.jsp");
		httpCon = (HttpURLConnection) url.openConnection();
		httpCon.setDoOutput(true);
		httpCon.setRequestMethod("POST");
		outt = new OutputStreamWriter(httpCon.getOutputStream());
		//save member inforamtion to the database to register
		outt.write("id="+id+"&pass="+pass+"&name="+name+"&phone="+phone+"&email="+email); 
		outt.close();
		inStrm = httpCon.getInputStream();
		rslt = "";
		while (((ch = inStrm.read()) != -1)) {
			char temp = (char) ch;
			String str = Character.toString(temp);
			rslt = rslt + str;
		}
		rslt = rslt.trim();
		inStrm.close();
		httpCon.disconnect();
		%>
		<BODY>

	<center>
		<font size='3'><b> Register success </b></font>
		<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr size='1' noshade></TD>
			</TR>
		</TABLE>


		<TABLE cellSpacing='0' cellPadding='10' align='center' border='0'>
			<TR>
				<TD align='center'><font size='2'>Thank you for
						register.<BR>Please login.
				</font></TD>
			</TR>
			<TR>
				<TD align='center'><font size='2'><a href="member.jsp">[LOGIN]</a></font><!-- go to log in page to log-in -->
				</TD>
			</TR>
		</TABLE>
</BODY>
</HTML>
<%
	} else {//when fail to register
%>
<HTML>
<HEAD>
<TITLE>Fail register</TITLE>
</HEAD>

<BODY>

	<center>
		<font size='3'><b> Fail register </b></font>
		<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr size='1' noshade></TD>
			</TR>
		</TABLE>

		<TABLE cellSpacing='0' cellPadding='10' align='center' border='0'>
			<TR>
				<TD align='center'><font size='2'>Sorry. Fail to
						register <BR>Please try again.
				</font></TD>
			</TR>
			<TR>
				<TD align='center'><font size='2'><a
						href="member_input.jsp">[Apply]</a></font></TD>
			</TR>
		</TABLE>
</BODY>
</HTML>
<%
}

%>
