<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="purchase.Purchase"%>
<%@ page import="purchase.PurchaseDAO"%>
<%@ page import="java.io.PrintWriter"%>
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
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			PurchaseDAO purchaseDAO = new PurchaseDAO();
					int result = purchaseDAO.put(booksID, userID);
					if (result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('장바구니 담기에 실패했습니다.')");
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