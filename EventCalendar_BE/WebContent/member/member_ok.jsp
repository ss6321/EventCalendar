<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.Collection"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ include file="../blind/connect.jsp"%><!-- connect to database -->

<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String sessionID = "yes";
try{

if (id==null ||id == ""||id.equals("null") || pass == "") {
%>
<%
} else {
/*	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/dbboard";
	Connection conn = DriverManager.getConnection(url,"root","1234");
	Statement stmt = conn.createStatement();*/
//	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbboard", "root","");

//check if the id is already in use
	String strSQL = "SELECT * FROM tblmember where id='" + id + "'";
	ResultSet rs = stmt.executeQuery(strSQL);
	System.out.println(strSQL);
	if(!rs.next()){
		System.out.println("null");
		out.println("null");
	}else{
		String logid = rs.getString("id");
		String logpass = rs.getString("pass");
		
		//Gson gson = new Gson();
		//String[] obj = {logid, logpass};
		//String json = gson.toJson(obj);
		if (!id.equals(logid)){
			System.out.println("false");
			out.println("false");
		} else { 
			if (!pass.equals(logpass)){
				System.out.println("wrongpw");
				out.println("wrongpw");
			} else {
				System.out.println("true");
				JSONObject jObj = new JSONObject();
				
Map<String, String> map=new HashMap<String, String>();
ArrayList<Map> list=new ArrayList<Map>();
					map.put("id",rs.getString("id"));
					map.put("name",rs.getString("name"));
					map.put("phone",rs.getString("phone"));
					map.put("email",rs.getString("email"));
					map.put("level",rs.getString("level"));
					list.add(map);
				jObj.put("result",list);
				out.println(jObj.toString());
			}
		}	
	}
}

} catch(Exception e){
//out.println("exception");
e.printStackTrace();
}
%>