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
<%
    // 세션에서 사용자 정보를 가져옴
    CustomerDto customer = (CustomerDto) session.getAttribute("customer");
    if (customer != null) {
%>
<h1> ೃ⁀➷ ʚ♡ɞ <%= customer.getCust_name() %> 정보 수정  ʚ♡ɞ  ೃ⁀➷ </h1>

<%= customer.getCust_name() %>
<%= customer.getCust_email() %>
<%= customer.getCust_phone_num() %>
<%= customer.getCust_address() %>


<%
    } 
%>




</body>
</html>