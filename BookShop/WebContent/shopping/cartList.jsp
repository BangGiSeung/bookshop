<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.CartDataBean"%>
<%@ page import="bookshop.shopping.CartDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect("shopMain.jsp");
	} else {
		String book_kind = request.getParameter("book_kind");
		String buyer = (String) session.getAttribute("id");

		List<CartDataBean> cartLists = null;
		CartDataBean cartList = null;

		int count = 0;
		int number = 0;
		int total = 0;

		CartDBBean cartProcess = CartDBBean.getInstance();
		count = cartProcess.getListCount(buyer);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../js/jquery-3.4.1.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<title>장바구니 목록</title>
</head>
<body>

	<jsp:include page="../module/top.jsp" flush="false" />
	<br>
	<br>
	<br>

	<%
		if (count <= 0) { //장바구니에 데이터가 없다면
	%>
	<h2>
		<span class="label label-success">장 바 구 니</span>
	</h2>
	<hr>
	<h3>장바구니에 담긴 물품이 없습니다.</h3>
	<hr>
	<input class="btn btn-info btn-xs" type="button" value="쇼핑계속"
		onclick="javascript:window.location='listMain.jsp?book_kind=<%=book_kind%>'">
	<%
		} else {
				String realFolder = "";
				String saveFolder = "/imageFile";
				ServletContext context = getServletContext();
				realFolder = context.getRealPath(saveFolder);
				realFolder = "http://localhost:8889/BookShop/imageFile";

				//보여줄 장바구니의 정보를 가져온다.
				cartLists = cartProcess.getCart(buyer);
	%>
	<h3>
		<span class="label label-success">장 바 구 니</span>
	</h3>
	<form name="cartForm">
		<table class="table table-bordered table-strpied nanum table-hover">
			<tr class="info">
				<td width="50">번호</td>
				<td width="300">책제목</td>
				<td width="100">판매가격</td>
				<td width="100">수량</td>
				<td width="150">금액</td>
			</tr>
			<%
				for (int i = 0; i < cartLists.size(); i++) {
							cartList = (CartDataBean) cartLists.get(i);
							//아래의 반복되는 부분을 작성해주세요!!!!!!
			%>
			<tr>
				<td width=" 50"><%=++number%></td>
				<td width="300" align="left"><img
					src="<%=realFolder%>/<%=cartList.getBook_image()%>" border="0"
					width="30" height="50" align="middle"> <%=cartList.getBook_title()%>
				</td>
				<td width="100"><%=NumberFormat.getInstance().format(cartList.getBuy_price())%>&nbsp;원
				</td>
				<td width="150"><input type="text" style="text-align: right"
					name="buy_count" size="4" value="<%=cartList.getBuy_count()%>">
					<%
						String url = "updateCartForm.jsp?cart_id=" + cartList.getCart_id() + "&book_kind=" + book_kind
											+ "&buy_count=" + cartList.getBuy_count() + "&book_id=" + cartList.getBook_id();
					%> <input class="btn btn-warning btn-xs" type="button" value="수정"
					onclick="javascript:window.location='<%=url%>'"></td>
				<td align="center" width="150">
					<%
						total += cartList.getBuy_count() * cartList.getBuy_price();
					%> <%=NumberFormat.getInstance().format(cartList.getBuy_count() * cartList.getBuy_price())%>&nbsp;원&nbsp;
					<input class="btn btn-danger btn-xs" type="button" value="삭제"
					onclick="javascript:window.location=
               'cartListDel.jsp?list=<%=cartList.getCart_id()%>&book_kind=<%=book_kind%>'">
				</td>
			</tr>
			<%
				}
			%>
			<!-- 반복문이 완료된후 총합계 금액을 출력한다. -->
			<tr class="danger">
				<td colspan="5" align="right">
					<h4>
						총 금액 :
						<%=NumberFormat.getInstance().format(total)%>&nbsp;
					</h4>
				</td>
			</tr>
			<tr>
				<td colspan="5"><input class="btn btn-warning btn-sm"
					type="button" value="구매하기"
					onclick="javascript:window.location='buyForm.jsp'">&nbsp;&nbsp;
					
					<input class="btn btn-info btn-sm" type="button" value="쇼핑계속하기"
					onclick="javascript:window.location='listMain.jsp?book_kind=<%=book_kind%>'">&nbsp;&nbsp;
					
					<input class="btn btn-danger btn-sm" type="button" value="장바구니비우기"
					onclick="javascript:window.location='cartListDel.jsp?list=all&book_kind=<%=book_kind%>'">&nbsp;&nbsp;
					
					<input class="btn btn-info btn-sm" type="button" value="메인으로"
					onclick="javascript:window.location='shopMain.jsp'">&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</form>
	<%
		}
	%>
</body>
</html>
<%
	}
%>