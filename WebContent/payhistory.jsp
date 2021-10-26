<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "books.BooksDAO" %>
<%@ page import = "books.Books" %>
<%@ page import = "purchase.Purchase"%>
<%@ page import = "purchase.PurchaseDAO"%>
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
	#deletebtn { background-color:#ffffff; color: #000000; text-decoration: none; border:none;}
	#bs { color:#50bcdf; text-decoration: none; font-size:10px; }
</style>
<script type="text/javascript">
	function getInputValue(){
		var valueById = $('#inputId').val();
		alert(valueById);
	}
</script>
</head>	
<body>
	<%	
		String userID = null;
		int booksID = 0;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
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
				<li><a href="books.jsp">도서</a></li>
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
						<th style="background-color: #eeeeee; text-align: center;">도서코드</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">저자</th>
						<th style="background-color: #eeeeee; text-align: center;">출판사</th>
						<th style="background-color: #eeeeee; text-align: center;">가격(원)</th>
						<th style="background-color: #eeeeee; text-align: center;">수량</th>
						<th style="background-color: #eeeeee; text-align: center;">구매날짜</th>
					</tr>
				</thead>
				<tbody>
					<%
						PurchaseDAO purchaseDAO = new PurchaseDAO();
						BooksDAO booksDAO = new BooksDAO();
						int available = 1, status = 2;
						int pricei;
						int volumesi;
						String paydate = null;
						ArrayList<Purchase> purlist = purchaseDAO.getListp(userID);
						Books books = new Books();
						for(int i = 0; i < purlist.size(); i++){
						booksID = purlist.get(i).getBooksID();
						books = booksDAO.getBooks(booksID);
						
						pricei = Integer.parseInt(books.getPrice());
						volumesi = purlist.get(i).getVolumes();
						paydate = purlist.get(i).getPurchaseDate();
						//c = purchaseDAO.volumesCount(books.get(i).getBooksID(), userID);
					%>
					<tr>
						<td><%= books.getBooksID() %></td>
						<td><a href="booksDetail.jsp?booksID=<%= books.getBooksID() %>"><%= books.getBooksName()%></a></td>
						<td><%= books.getAuthor() %></td>
						<td><%= books.getPublisher()%></td>
						<%
							if(books.getPrice().length() > 3) {
						%>
						<td><%= books.getPrice().substring(0, (books.getPrice().length()-3)) + "," + books.getPrice().substring((books.getPrice().length()-3),(books.getPrice().length()))%></td>
						<%
							} else {
						%>
							<td><%= books.getPrice()%></td>
						<%
							}
						%>
						<td>
							<%= volumesi%>
						</td>
							<td><%= paydate.substring(0, 11) + paydate.substring(11, 13) + "시" + paydate.substring(14, 16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>