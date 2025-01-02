<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.miniprj.minimall.model.CustomerDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> 홈  </h1>

<%
    // 세션에서 사용자 정보를 가져옴
    CustomerDto customer = (CustomerDto) session.getAttribute("customer");
    if (customer != null) {
%>
    <p>안녕하세요, <%= customer.getCust_name() %> 님!</p>
    <form action="/auth/Login.do" method="get">
        <input type="hidden" name="action" value="logout"/>
        <button type="submit">로그아웃</button>
    </form>
    <a href="/customer/Customer.do?action=mypageEditForm">마이페이지</a>
<%
    } else {
%>
    <p>로그인이 필요합니다.</p>
    <a href="/auth/Login.do">로그인</a>
    <a href="/auth/Auth.do?action=signupform">회원가입</a>
<%
    }
%>

</body>
</html>