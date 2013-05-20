<%@ page contentType = "text/html; charset=UTF-8" %>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<script>
function closeWin(msg){ //창 닫기
	 opener.document.Member_Input.checkok.value = msg;
	this.close();
}

</script>
<HTML>
<HEAD>
<TITLE> ID double check</TITLE> 
</HEAD>

<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	         {font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->
</style>



<BODY>

<FORM>

<TABLE border='1' width=250>
	
<%
String id = request.getParameter("id");

if (id == ""){
%>

<TR>
	<TD align='center' bgcolor='cccccc'>
	<font size='2'>Please enter the ID.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<a href=javascript:close()>[CLOSE]</a>
	</TD>
</TR>

<%
} else {
	
	//connect to the AWS that has mysql database
		URL url = new URL("http://ec2-54-225-151-248.compute-1.amazonaws.com:8080/EventCalendar_BE" + "/member/checkid.jsp");
		HttpURLConnection httpCon = (HttpURLConnection) url
				.openConnection();
		httpCon.setDoOutput(true);
		httpCon.setRequestMethod("POST");
		OutputStreamWriter outt = new OutputStreamWriter(
				httpCon.getOutputStream());
		//to check if the is is already in use or not
		outt.write("parameter="+id); 
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
		
		
	
if(rslt=="null"||rslt.equals("null")){ //you can use this id
%>
<TR>
	<TD align='center' bgcolor='cccccc'>
	<fint size='2'>ID : <%=id%> <BR> You can use this ID.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<a href=javascript:closeWin('true')>[CLOSE]</a>
	</TD>
</TR>
<%
	} else {// this id is already used by someone else
%>
<TR>
	<TD align='center' bgcolor='cccccc'>
	<font size='2'>ID : <%=id%> <BR> This ID is already used.</font>
	</TD>
</TR>
<TR>
	<TD align='center'>
	<a href=javascript:closeWin('false')>[CLOSE]</a>
	</TD>
</TR>
<%
	}

}
%>

</BODY>
</HTML>
