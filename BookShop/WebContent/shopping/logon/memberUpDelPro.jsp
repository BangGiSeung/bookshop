<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.CustomerDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%
request.setCharacterEncoding("utf-8");
String buyer = (String)session.getAttribute("buyer");

String	mode	= request.getParameter("mode");
String	id		= request.getParameter("id");
String	passwd	= request.getParameter("passwd");
String	name	= request.getParameter("name");
String	tel		= request.getParameter("tel");
String	address	= request.getParameter("address");
%>
<jsp:useBean id="customer" scope="page" class="bookshop.shopping.CustomerDataBean">
</jsp:useBean>
<%
customer.setId(id);
customer.setPasswd(passwd);
customer.setName(name);
customer.setTel(tel);
customer.setAddress(address);
customer.setReg_date(new Timestamp(System.currentTimeMillis()));

CustomerDBBean customerProcess = CustomerDBBean.getInstance();

if(mode.equals("UP")) { //수정일 경우는 모든 정보를 넘겨준다.
	customerProcess.updateMember(customer);
	response.sendRedirect("../shopMain.jsp");
} else if(mode.equals("DEL")) { //탈퇴일 경우는 id와 비밀번호만 있으면 된다.
	int del = customerProcess.deleteMember(id, passwd);
	if(del == 1) {
		//회원탈퇴를 하면 세션을 소멸시킨다.
		session.invalidate(); 
		response.sendRedirect("../shopMain.jsp");
	} else {
		%>
		<script>
			alert("비밀번호 틀렸습니다.");
			history.go(-2);
			alert("다시 입력하세요.");
		</script>
		<%
	}
} else { 
	response.sendRedirect("../shopMain.jsp");
}
%>