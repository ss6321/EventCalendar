<HTML>
<HEAD>
<TITLE> MEMBER LOGOUT </TITLE> 

<META http-equiv="Content-Type" content="text/html; charset-UTF-8">


</HEAD>

<BODY>

<center><font size='3'><b> MEMBER LOGOUT </b></font>   

<% 
//when log out distroy session 
session.invalidate();
response.sendRedirect("../member/member.jsp");
%>

</FORM>

</BODY>
</HTML>
