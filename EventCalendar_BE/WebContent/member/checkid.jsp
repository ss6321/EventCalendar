<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file= "../blind/connect.jsp" %><!-- connect to database -->
<%
String id = request.getParameter("parameter");
if (id == ""){
%>
<%
} else {
	//check if the id is in the database
	String strSQL = "SELECT id FROM tblmember where id='" + id + "'";

	ResultSet rs = stmt.executeQuery(strSQL);


	if (!rs.next()) {
		System.out.println("null");
		out.println("null");
%>
<%
	} else {
		//out.println("not null");
out.println(rs.getString("id"));
%>
<%
	}

	rs.close();
	stmt.close();
	conn.close();
}
%>
