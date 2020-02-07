<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.CustomerDBBean" %>
<%@ page import="java.sql.Timestamp" %>
  
<%
request.setCharacterEncoding("utf-8");

String buyer = (String)session.getAttribute("id");

String	mode	= request.getParameter("mode");
String	id		= request.getParameter("id");
String	passwd	= request.getParameter("passwd");
String	name	= request.getParameter("name");
String	tel		= request.getParameter("tel1") + "-"
				+ request.getParameter("tel2") + "-"
				+ request.getParameter("tel3");
String	address	= request.getParameter("address");
%>
<jsp:useBean id="customer" scope="page" class="bookshop.shopping.CustomerDataBean">
</jsp:useBean>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="../../js/jquery-3.4.1.js"></script>
	<script src="../../bootstrap/js/bootstrap.min.js"></script>
	<script src="../../js/function3.js"></script>
	<title>회원 정보 수정/탈퇴</title>
</head>
<body>

<div class="container">
	<h2>고객 정보 <%if(mode.equals("UP")) {%>수정<%} else {%>탈퇴<%}%></h2>

	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
		고객 정보 <%if(mode.equals("UP")) {%>수정<%} else {%>탈퇴<%}%>
	</button>
	
	<form class="form-horizontal" method="post" name="memberUpDelModalForm"
			action="memberUpDelPro.jsp">
		<input type="hidden" name="mode" 	value="<%=mode %>">		
		<input type="hidden" name="id" 		value="<%=id %>">		
		<input type="hidden" name="passwd" 	value="<%=passwd %>">		
		<input type="hidden" name="name" 	value="<%=name %>">		
		<input type="hidden" name="tel" 	value="<%=tel %>">		
		<input type="hidden" name="address" value="<%=address %>">	
		
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">X</button>
						<h4 class="modal-title" id="myModalLabel">고객 정보 <%if(mode.equals("UP")) {%>수정<%} else {%>탈퇴<%}%></h4>
					</div>
					<div class="modal-body">
						<h2><%if(mode.equals("UP")) {%>고객정보를 수정<%} else {%>회원탈퇴를<%}%> 하시겠습니까?</h2>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">고객 정보 <%if(mode.equals("UP")) {%>수정<%} else {%>탈퇴<%}%></button>
					</div>
				</div>
			</div>
		</div>	
	</form>
</div>

<script>
	//모달 창이 떠있는 상태로 하기 위해서는 스크립트를 추가한다.
	$(function() {
		$('#myModal').modal({
			keyboard: true
		});
	});
</script>

</body>
</html>