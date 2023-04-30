<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="bookshop.*" %>
<%@ page import="java.util.*" %>     
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
	
	//로그인중에만 처리할수있는것들이 들어올부분
}
else{
	//링크를 보여준다.
	out.println("<a href=login.html>로그인</a>");
}
%>
<%
//=============================================
out.println("<a href=home.jsp>Go Home</a>");
//=============================================

//================================
// 출력(헤드)
//================================
out.println("<table class='table'><thead class='table-dark'>"+
"<tr><th scope='col'>표지사진</th><th scope='col'>책제목</th>");
out.println("<tbody class='table-group-divider'>");
//================================
//출력(데이터)
//================================
ArrayList<bookinfo> cart=(ArrayList<bookinfo>) sess.getAttribute("cart");
for(bookinfo info : cart){
	out.println(info.getTitle());
	out.println(info.getPrice());	
}
%>
</body>
</html>