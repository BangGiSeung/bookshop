<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bookshop.master.ShopBookDBBean"%>
<%@ page import="bookshop.master.ShopBookDataBean"%>
<%@ page import="java.text.NumberFormat"%>

<%
	String book_id = request.getParameter("book_id");
	String book_kind = request.getParameter("book_kind");
	String id = "";
	int buy_price = 0;
	String realFolder = "";
	String saveFolder = "/imageFile";

	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	realFolder = "http://localhost:8889/BookShop/imageFile";

	//세션이 있는 사람과 없는 사람에 따라 버튼을 틀리게 보이기 위해서
	if (session.getAttribute("id") == null) {
		id = "not";
	} else {
		id = (String) session.getAttribute("id");
	}

	ShopBookDataBean bookList = null;
	String book_kindName = "";

	ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
	bookList = bookProcess.getBook(Integer.parseInt(book_id));

	if (book_kind.equals("100"))
		book_kindName = "문학";
	else if (book_kind.equals("200"))
		book_kindName = "외국어";
	else if (book_kind.equals("300"))
		book_kindName = "컴퓨터";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 상세 정보</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../js/jquery-3.4.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

	<jsp:include page="../module/top.jsp" flush="false" />
	<br>
	<br>
	<br>
	<br>

	<form name="inform" method="post" action="cartInsert.jsp"
		style="margin-left: 50px; margin-right: 50px">
		<table class="table">
			<tr>
				<td rowspan="8" width="150"><img
					src="<%=realFolder%>/<%=bookList.getBook_image()%>" border="0"
					width="100%" height="238%"></td>
				<td width="500"><font size="+1"><b><%=bookList.getBook_title()%></b></font>
				</td>
			</tr>
			<tr>
				<td width="500">저 자 : <%=bookList.getAuthor()%></td>
			</tr>
			<tr>
				<td width="500">출판사 : <%=bookList.getPublishing_com()%></td>
			</tr>
			<tr>
				<td width="500">출판일 : <%=bookList.getPublishing_date()%></td>
			</tr>
			<tr>
				<td width="500">정 가 : <%=NumberFormat.getInstance().format(bookList.getBook_price())%>
					원<br> <%
 	buy_price = (int) (bookList.getBook_price() * ((double) (100 - bookList.getDiscount_rate()) / 100));
 %>
				</td>
			</tr>
			<tr>
				<td width="500">판매가 : <b><font color="red"><%=NumberFormat.getInstance().format((int) (buy_price))%>
							원</font> | &nbsp;할인율 : <font color="blue"><%=bookList.getDiscount_rate()%>
							%</font> </b>
				</td>
			</tr>
			<tr>
				<td width="500">재고수량: <%=bookList.getBook_count()%> 권 | 구매수량: <input
					type="text" id="buyCount" size="4" name="buy_count" value="1">
					권 <%
					if (bookList.getBook_count() <= 0) {
				%> <b><font color="red">일시품절</font></b> <%
 	} else {
 		if (!id.equals("not")) {
 %> <b><font color="red"><label id="totalAmount"></label></font></b>
					<input type="hidden" name="book_id" value="<%=book_id%>"> <input
					type="hidden" name="book_image"
					value="<%=bookList.getBook_image()%>"> <input type="hidden"
					name="book_title" value="<%=bookList.getBook_title()%>"> <input
					type="hidden" name="buy_price" value="<%=buy_price%>"> <input
					type="hidden" name="book_kind" value="<%=book_kind%>"> <input
					type="submit" value="장바구니에 담기"> <%
 	}
 	}
 %>
				</td>
			</tr>
			<tr>
				<td width="500"><input type="button" value="목록으로"
					onclick="javascript:window.location='listMain.jsp?book_kind=<%=book_kind%>'">
					<input type="button" value="메인으로"
					onclick="javascript:window.location='shopMain.jsp'"></td>
			</tr>
			<tr>
				<td colspan="2" align="left"><%=bookList.getBook_content()%></td>
			</tr>
		</table>
	</form>

	<script>
		var $input = $("#buyCount");
		$("#buyCount").on(
				'input',
				function() {
					alert("수랑이 변경되었습니다.");
					$('#totalAmount').text(
							"총구매가:" + Number(
	<%=buy_price%>
		)
									* Number($('buyCount').val()) + "원")
				});

		(function($) {
			var originalVal = $.fn.val;
			$.fn.val = function(value) {
				var res = originalVal.apply(this.arguments);

				if (this.is('input:text') && arguments.length >= 1) {
					this.trigger("input");
				}
				return res;
			}
		});
		(jQuery)
	</script>

</body>
</html>