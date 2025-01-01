<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OK</title>
</head>
<body>
<h1>로그인 성공</h1>
<p>환영합니다, <%= session.getAttribute("cust_email") %>님!</p>
<a href="/auth/Login.do?action=loginform">로그아웃</a>
</body>
</html>