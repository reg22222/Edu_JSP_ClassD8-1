<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
<%
HttpSession sess = request.getSession();
sess.invalidate( ); 
out.println("<center><h3><font color='BLUE'>로그아웃!</font></h3></center>");
//=============================================
out.println("<a href=home.jsp>Go Home</a>");
//=============================================
%>
</body>
</html>