<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.DeliveryDataBean"%>
<%@ page import="bookshop.shopping.BuyDataBean"%>
<%@ page import="bookshop.shopping.BuyDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.NumberFormat"%>

<%
   request.setCharacterEncoding("utf-8");
   String managerId = (String) session.getAttribute("managerId");
   if (managerId == null || managerId.equals("")) {
      response.sendRedirect("../logon/managerLoginForm.jsp");
   }
   
   List<BuyDataBean> buyLists = null;
   BuyDataBean buyList = null;
   DeliveryDataBean deliveryList = null;
   int count = 0;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../../js/jquery-3.4.1.js"></script>
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<script>
   function openUser(buyId, sanction, bookTitle) {
      window.open(
                  'deliveryUpModalForm.jsp?buyId=' + buyId + '&sanction='+ sanction + '&bookTitle=' + bookTitle, '',
                  'left=400, top=100, width=900, height=600, scrollbar=no, status=no, resizable=no, fullscreen=no, channelmode=no');
   }
</script>
<style>
   html, body, table {
      text-align: center;
      margin-top: 20px;
   }
</style>
<title>배송 관리</title>
</head>
<body>

   <h2><b>배송 목록</b></h2>
   <p><a href="../managerMain.jsp">관리자 메인으로</a></p>

   <%
      BuyDBBean buyProcess = BuyDBBean.getInstance();
      count = buyProcess.getListCount();
      
      if (count <= 0) {
   %>
      <table>
          <tr>
              <td>배송 목록이 없습니다.</td>
          </tr>
      </table>
   
   <%
      } else {
         buyLists = buyProcess.getBuyList();
   %>
      <div class="col-sm-offset-1 col-sm-10 col-sm-offset-1">
         <form class="form-horizontal" role="form" method="post" name="deliveryList" action="deliveryList.jsp">
             <table class="table table-bordered table-striped nanum table-hover">
                 <tr class="info">
                     <td width="180" align="center">주문 번호</td>
                     <td width="150" align="center">배송 상황</td>
                     <td width="120" align="center">주문자</td>
                     <td width="250" align="center">책 이름</td>
                     <td width="100" align="center">주문 가격</td>
                     <td width="100" align="center">주문 수량</td>
                     <td width="220" align="center">주문일</td>
                     <td width="300" align="center">결제 계좌</td>
                     <td width="100" align="center">배송명</td>
                     <td width="180" align="center">배송지 전화</td>
                     <td width="180" align="center">배송지 주소</td>
                 </tr>
                 
                 <%
                    for (int i = 0; i < buyLists.size(); i++) {
                       buyList = buyLists.get(i);
                 %>
                 <tr>
                     <td align="center"><a href="#"
                        onclick="return openUser('<%=buyList.getBuy_id()%>', '<%=buyList.getSanction()%>', '<%=buyList.getBook_title()%>');">
                        <%=buyList.getBuy_id()%></a></td>
                     <td align="center">
                        <%if (buyList.getSanction().equals("상품준비중")) {%>
                        <span class="glyphicon glyphicon-gift"></span><p class="text-success"><%=buyList.getSanction()%></p>
                        <%} else if (buyList.getSanction().equals("배송중")) {%>
                        <span class="glyphicon glyphicon-send"></span><p class="text-warning"><%=buyList.getSanction()%></p>
                        <%} else if (buyList.getSanction().equals("배송완료")) {%>
                        <span class="glyphicon glyphicon-home"></span><p class="text-danger"><%=buyList.getSanction()%></p>
                        <%}%>
                     </td>
                     <td align="center"><%=buyList.getBuyer()%></td>
                     <td align="center"><%=buyList.getBook_title()%></td>
                     <td align="center"><%=NumberFormat.getInstance().format(buyList.getBuy_price())%></td>
                     <td align="center"><%=buyList.getBuy_count()%></td>
                     <td align="center"><%=buyList.getBuy_date()%></td>
                     <td align="center"><%=buyList.getAccount()%></td>
                     <td align="center"><%=buyList.getDeliveryName()%></td>
                     <td align="center"><%=buyList.getDeliveryTel()%></td>
                     <td align="center"><%=buyList.getDeliveryAddress()%></td>
                 </tr>
                 <%
                    } // end of for
                 %>
             </table>
         </form>
      </div>
   <%
      } // end of if
   %>   

</body>
</html>