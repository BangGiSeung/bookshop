<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");

		// 세션 값이 없으면 로그인 화면으로 이동시킨다.
		if (managerId == null || managerId.equals("")) {
			response.sendRedirect("logon/managerLoginForm.jsp?useSSL=false");
		} else { // 세션이 있는 사람만 밑의 로그인 후 화면을 보여준다
%>
<html>

<head>
    <meta charset="UTF-8">
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="../js/jquery-3.4.1.js"></script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <title>Insert title here</title>
    <style>
        body {
            position: relative;
        }

        .affix {
            top: 0;
            width: 100%;
            z-index: 9999 important;
        }

        .navbar {
            margin-bottom: 0px;
        }

        .affix~,
        container-fluid {
            position: relative;
            top: 50px;
        }

    </style>
</head>

<body data-spy="scroll" data-target=".navbar" data-offset="50">

    <div class="container-fluid" style="background-color: #F44336; color: #FFF; height: 200px;">
        <h1>도 서 쇼 핑 몰 관 리</h1>
        <h3>도서 쇼핑몰을 관리하기 위한 프로그램입니다.</h3>
        <p>도서 쇼핑몰을 관리하기 위한 프로그램입니다.</p>
        <p>도서 쇼핑몰을 관리하기 위한 프로그램입니다.</p>
    </div>

    <nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">BookShop</a>
            </div>
            <div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class=" nav navbar-nav">
                        <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">상품관리</a>
                        <ul class="dropdown-menu">
                            <li><a href="productProcess/bookRegisterForm.jsp">상품등록</a></li>
                            <li><a href="productProcess/bookList.jsp?book_kind=all">상품수정/삭제</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">판매관리 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="orderProduct/orderList.jsp">판매리스트</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">배송관리 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="delivery/deliveryList.jsp">배송리스트</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">통계관리 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="statistics/monthStatsForm.jsp">월별판매리스트(꺽은선)</a></li>
                            <li><a href="statistics/monthBarStatsForm.jsp">월별판매리스트(막대)</a></li>
                            <li><a href="statistics/bookKindStatsForm.jsp">도서종류별 연간판매비율(도너츠)</a></li>
                        </ul>
                    </li>
                    <li>
                       <a href="logon/managerLogout.jsp">로그아웃</a>
                    </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

</body>

</html>

<%
	} // end of else
	} catch (Exception e) {
		e.printStackTrace();
	}
%>