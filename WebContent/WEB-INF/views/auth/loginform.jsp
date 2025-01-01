<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
<h1>로그인 폼</h1>
<% String message = (String) request.getAttribute("message");
   if (message != null) { %>
   <p style="color:red;"><%= message %></p>
<% } %>
<form action="/auth/Login.do" method="post">
이메일: <input type="text" name="cust_email"><br>
비밀번호: <input type="password" name="cust_password"><br>
<input type="hidden" name="action" value="login">
<input type="submit" value="로그인">
<input type="reset" value="취  소"><br>
</form> 
</body>
</html>