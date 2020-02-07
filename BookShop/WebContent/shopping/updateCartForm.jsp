<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.CartDBBean"%>
<%
	String cart_id = request.getParameter("cart_id");
	String buy_count = request.getParameter("buy_count");
	String buy_countOld = request.getParameter("buy_count");
	String book_kind = request.getParameter("book_kind");
	String book_id = request.getParameter("book_id");

	if (session.getAttribute("id") == null) {
		response.sendRedirect("shopMain.jsp");
	} else {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도서 수량 변경</title>
<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../js/jquery-3.4.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script>
	function cartUpdate() {
		var rtnVal = confirm("구매수량을 수정하시겠습니다.");
		if(rtnVal == true) { 
			// ../는 상위 폴더 , ./는 동일 폴더를 의미
			updateForm.action = "./updateCartPro.jsp";
			updateForm.submit();
		}
	}
</script>
</head>
<body>
	<div class="container">
		<h2>구매 수량 변경</h2>
		<form class="form-inline" method="post" name="updateForm">
			<div class="form-group">
			<label class="sr-only">변경할 수량</label>
			<input type="text" class="form-control" name="buy_count" size="4" value="<%=buy_count%>" placeholder="구매 수량">
			<input type="hidden" class="form-control" name="buy_countOld" size="4" value="<%=buy_countOld%>">
			<input type="hidden" class="form-control" name="cart_id" size="4" value="<%=cart_id%>">
			<input type="hidden" class="form-control" name="book_kind" size="4" value="<%=book_kind%>">
			<input type="hidden" class="form-control" name="book_id" size="4" value="<%=book_id%>">
			</div>
			<input type="submit" align="center" class="btn btn-danger btn-submit" value="수정" onclick="cartUpdate(); return false;" onfocus="this.blur()">
		</form>
	</div>
</body>
</html>
<%
	} // end - session
%>