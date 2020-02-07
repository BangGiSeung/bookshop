<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bookshop.master.ShopBookDBBean" %>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

// System.out.println(id+" : "+passwd);

ShopBookDBBean manager = ShopBookDBBean.getInstance();

int check = manager.managerCheck(id, passwd);

if(check == 1){ // 비밀번호가 맞을때 {rtnVal = 1; // 인증 성공!}
   // 아이디와 비밀번호가 맞으면 세션을 발급한다.
   session.setAttribute("managerId", id);
   response.sendRedirect("../managerMain.jsp"); // 폴더 한 칸 앞으로 전진 유의!
} else if(check == 0){ // {rtnVal = 0; // 비밀번호 틀림}
%>
   <script>
      alert("비밀번호가 맞지 않습니다.");
      history.go(-1); // -1(바로전페이지)로 보내라.
   </script>
<%
} else { // {rtnVal = -1; // 해당 아이디가 없다.}
%>
   <script>
      alert("아이디가 맞지 않습니다.");
      history.go(-1);
   </script>
<%   
}
%>