<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>List</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<style>
     a { text-decoration : none; }
     a:visited { color: blue; }
    </style>
</head>
<body>
<%
//====================== Session =========================//
//세션에서 정보를 가져온다.
HttpSession sess = request.getSession();
//로그인중인지 판단한다.
String userID = (String) sess.getAttribute("LoginUserID");
if(userID!=null){
	//링크를 보여준다.
	out.println("<h4>"+userID+"</h4>");
	out.println("<a href=logout.jsp>로그아웃</a>");
}
else{
	//링크를 보여준다.
	out.println("<a href=login.html>로그인</a>");
}
%>

<%
//====================== DB =========================//
String url="jdbc:mysql://localhost:3306/book_d";
String user="root";
String password="";
Connection conn=DriverManager.getConnection(url,user,password);

ResultSet rs=null;
PreparedStatement stmt = null;
stmt = conn.prepareStatement("SELECT * FROM categories ORDER BY cat_no ASC");
rs = stmt.executeQuery();

out.println("<table class='table'><thead class='table-dark'>"+
"<tr><th scope='col'>카테고리번호</th><th scope='col'>카테고리이름</th>");
out.println("<tbody class='table-group-divider'>");

while (rs.next()) { 
out.println("<tr>"); 
out.println("<td>"+rs.getString("cat_no")+"</td>");

//하이퍼링크로 카테고리이름을 누르면, 다음페이지로 넘어가도록 해준다.
String cat_no=rs.getString("cat_no");
out.println("<td><a href=bookList.jsp?cat_no="+cat_no+">"
+rs.getString("cat_name")+"</a></td>");

out.println("</tr>");
} 
out.println("</tbody>");
out.println("</table>");
%>
</body>
</html>