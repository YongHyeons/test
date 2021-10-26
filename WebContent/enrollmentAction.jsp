<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="books.Books" %>
<%@ page import="books.BooksDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="books" class="books.Books" scope="page" />
<jsp:setProperty name="books" property="booksName" />
<jsp:setProperty name="books" property="author" />
<jsp:setProperty name="books" property="publisher" />
<jsp:setProperty name="books" property="price" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 도서 등록</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else {
			if(books.getBooksName() == null || books.getAuthor() == null || books.getPublisher() == null || books.getPrice() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					BooksDAO booksDAO = new BooksDAO();
					int result = booksDAO.booksEnrollment(books.getBooksName(), books.getAuthor(), books.getPublisher(), books.getPrice());
					if (result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('도서 등록에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'books.jsp'");
						script.println("</script>");
					}
					
				}
		}	
		
	%>
</body>
</html>