<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>회원 정보 입력 폼</h1>
<form action="/auth/Auth.do" method="post">
<fieldset>
<legend>회원정보</legend>
<table>
<tr>
<td class="label">아이디</td>
<td class="field"><input type="text" name="cust_name"></td>
</tr>
<tr>
<td class="label">비밀번호</td>
<td class="field"><input type="password" name="cust_password"></td>
</tr>
<tr>
<td class="label">이메일</td>
<td class="field"><input type="email" name="cust_email"></td>
</tr>
<tr>
<td class="label">전화번호</td>
<td class="field"><input type="text" name="cust_phone_num"></td>
</tr>
<tr>
<td class="label">주소</td>
<td class="field"><textarea name="cust_address" rows="4" cols="50"></textarea></td>
</tr>
</table>
<input type="submit" value=" 저 장 ">
<input type="reset" value=" 취 소 ">
</fieldset>
</form>
</body>
</html>