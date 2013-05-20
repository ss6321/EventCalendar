<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file= "../blind/connect.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<HTML>

<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");

	String check_ok = "yes";

	if (id == "")
		check_ok = "no";

	if (pass == "")
		check_ok = "no";

	if (name == "")
		check_ok = "no";

	String strSQL = "INSERT INTO tblmember(id,pass,name,phone,email,level)";
		strSQL = strSQL + "VALUES('" + id + "', '" + pass + "', '"
				+ name + "',";
		strSQL = strSQL + "'" + phone + "', '" + email + "', '002')";
		try {
			System.out.println("query : " + strSQL);
			stmt.executeUpdate(strSQL);
		} catch (SQLException e) {
			e.printStackTrace();
		}
%>

