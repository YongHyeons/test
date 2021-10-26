<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="books.BooksDAO" %>
<%@ page import="books.Books" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시글 삭제</title>
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
		} 
		int booksID = 0;
		if (request.getParameter("booksID") != null){
			booksID = Integer.parseInt(request.getParameter("booksID"));
		}
		if (booksID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 도서입니다.')");
			script.println("location.href = 'books.jsp'");
			script.println("</script>");
		}
		Books books = new BooksDAO().getBooks(booksID);
		if (!userID.equals("dydgus5058")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다..')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else {
				BooksDAO booksDAO = new BooksDAO();
				int result = booksDAO.delete(booksID);
				if (result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('도서 삭제에 실패했습니다.')");
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
	%>
</body>
</html>