<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file= "../blind/connect.jsp" %> <!-- connect to database -->
 
<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String s_time = request.getParameter("s_time");
String e_time =request.getParameter("e_time");
String title = request.getParameter("title");
String position = request.getParameter("position");
String content = request.getParameter("content");

System.out.println(year);
System.out.println(month);
System.out.println(day);
System.out.println(s_time+"_"+e_time);
System.out.println(title);
System.out.println(position);
System.out.println(content);

String msg = "New event is posted in Event Calendar.";
msg = msg + "\nTitle:" +title;
msg = msg + "\nLocation:" +title;
msg = msg + "\nDate:" +year +"/"+month+"/"+day;
msg = msg + "\nHour:" + s_time +"-" +e_time;
msg = msg + "\nEvent:" +content;

System.out.println(msg);
String msgtitle = "[Event Calendar] New event is posted.";

//save new event in the database
String strSQL = "INSERT INTO calendar (year,month,day,title,s_time,e_time,position,content) VALUES('";
strSQL = strSQL + year + "','";
strSQL = strSQL + month + "','";
strSQL = strSQL + day + "','";
strSQL = strSQL + title + "','";
strSQL = strSQL + s_time + "','";
strSQL = strSQL + e_time + "','";
strSQL = strSQL + position + "','";
strSQL = strSQL + content + "')";

stmt.executeUpdate(strSQL);
//get member information from datagase
String strSQL2 = "select * from tblmember";
ResultSet rs = stmt.executeQuery(strSQL2);



final String username = " cloud.event.calendar@gmail.com";
final String password = "cecece0000";

Properties props = new Properties();
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "true");
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "587");

Session sess = Session.getInstance(props,
  new javax.mail.Authenticator() {
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(username, password);
	}
});

try {
    //send e-mail notification to all member when new event content is reigstered
      int i = 0;
      while (rs.next()) {   
        Message message = new MimeMessage(sess);
        message.setFrom(new InternetAddress(username));
        message.addRecipient(Message.RecipientType.TO,
                new InternetAddress(rs.getString("email"), rs.getString("name")));
        message.setSubject(msgtitle);
        message.setText(msg);
        Transport.send(message);
        
	System.out.println( " e-mails have been sent."+(i++));
    }
    

} catch (MessagingException e) {
	e.printStackTrace();
}

stmt.close();
conn.close();

%>
