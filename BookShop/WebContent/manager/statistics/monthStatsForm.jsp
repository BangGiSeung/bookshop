<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="bookshop.shopping.BuyMonthDataBean"%>
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

         BuyMonthDataBean buyMonthList = null;
         BuyDBBean buyProcess = BuyDBBean.getInstance();
         buyMonthList = buyProcess.buyMonth(year);
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
<title>월별 판매 현황</title>
</head>
<body>

   <div class="container" id="cc">
       <h2 align="center"><b>월별 판매 현황</b></h2>
       <form action="monthStatsForm.jsp" class="form-horizontal" role="form" method="post" name="monthStatsForm">
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
                        <td align="center"><h3>1월</h3></td>
                        <td align="center"><h3>2월</h3></td>
                        <td align="center"><h3>3월</h3></td>
                        <td align="center"><h3>4월</h3></td>
                        <td align="center"><h3>5월</h3></td>
                        <td align="center"><h3>6월</h3></td>
                        <td align="center"><h3>7월</h3></td>
                        <td align="center"><h3>8월</h3></td>
                        <td align="center"><h3>9월</h3></td>
                        <td align="center"><h3>10월</h3></td>
                        <td align="center"><h3>11월</h3></td>
                        <td align="center"><h3>12월</h3></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td align="center"><h3><%=buyMonthList.getMonth01()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth02()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth03()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth04()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth05()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth06()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth07()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth08()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth09()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth10()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth11()%></h3></td>
                        <td align="center"><h3><%=buyMonthList.getMonth12()%></h3></td>
                    </tr>
                    <tr class="danger">
                        <td align="right" colspan="12">
                            <h3><p class="bg-danger">총 판매수량 : <%=buyMonthList.getTotal()%></p></h3>
                        </td>
                    </tr>
                </tbody>
           </table>
       </form>
   <div id="myChart" style="height: 300px; text-align: center;"></div>
   </div>
   
   <%-- <script>
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
   </script> --%>
   <script>
	   	var m01 = <%=year%> + "-01";
	   	var m02 = <%=year%> + "-02";
	   	var m03 = <%=year%> + "-03";
	   	var m04 = <%=year%> + "-04";
	   	var m05 = <%=year%> + "-05";
	   	var m06 = <%=year%> + "-06";
	   	var m07 = <%=year%> + "-07";
	   	var m08 = <%=year%> + "-08";
	   	var m09 = <%=year%> + "-09";
	   	var m10 = <%=year%> + "-10";
	   	var m11 = <%=year%> + "-11";
	   	var m12 = <%=year%> + "-12";
	   	new Morris.Line({
	   		element: 'myChart',
	   		data: [
	   			{year:m01, value: <%=buyMonthList.getMonth01() %>},
	   			{year:m02, value: <%=buyMonthList.getMonth02() %>},
	   			{year:m03, value: <%=buyMonthList.getMonth03() %>},
	   			{year:m04, value: <%=buyMonthList.getMonth04() %>},
	   			{year:m05, value: <%=buyMonthList.getMonth05() %>},
	   			{year:m06, value: <%=buyMonthList.getMonth06() %>},
	   			{year:m07, value: <%=buyMonthList.getMonth07() %>},
	   			{year:m08, value: <%=buyMonthList.getMonth08() %>},
	   			{year:m09, value: <%=buyMonthList.getMonth09() %>},
	   			{year:m10, value: <%=buyMonthList.getMonth10() %>},
	   			{year:m11, value: <%=buyMonthList.getMonth11() %>},
	   			{year:m12, value: <%=buyMonthList.getMonth12() %>}
	   		],
	   		// 그래프 데이터에서 x축에 해당하는 값의 이름
	   		xkey: 'year',
	   		// 그래프 데이터에서 y축에 해당하는 값의 이름
	   		ykeys: ['value'],
	   		// 각 값에 대해서 마우스 오버시 표시하기 위한 레이블
	   		labels:['Value']
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