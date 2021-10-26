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
<title>JSP 도서 정보 수정</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
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
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Books books = new BooksDAO().getBooks(booksID);
		if (!userID.equals("dydgus5058")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다..')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
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
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href= "basket.jsp">장바구니</a></li>
						<li><a onclick="return confirm('로그아웃 하시겠습니까?')" href= "logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class ="row">
			<form method="post" action="b_updateAction.jsp?booksID=<%= booksID%>">
				<table class="table table-striped" style = "text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">도서 정보 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="도서명" name="booksName" mexlength="50" value="<%= books.getBooksName()%>"></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="저자" name="author" mexlength="50" value="<%= books.getAuthor()%>"></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="출판사" name="publisher" mexlength="50" value="<%= books.getPublisher()%>"></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="가격" name="price" mexlength="50" value="<%= books.getPrice()%>"></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="수정하기">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>