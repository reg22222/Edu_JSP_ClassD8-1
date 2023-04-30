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
	
	//*카트에담아주는 코드가 들어올부분(로그인중에만 가능하기때문에...)
	
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

int isbn= Integer.parseInt(request.getParameter("isbn"));
stmt = conn.prepareStatement("SELECT * FROM book_t WHERE isbn=?");
stmt.setInt(1, isbn);
rs = stmt.executeQuery();
//rs.next();
//out.println("test: "+rs.getString("title"));
//=============================================
out.println("<a href=home.jsp>Go Home</a>");
//=============================================
%>
<%
rs.next();
//가져온책의정보를 객체에 담아준다.
bookinfo newbook = new bookinfo();

newbook.setIsbn(Integer.parseInt(rs.getString("isbn")));
newbook.setTitle(rs.getString("title"));
newbook.setAuthor(rs.getString("author"));
newbook.setPublisher(rs.getString("publisher"));
newbook.setDate(rs.getString("date"));
newbook.setPrice(Integer.parseInt(rs.getString("price")));
newbook.setQuantity(Integer.parseInt(rs.getString("quantity")));
newbook.setCat_no(Integer.parseInt(rs.getString("cat_no")));

//객체를 ArrayList에 저장해준다.
ArrayList<bookinfo> cart = new ArrayList<bookinfo>();
cart.add(newbook);
//ArrayList 를 세션에 저장해준다.(세션의 변수이름은 "cart")
sess.setAttribute("cart", cart);

%>
</body>
</html>