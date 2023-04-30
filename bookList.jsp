<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<!DOCTYPE html>
<html>
<head>
	<style>
		img { width: 10%; height: 10% }
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

//전달받은 카테고리번호로 해당카테고리의 모든책을 가져온다.
int cat_no= Integer.parseInt(request.getParameter("cat_no"));//카테고리번호
stmt = conn.prepareStatement("SELECT * FROM book_t WHERE cat_no=? ORDER BY title ASC");
stmt.setInt(1, cat_no);//카테고리번호를 SQL과 조립함
rs = stmt.executeQuery();
//=============================================
out.println("<a href=home.jsp>Go Home</a>");
//=============================================

//================================
// 출력(헤드)
//================================
out.println("<table class='table'><thead class='table-dark'>"+
"<tr><th scope='col'>표지사진</th><th scope='col'>책제목</th><th scope='col'>가격</th>"+
"<th scope='col'>저자</th><th scope='col'>출판사</th>");
out.println("<tbody class='table-group-divider'>");
//================================
//출력(데이터)
//================================
while (rs.next()) { 
out.println("<tr>"); 
out.println("<td><img src=images/"+rs.getString("isbn")+".jpg width=100 height=100></td>");

String isbn=rs.getString("isbn");
out.println("<td><a href=bookDetail.jsp?isbn="+isbn+">"+rs.getString("title")+"</a></td>");//책제목

out.println("<td>"+rs.getString("price")+"</td>");//가격
out.println("<td>"+rs.getString("author")+"</td>");//저자
out.println("<td>"+rs.getString("publisher")+"</td>");//출판사
out.println("</tr>");
} 
out.println("</tbody>");
out.println("</table>");
%>
</body>
</html>