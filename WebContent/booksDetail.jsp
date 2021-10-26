<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "books.Books" %>
<%@ page import = "books.BooksDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 도서 상세</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int booksID = 0;
		if (request.getParameter("booksID") != null){
			booksID = Integer.parseInt(request.getParameter("booksID"));
		}
		if (booksID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 도서입니다.')");
			script.println("location.href = 'books.jsp'");
			script.println("</script>");
		}
		Books books = new BooksDAO().getBooks(booksID);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 도서 관리</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class = "active"><a href="books.jsp">도서</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href= "basket.jsp">장바구니</a></li>
						<li><a href= "payhistory.jsp">구매내역</a></li>
						<li><a onclick="return confirm('로그아웃 하시겠습니까?')" href= "logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class ="row">
			<table class="table table-striped" style = "text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">도서 상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">도서명</td>
						<td colspan="2"><%= books.getBooksName() %></td>
					</tr>
					<tr>
						<td>저자</td>
						<td colspan="2"><%= books.getAuthor() %></td>
					</tr>
					<tr>
						<td>출판사</td>
						<td colspan="2"><%= books.getPublisher() %></td>
					</tr>
					<tr>
						<td>가격</td>
						<td colspan="2"><%= books.getPrice() %></td>
					</tr>
				</tbody>
			</table>
			<a href="books.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals("dydgus5058")){
			%>
					<a href="booksUpdate.jsp?booksID=<%= booksID %>" class="btn btn-primary pull-right">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="b_deleteAction.jsp?booksID=<%= booksID %>" class="btn btn-primary pull-right">삭제</a>
			<%
				} else {
			%>
					<a onclick="return confirm('즉시 구매 하시겠습니까?')" href="paymentAction.jsp?booksID=<%= booksID %>" class="btn btn-primary pull-right">바로 구매하기</a>
					<a href="putAction.jsp?booksID=<%= booksID %>" class="btn btn-primary pull-right">장바구니 담기</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>