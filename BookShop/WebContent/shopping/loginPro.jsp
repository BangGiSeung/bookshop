<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.CustomerDBBean"%>
<%
	request.setCharacterEncoding("utf-8");

	//로그인 검사를 하는데 필요한 자료를 가져온다.
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");

	CustomerDBBean member = CustomerDBBean.getInstance();
	int check = member.userCheck(id, passwd);

	//인증된 결과에 대해서 처리를 한다.
	if (check == 1) {
		//회원아이디가 존재하고 비밀번호가 맞으면 세션을 발급한다.
		session.setAttribute("id", id);
		response.sendRedirect("shopMain.jsp");
	} else if (check == 0) {
		//회원아이디는 존재하나 비밀번호가 틀린 경우
%>
<script>
	alert("비밀번호가 맞지 않습니다.\n비밀번호를 확인하신 후 다시 시도하십시오.");
	history.go(-1); // 이전 화면으로 넘어가는것.
</script>
<%
	} else {
		//회원아이디 자체가 존재하지 않는 경우
%>
<script>
	alert("아이디가 맞지 않습니다.\n아이디를 확인하신 후 다시 시도하십시오.");
	history.go(-1);
</script>
<%
	}
%>