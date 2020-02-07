<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.CustomerDBBean"%>
<%@ page import="java.sql.Timestamp"%>

<%
	request.setCharacterEncoding("utf-8");

	//회원가입에 입력한 데이터를 전 페이지에서 가져온다.
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel1") + "-" + request.getParameter("tel2") + "-"
			+ request.getParameter("tel3");
	String address = request.getParameter("address");
%>

<jsp:useBean id="customer" scope="page"
	class="bookshop.shopping.CustomerDataBean">
</jsp:useBean>

<%
	customer.setId(id);
	customer.setPasswd(passwd);
	customer.setName(name);
	customer.setTel(tel);
	customer.setAddress(address);
	customer.setReg_date(new Timestamp(System.currentTimeMillis()));

	CustomerDBBean customerProcess = CustomerDBBean.getInstance();
	customerProcess.insertMember(customer);

	//회원가입 축하한다는 팝업창....

	response.sendRedirect("../shopMain.jsp");
%>