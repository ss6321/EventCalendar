<HTML>
<HEAD>
<TITLE>Register</TITLE>

<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type='text/css'>
<!--
a:link {
	font-family: "";
	color: black;
	text-decoration: none;
}

a:visited {
	font-family: "";
	color: black;
	text-decoration: none;
}

a:hover {
	font-family: "";
	color: black;
	text-decoration: underline;
}
-->
</style>
<!-- check if all the information is provide to sign-up -->
<SCRIPT LANGUAGE="JavaScript">
	function Check() {
		if (Member_Input.id.value.length < 1) {
			alert("Please enter ID.");
			Member_Input.id.focus();
			return false;
		}

		if (Member_Input.pass.value.length < 1) {
			alert("Please enter Passwrod.");
			Member_Input.pass.focus();
			return false;
		}

		if (Member_Input.name.value.length < 1) {
			alert("Please enter name.");
			Member_Input.name.focus();
			return false;
		}
		if (Member_Input.phone.value.length < 1) {
			alert("Please enter phonenumber.");
			Member_Input.phone.focus();
			return false;
		}
		if (Member_Input.email.value.length < 1) {
			alert("Please enter email.");
			Member_Input.email.focus();
			return false;
		}
		
				
		if (Member_Input.checkok.value =='false' ) {
			alert("Invalid ID");
			Member_Input.id.focus();
			return false;
		}
		if (Member_Input.checkok.value =='' ) {
			alert("Please check ID");
			Member_Input.id.focus();
			return false;
		}
				
		
		Member_Input.submit();
	}
	function Check_id() {//check if this id is in the database or not
		browsing_window = window
				.open(
						"checkid.jsp?id=" + Member_Input.id.value,
						"_idcheck",
						"height=200,width=300, menubar=no,directories=no,resizable=no,status=no,scrollbars=yes");
		browsing_window.focus();
	}
</SCRIPT>
</HEAD>

<BODY>

	<center>
		<font size='3'><b> Register </b></font>
		<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr size='1' noshade></TD>
			</TR>
		</TABLE>

		<FORM Name='Member_Input' Method='post' Action='member_output.jsp'>
			<input type="hidden" value="" name="checkok"/>
			<TABLE border='2' cellSpacing=0 cellPadding=5 align=center>
				<TR>
					<TD bgcolor='cccccc' align='center'><font size='2'>id</font></TD>
					<TD bgcolor='cccccc'><input type='text' maxLength='10'
						size='10' name='id' onkeydown="javascript:checkok.value=''" > <input type='button'
						OnClick='Check_id()' value='ID Double check'></TD>
				</TR>
				<TR>
					<TD bgcolor='cccccc' align='center'><font size='2'>password</font>
					</TD>
					<TD bgcolor='cccccc'><input type='password' maxLength='10'
						size='10' name='pass'></TD>
				</TR>
				<TR>
					<TD bgcolor='cccccc' align='center'><font size='2'>name</font>
					</TD>
					<TD bgcolor='cccccc'><input type='text' maxLength='10'
						size='10' name='name'></TD>
				</TR>


				<TR>
					<TD bgcolor='cccccc' align='center'><font size='2'>Phone
							number</font></TD>
					<TD bgcolor='cccccc'><input type='text' maxlength='20'
						size='20' name='phone'></TD>
				</TR>
				<TR>
					<TD bgcolor='cccccc' align='center'><font size='2'>E -
							M a i l</font></TD>
					<TD bgcolor='cccccc'><input type='text' maxlength='50'
						size='50' name='email'></TD>
				</TR>
			</TABLE>

			<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
				<TR>
					<TD><hr size='1' noshade></TD>
				</TR>
			</TABLE>

			<TABLE>
				<TR>
					<TD colspan='2' align='center'><input type='button'
						OnClick='Check()' value='Register'></TD>
				</TR>
			</TABLE>

		</FORM>
</BODY>
</HTML>