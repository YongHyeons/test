<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "books.BooksDAO" %>
<%@ page import = "books.Books" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 도서 관리</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
	#bs { color:#50bcdf; text-decoration: none; font-size:10px;}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
						<li><a href= "logoutAction.jsp">로그아웃</a></li>
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
						<th style="background-color: #eeeeee; text-align: center;">도서코드</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">저자</th>
						<th style="background-color: #eeeeee; text-align: center;">출판사</th>
						<th style="background-color: #eeeeee; text-align: center;">가격(원)</th>
						<th style="background-color: #eeeeee; text-align: center;"></th>
					</tr>
				</thead>
				<tbody>
					<%
						BooksDAO booksDAO = new BooksDAO();
						ArrayList<Books> list = booksDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBooksID() %></td>
						<td><a href="booksDetail.jsp?booksID=<%= list.get(i).getBooksID() %>"><%= list.get(i).getBooksName()%></a></td>
						<td><%= list.get(i).getAuthor() %></td>
						<td><%= list.get(i).getPublisher()%></td>
						<%
							if(list.get(i).getPrice().length() > 3) {
						%>
						<td><%= list.get(i).getPrice().substring(0, (list.get(i).getPrice().length()-3)) + "," + list.get(i).getPrice().substring((list.get(i).getPrice().length()-3),(list.get(i).getPrice().length()))%></td>
						<%
							} else {
						%>
							<td><%= list.get(i).getPrice()%></td>
						<%
							}
						%>
						<td><a href="basket.jsp?booksID=<%= list.get(i).getBooksID() %>" id="bs">장바구니에 담기</a></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>
				<a href="books.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				} if(booksDAO.nextPage(pageNumber + 1)){
			%>
				<a href="books.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<%
				if(userID != null && userID.equals("dydgus5058")){
			%>
			<a href="enrollment.jsp" class="btn btn-primary pull-right">등록하기</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>