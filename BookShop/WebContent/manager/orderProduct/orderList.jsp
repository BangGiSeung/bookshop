<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.BuyDataBean"%>
<%@ page import="bookshop.shopping.BuyDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.NumberFormat"%>

<%
   if (session.getAttribute("managerId") == null) {
      response.sendRedirect("../logon/managerLoginForm.jsp");
   }
   
   String buyer = (String) session.getAttribute("id");
   List<BuyDataBean> buyLists = null;
   BuyDataBean buyList = null;
   
   int count = 0; // 총 구매 건수
   
   BuyDBBean buyProcess = BuyDBBean.getInstance();
   count = buyProcess.getListCount();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../../js/jquery-3.4.1.js"></script>
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<style>
   html, body, table {
      text-align: center;
      margin-top: 20px;
   }
</style>
<title>주문 관리</title>
</head>
<body>
   <h2><b>주문 목록</b></h2>
   <p><a href="../managerMain.jsp">관리자 메인으로</a></p>

   <%
      // 구매 내역이 없는 경우
      if (count <= 0) {
   %>
   <table class="table table-bordered table-striped nanum table-hover">
      <tr class="info">
         <td align="center"><h2>주문받은 내역이 없습니다.</h2></td>
      </tr>
   </table>

   <%
      }
      // 구매 내역이 있는 경우
      else {
         buyLists = buyProcess.getBuyList();
   %>
   <div class="col-sm-offset-1 col-sm-10 col-sm-offset-1">
       <table class="table table-bordered table-striped nanum table-hover">
           <tr class="info">
               <td width="180" align="center">주문 번호</td>
               <td width="120" align="center">주문자</td>
               <td width="250" align="center">책 이름</td>
               <td width="100" align="center">주문 가격</td>
               <td width="100" align="center">주문 수량</td>
               <td width="220" align="center">주문일</td>
               <td width="300" align="center">결제 계좌</td>
               <td width="100" align="center">배송명</td>
               <td width="180" align="center">배송지 전화</td>
               <td width="180" align="center">배송지 주소</td>
               <td width="150" align="center">배송지 상황</td>
           </tr>
           
           <%
              for (int i = 0; i < buyLists.size(); i++) {
                 buyList = buyLists.get(i);
           %>
           <tr>
               <td align="center"><%=buyList.getBuy_id()%></td>
               <td align="center"><%=buyList.getBuyer()%></td>
               <td align="center"><%=buyList.getBook_title()%></td>
               <td align="center"><%=NumberFormat.getInstance().format(buyList.getBuy_price())%></td>
               <td align="center"><%=buyList.getBuy_count()%></td>
               <td align="center"><%=buyList.getBuy_date()%></td>
               <td align="center"><%=buyList.getAccount()%></td>
               <td align="center"><%=buyList.getDeliveryName()%></td>
               <td align="center"><%=buyList.getDeliveryTel()%></td>
               <td align="center"><%=buyList.getDeliveryAddress()%></td>
               <td align="center"><%=buyList.getSanction()%></td>
           </tr>
           <%
              } // end of for
           %>
       </table>
   </div>
   <%
      } // end of if
   %>

</body>
</html>