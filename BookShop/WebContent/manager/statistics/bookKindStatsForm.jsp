<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="bookshop.shopping.BuyBookKindDataBean"%>
<%@ page import="bookshop.shopping.BuyDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.NumberFormat"%>

<%
   request.setCharacterEncoding("utf-8");

   String managerId = "";
   try {
      managerId = (String) session.getAttribute("managerId");
      if (managerId == null || managerId.equals("")) {
         response.sendRedirect("../logon/managerLoginForm.jsp");
      } else {
         String year = request.getParameter("year");

         BuyBookKindDataBean buyBookKindList = null;
         BuyDBBean buyProcess = BuyDBBean.getInstance();
         buyBookKindList = buyProcess.buyBookKindYear(year);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../css/morris.css" rel="stylesheet">
<script src="../../js/jquery-3.4.1.js"></script>
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<script src="../../js/morris.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<style>
#myfirstchart, #tt, #dd, #cc {
   margin-top: 20px;
}
</style>
<title>도서 종류별 연간 판매비율</title>
</head>
<body>

   <div class="container" id="cc">
       <h2 align="center"><b>도서 종류별 연간 판매 비율</b></h2>
       <form action="bookKindStatsForm.jsp" class="form-horizontal" role="form" method="post" name="bookKindStatsForm">
           <div class="form-group" style="text-align: center;" id="dd">
               <div class="col-sm-1">
                   <h4><span class="label label-info">검색년도</span></h4>
               </div>
               <div class="col-sm-2">
                   <input type="text" class="form-control" id="year" name="year" placeholder="Enter Year" maxlength="4">
               </div>
               <div class="col-sm-2">
                   <input type="submit" class="btn btn-danger btn-sm" value="검색하기">
                   <input type="button" class="btn btn-info btn-sm" value="메인으로" onclick="javascript:window.location='../managerMain.jsp'">
               </div>
           </div>
           <table class="table table-bordered border=1" width="700" cellsapcing="0" cellpadding="0" align="center" id="tt">
                <thead>
                    <tr class="info">
                        <td align="center"><h3>문학</h3></td>
                        <td align="center"><h3>외국어</h3></td>
                        <td align="center"><h3>컴퓨터</h3></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td align="center"><h3><%=buyBookKindList.getBookQty100()%></h3></td>
                        <td align="center"><h3><%=buyBookKindList.getBookQty200()%></h3></td>
                        <td align="center"><h3><%=buyBookKindList.getBookQty300()%></h3></td>
                    </tr>
                    <tr class="danger">
                        <td align="right" colspan="12">
                            <h3><p class="bg-danger">총 판매수량 : <%=buyBookKindList.getTotal()%></p></h3>
                        </td>
                    </tr>
                </tbody>
           </table>
       </form>
   </div>
   
   <div id="myfirstchart" style="height: 300px; text-align: center;"></div>
   
   <script>
      // (문학의 총 수량 * 100) / 책 전체 수량
      var q1 = Math.floor(Number(<%=buyBookKindList.getBookQty100()%>) * 100 / (<%=buyBookKindList.getTotal()%>));
      var q2 = Math.floor(Number(<%=buyBookKindList.getBookQty200()%>) * 100 / (<%=buyBookKindList.getTotal()%>));
      var q3 = Math.floor(Number(<%=buyBookKindList.getBookQty300()%>) * 100 / (<%=buyBookKindList.getTotal()%>));
      
      new Morris.Donut({
         // 그래프를 표시하기 위한 객체의 id
         element: 'myfirstchart',
         // 그래프의 데이터. 각 요소가 하나의 그래프 상의 값에 해당한다.
         data: [
            {value: q1, label: '문학'},
            {value: q2, label: '외국어'},
            {value: q3, label: '컴퓨터'}
         ],
         backgroundColor: '#DAD9FF',
         labelColor: '#0100FF',
         colors: [
            '#4641D9', '#6B66FF', '#B5B2FF'
         ]
      });
   </script>

</body>
</html>

<%
      }
   } catch (Exception e) {
      e.printStackTrace();
   }
%>