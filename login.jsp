<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Read</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<style>
     a { text-decoration : none; }
     a:visited { color: blue; }
    </style>
</head>
<body>
<%
String url="jdbc:mysql://localhost:3306/book_d";
String user="root";
String password="";
Connection conn=DriverManager.getConnection(url,user,password);

String u_id = request.getParameter("u_id");
String u_pw = request.getParameter("u_pw");

ResultSet rs=null;
PreparedStatement stmt = null;
stmt = conn.prepareStatement("SELECT * FROM login_t WHERE u_id=? AND u_pw=?");
stmt.setString(1, u_id);
stmt.setString(2, u_pw);
rs = stmt.executeQuery();

if(rs.next()){//로그인되었음.
	//=============== 로그인된경우 아이디를 저장한다.(session) ====================//
	HttpSession sess = request.getSession();
 	sess.setAttribute("LoginUserID", rs.getString("u_id") );
	out.println("<center><h3><font color='BLUE'>로그인되었습니다!</font></h3></center>");
	//=============================================
	out.println("<a href=home.jsp>Go Home</a>");
	//=============================================
			
	//=============== 유저가 존재할경우 ====================//
	out.println("<table class='table'><thead class='table-dark'>"+
	"<tr><th scope='col'>이름</th><th scope='col'>아이디</th><th scope='col'>비밀번호</th>"+
	"<th scope='col'>주소</th></thead>");
	out.println("<tbody class='table-group-divider'>");
	out.println("<tr>"); 
	out.println("<td>"+rs.getString("u_name")+"</td>");
	out.println("<td>"+rs.getString("u_id")+"</td>");
	out.println("<td>"+rs.getString("u_pw")+"</td>");
	out.println("<td>"+rs.getString("u_addr")+"</td>");
	out.println("</tr>"); 
	out.println("</tbody>");
	out.println("</table>");
	//=======================================================//	
}
else{//존재하지않는유저.
	out.println("<center><h3><font color='RED'>Unknown User!</font></h3></center>");
}
%>
</body>
</html>