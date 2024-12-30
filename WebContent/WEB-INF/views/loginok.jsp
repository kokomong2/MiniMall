<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OK</title>
</head>
<body>
<h1>로그인 성공</h1>
<%= session.getAttribute("userid") %>님 로그인 함 <br>
<%= request.getAttribute("message") %>
</body>
</html>