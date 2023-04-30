<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<!DOCTYPE html>
<html>
<head>
	<style>
		img { width: 50%; height: 50% }
	</style>
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
//================================
// DB접속
//================================
String url="jdbc:mysql://localhost:3306/book_d";
String user="root";
String password="";
Connection conn=DriverManager.getConnection(url,user,password);
//================================
// SQL
//================================
ResultSet rs=null;
PreparedStatement stmt = null;

int isbn= Integer.parseInt(request.getParameter("isbn"));//책고유번호
stmt = conn.prepareStatement("SELECT * FROM book_t WHERE isbn=? ORDER BY title ASC");
stmt.setInt(1, isbn);
rs = stmt.executeQuery();

//=============================================
out.println("<a href=home.jsp>Go Home</a>");
//=============================================

//================================
// 출력(헤드)
//================================
out.println("<table class='table'><thead class='table-dark'>"+
"<tr><th scope='col'>Test</th><th scope='col'>bookCover</th><th scope='col'>isbn</th><th scope='col'>title</th>"+
"<th scope='col'>author</th><th scope='col'>publisher</th>"+
"<th scope='col'>date</th><th scope='col'>price</th><th scope='col'>quantity</th>");
out.println("<tbody class='table-group-divider'></tr>");
//================================
//출력(데이터)
//================================
while (rs.next()) { 
out.println("<tr>");
//장바구니에 저장
out.println("<td><form method='POST' action='saveCart.jsp'>"+
"<input type='text' name='isbn' value="+rs.getString("isbn")+">"+
"<input type='submit' value='Send'>"+
"</form></td>");
out.println("<td><img src=images/"+rs.getString("isbn")+".jpg></td>");
out.println("<td>"+rs.getString("isbn")+"</td>");
out.println("<td>"+rs.getString("title")+"</td>");
out.println("<td>"+rs.getString("author")+"</td>");
out.println("<td>"+rs.getString("publisher")+"</td>");
out.println("<td>"+rs.getString("date")+"</td>");
out.println("<td>"+rs.getString("price")+"</td>");
out.println("<td>"+rs.getString("quantity")+"</td>");
out.println("</tr>");
} 
out.println("</tbody>");
out.println("</table>");
%>
</body>
</html>