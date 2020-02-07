<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.BuyDataBean"%>
<%@ page import="bookshop.shopping.BuyDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.NumberFormat"%>

<%
   if (session.getAttribute("id") == null) {
      response.sendRedirect("shopMain.jsp");
   }
   
   String buyer = (String) session.getAttribute("id");
   List<BuyDataBean> buyLists = null;
   BuyDataBean buyList = null;
   
   int count = 0; // 총 구매 건수
   int total = 0; // 소계 금액
   int sum = 0; // 총합계 금액
   long compareId = 0; // buy_id를 비교하기 위한 변수
   
   String realFolder = "";
   String saveFolder = "";
   ServletContext context = getServletContext();
   realFolder = context.getRealPath(saveFolder);
   realFolder = "http://localhost:8889/BookShop/imageFile";
   
   BuyDBBean buyProcess = BuyDBBean.getInstance();
   // 화면에 보여줄 자료가 몇 건인지 먼저 조사한다.
   count = buyProcess.getListCount(buyer);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../js/jquery-3.4.1.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<title>구매 목록</title>
<style>
    .gi-2x {
        font-size: 2em;
    }
</style>
</head>
<body>

   <jsp:include page="../module/top.jsp" flush="false"></jsp:include>
   <br>
   <br>
   <br>
   
   <%
      // 구매 내역이 없는 경우
      if (count <= 0) {
   %>
   <table class="table table-bordered table-striped nanum table-hover">
       <tr class="info">
           <td align="center"><h2>구매하신 내역이 없습니다.</h2></td>
       </tr>
   </table>
   
   <%
      }
      // 구매 내역이 있는 경우
      else {
         buyLists = buyProcess.getBuyList(buyer);
   %>
   <div class="col-sm-offset-1 col-sm-10 col-sm-offset-1">
       <table class="table table-bordered table-striped nanum table-hover">
           <tr>
               <td>
                   <h3><span class="label label-success">구 매 목 록</span></h3>
               </td>
           </tr>
           <tr class="info">
               <td width="100" align="center">번호</td>
               <td width="300" align="center">제목</td>
               <td width="80" align="center">배송 상태</td>
               <td width="50" align="center">판매 가격</td>
               <td width="50" align="center">구매 수량</td>
               <td width="50" align="center">구매 금액</td>
           </tr>
           
           <%
              for (int i = 0; i < buyLists.size(); i++) {
                 buyList = buyLists.get(i);
                 
                 // 현재 한 건 가져온 데이터를 출력해주고 다음 buy_id와 비교할 값을 구하기
                 // 다음 buy_id를 구하는데, 현재 buy_id가 마지막 데이터라면 다음 데이터를 구할 수 없으므로
                 // -1일때까지만 구한다.
                 if (i < buyLists.size() -1) {
                    BuyDataBean compare = buyLists.get(i+1);
                    compareId = compare.getBuy_id();
                 }
           %>
           <tr>
               <td align="center"><%=buyList.getBuy_id()%></td>
               <td align="left">
                   <img src="<%=realFolder%>/<%=buyList.getBook_image()%>" border="0" width="30" height="50" align="middle" alt="이미지 없음"><%=buyList.getBook_title()%>
               </td>
               <td align="left">
                   <%if (buyList.getSanction().equals("상품준비중")) {%>
                   <span class="glyphicon glyphicon-gift gi-2x"></span>
                   <%} else if (buyList.getSanction().equals("배송중")) {%>
                   <span class="glyphicon glyphicon-send gi-2x"></span>
                   <%} else if (buyList.getSanction().equals("배송완료")) {%>
                   <span class="glyphicon glyphicon-home gi-2x"></span>
                   <%}%>
                   <%=buyList.getSanction()%>
                </td>
                
                <td align="right">
                    <%=NumberFormat.getInstance().format(buyList.getBuy_price())%>원
                </td>
                <td align="right">
                    <%=NumberFormat.getInstance().format(buyList.getBuy_count())%>권
                </td>
                <td align="right">
                    <%total += buyList.getBuy_count() * buyList.getBuy_price();%>
                    <%=NumberFormat.getInstance().format(buyList.getBuy_count() * buyList.getBuy_price())%>원
                </td>
           </tr>
           
           <%
              // 한 건의 데이터를 출력하였다.
              // 현재 buy_id와 다음 buy_id를 비교해서 값이 다르면 소계를 출력한다.
              // 마지막 데이터이면 무조건 소계를 출력한다.
              if ((buyList.getBuy_id() != compareId) || (i == buyLists.size() - 1)) {
                 %>
                    <tr class="danger">
                       <td colspan="6" align="right">
                          <%sum += total;%>
                          <h3>금 액 : <%=NumberFormat.getInstance().format(total)%>원</h3>
                          <%total = 0; compareId = buyList.getBuy_id();%>
                       </td>
                    </tr>
                 <%
              } // end of if
           %>
           
           <%
              } // end of for
           %>
           <tr class="success">
              <td colspan="6" align="right">
                 <h3>총 구매금액 : <%=NumberFormat.getInstance().format(sum)%>원</h3>
              </td>
           </tr>
       </table>
   </div>
   <%
      }
   %>

</body>
</html>