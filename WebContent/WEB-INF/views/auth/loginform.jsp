<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userid = (String) session.getAttribute("userid");
	if (userid == null) {
	%>
	<h1>로그인 폼</h1>
	<form action="/auth/Login.do" method="post">
		아이디 : <input type="text" name="userid"><br> 비밀번호 : <input
			type="password" name="password"><br> <input
			type="submit" value=" 로그인 "> <input type="reset"
			value=" 취 소 ">
	</form>
	<p>
		아이디가 없으신 분은 <a href="/auth/Auth.do">회원가입</a>하신 후 로그인 하세요.
		<%
		} else {
	out.println("<h1>마이페이지</h1>");
	out.println(userid + "님 로그인 중");
	}
	%>
	
</body>
</html>