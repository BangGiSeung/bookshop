<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bookshop.master.ShopBookDBBean"%>
<%@ page import="bookshop.master.ShopBookDataBean"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
	String realFolder = "";
	realFolder = "http://localhost:8889/BookShop/imageFile";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../js/jquery-3.4.1.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>

<title>도서 쇼핑몰</title>
</head>
<body>
	<br>
	<br>
	<br>
	<h2 align="center">더보기</h2>
	<%
		List<ShopBookDataBean> bookLists = null;
		String book_kind = request.getParameter("book_kind");
		ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
		bookLists = bookProcess.getBooks(book_kind);

		ShopBookDataBean bookArr[] = new ShopBookDataBean[bookLists.size()];
		bookLists.toArray(bookArr);

		int number = 0;
		String book_kindName = "";

		// 책 종류의 값을 문자로 반환한다.
		if (book_kind.equals("100")) {
			book_kindName = "문학";
		} else if (book_kind.equals("200")) {
			book_kindName = "외국어";
		} else if (book_kind.equals("300")) {
			book_kindName = "컴퓨터";
		} else {
			book_kindName = "전체";
		}
	%>

	<br>
	<table class="table table-bordered table-striped nanum table-hover"
		style="margin-bottom: 0">
		<tr class="info" height="30">
			<td width="550"><font size="+1"><b><%=book_kindName%>
						분류의 신간 목록 </b></font></td>
		</tr>
	</table>

	<%
		for (int i = 0; i < bookArr.length; i++) {
	%>

	<table class="table table-bordered table-striped nanum table-hover">
		<tr height="30">
			<td rowspan="4" width="100"><a
				href="bookContent.jsp?book_id=<%=bookArr[i].getBook_id()%>&book_kind=<%=bookArr[i].getBook_kind()%>">
					<img src="<%=realFolder%>/<%=bookArr[i].getBook_image()%>"
					alt="이미지 없음" border="0" width="100%" height="125%">
			</a></td>
			<td width="350"><font size="+1"><b> <a
						href="bookContent.jsp?book_id=<%=bookArr[i].getBook_id()%>&book_kind=<%=bookArr[i].getBook_kind()%>">
							<%=bookArr[i].getBook_title()%></a>
				</b></font></td>
			<td rowspan="4" width="100">
				<%
					if (bookArr[i].getBook_count() <= 0) {
				%>
				<h4 align="center">
					<b><font color="red">일시품절</font></b>
				</h4> <%
 	} else {
 %>
				<h4 align="center">
					<b><font color="blue">구매가능</font></b>
				</h4> <%
 	}
 %>
			</td>
		</tr>
		<tr>
			<td>출판사 : <%=bookArr[i].getPublishing_com()%></td>
		</tr>
		<tr>
			<td>저 자 : <%=bookArr[i].getAuthor()%></td>
		</tr>
		<tr>
			<td>정 가 : <%=NumberFormat.getInstance().format(bookArr[i].getBook_price())%>원
				<br>판매가 : <b><font color="red"><%=NumberFormat.getInstance().format(
						(int) (bookArr[i].getBook_price()) * ((double) (100 - bookArr[i].getDiscount_rate()) / 100))%></font></b>원
			</td>
		</tr>
	</table>
	<%
		}
	%>
</body>
</html>