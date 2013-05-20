<HTML>
<HEAD>
<TITLE> MEMBER LOGIN :</TITLE> 

<META http-equiv="Content-Type" content="text/html; charset-UTF-8">
<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	         {font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->
</style>

<SCRIPT language="JavaScript">
//check if it provide id and password
function Check()
{
if (Member.id.value.length < 1){
	alert("Please enter the ID.");
	Member.id.focus();
	return false;
}

if (Member.pass.value.length < 1){
	alert("Please enter the Passwrod.");
	Member.pass.focus();
	return false;
}
Member.submit();
} 
</SCRIPT>

</HEAD>

<BODY>

<center><font size='3'><b> MEMBER LOGIN </b></font>   

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>


<FORM Name='Member' Method='post' Action='member_ok.jsp'>

<TABLE align=center width='300' border='0' cellpadding='10' cellspacing='0'>
<TR>
	<TD bgcolor='cccccc' align='right'>
		<font size='2'>ID :</font>
	</TD>
	<TD bgcolor='cccccc' align='center'>
		<input type='text' maxlength='10' size='10' name='id'>
	</TD>
	<TD bgcolor='cccccc' align='left'>
		<input onclick='Check()' type='button' value='Login'>
	</TD>
</TR>
<TR>
	<TD bgcolor='cccccc' align='right'>
		<font size='2'>Password :
	</TD>
	<TD bgcolor='cccccc' align='center'>
		<input type='password' maxlength='10' size='10' name='pass'>
	</TD>
	<TD bgcolor='cccccc'>
		<font size='2'>
		<a href="member_input.jsp">[Sign Up]</a></font><!-- go the sign up page -->
	</TD>
</TR>

</TABLE>

</FORM>

</BODY>
</HTML>
