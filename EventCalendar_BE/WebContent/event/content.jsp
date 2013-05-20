<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file= "../blind/connect.jsp" %> <!-- connect to database -->
<%
//get session information
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String no = request.getParameter("no");
String member_id = request.getParameter("member_id");     

//get the event content from database
String strSQL = "SELECT * FROM calendar WHERE no=" + no;
ResultSet rs = stmt.executeQuery(strSQL);
System.out.println("STRSQL:"+strSQL);
JSONObject jObj = new JSONObject();
Map<String, String> map;
ArrayList<Map> list=new ArrayList<Map>();
String event_id="";
while (rs.next()) {//get the detail cotent information
	 map=new HashMap<String, String>();
	map.put("no",rs.getString("no"));
	map.put("year",rs.getString("year"));
	map.put("month",rs.getString("month"));
	map.put("day",rs.getString("day"));
	map.put("title",rs.getString("title"));
	map.put("s_time",rs.getString("s_time"));
	map.put("e_time",rs.getString("e_time"));
	map.put("position",rs.getString("position"));
	map.put("content",rs.getString("content"));
	event_id=rs.getString("no");
	list.add(map);
}
jObj.put("result",list);
out.println(jObj.toString());
rs.close();
//save click log to the database
String strSQL2 = "INSERT INTO click_log (event_id,member_id) VALUES('" +event_id+"','"+member_id+"')";
stmt.executeUpdate(strSQL2);

stmt.close();
conn.close();
%>
