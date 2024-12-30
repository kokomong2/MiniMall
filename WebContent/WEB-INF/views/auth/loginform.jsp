<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/auth/Auth.do?action=login" method="post">
    <label for="cust_email">Email:</label>
    <input type="email" name="cust_email" required><br>
    <label for="cust_password">Password:</label>
    <input type="password" name="cust_password" required><br>
    <button type="submit">Login</button>
</form>
</body>
</html>