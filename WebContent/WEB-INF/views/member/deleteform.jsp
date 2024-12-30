<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 삭제</title>
</head>
<body>
<h1>회원정보 삭제(회원 탈퇴)</h1>
<h3>${userid}님의 비밀번호를 입력하세요.</h3>
<form action="/member/Member.do" method="post">
비밀번호: <input type="password" name="password">
<input type="hidden" name="action" value="delete">
<input type="submit" value=" 삭제 ">
</form>
</body>
</html>