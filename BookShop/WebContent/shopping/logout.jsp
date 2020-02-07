<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//로그아웃을 하면 세션을 소멸시킨다.
	session.invalidate();
%>
<script>
	alert("로그아웃 되었습니다.");
	location.href = "shopMain.jsp";
</script>