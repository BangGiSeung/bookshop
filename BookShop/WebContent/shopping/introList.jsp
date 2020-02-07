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
<br>
<br>
<br>
<h2 align="center">신간 소개</h2>
<%
	ShopBookDataBean bookLists[] = null;
	bookLists = new ShopBookDataBean[3];
	int number = 0;
	String book_kindName = "";

	ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
	// 책종류(book_kind)는 100, 200, 300으로 저장되었기 때문에 for문을 이용해서 
	// 100, 200, 300으로 만든다.
	for (int i = 1; i <= 3; i++) {
		bookLists = bookProcess.getBooks(i + "00", 3);

		if (bookLists == null) {
			continue;
		}

		// 책 종류의 값을 문자로 반환한다.
		if (bookLists[0].getBook_kind().equals("100"))
			book_kindName = "문학";
		if (bookLists[0].getBook_kind().equals("200"))
			book_kindName = "외국어";
		if (bookLists[0].getBook_kind().equals("300"))
			book_kindName = "컴퓨터";
%>

<br>
<table class="table table-bordered table-striped nanum table-hover" style="margin-bottom: 0">
	<tr class="info" height="30">
		<td width="550"><font size="+1"><b><%=book_kindName%>
					분류의 신간 목록 : <a href="listMain.jsp?book_kind=<%=bookLists[0].getBook_kind()%>">더보기</a></b></font></td>
	</tr>
</table>

<%
	int bookCount = bookProcess.getBookCount2(bookLists[0].getBook_kind());
		if (bookCount >= 3)
			bookCount = 3;
		// 내부 for문 : 책의 종류에 따라 최대 3건의 도서자료를 보여준다.
		for (int j = 0; j < bookCount; j++) {
%>
<table class="table table-bordered table-striped nanum table-hover">
	<tr height="30">
		<td rowspan="4" width="100"><a
			href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[j].getBook_kind()%>">
				<img src="<%=realFolder%>/<%=bookLists[j].getBook_image()%>" alt="이미지 없음" border="0" width="100%" height="125%">
		</a></td>
		<td width="350"><font size="+1"><b> <a
					href="bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[j].getBook_kind()%>">
						<%=bookLists[j].getBook_title()%></a>
			</b></font></td>
		<td rowspan="4" width="100">
			<%
				if (bookLists[j].getBook_count() <= 0) {
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
		<td>출판사 : <%=bookLists[j].getPublishing_com()%></td>
	</tr>
	<tr>
		<td>저   자 : <%=bookLists[j].getAuthor()%></td>
	</tr>
	<tr>
		<td>정   가 : <%=NumberFormat.getInstance().format(bookLists[j].getBook_price())%>원
			<br>판매가 : <b><font color="red"><%=NumberFormat.getInstance().format((int) (bookLists[j].getBook_price())
							* ((double) (100 - bookLists[j].getDiscount_rate()) / 100))%></font></b>원
		</td>
	</tr>
</table>
<%
	}
	}
%>