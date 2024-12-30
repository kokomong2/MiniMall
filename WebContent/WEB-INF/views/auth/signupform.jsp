<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<td class="label">이름</td>
	<td class="field"><input type="text" name="cust_name" value="${member.cust_name}"></td>
</tr>
<tr>
	<td class="label">비밀번호</td>
	<td class="field"><input type="password" name="cust_password" value="${member.cust_password}"></td>
</tr>
<tr>
	<td class="label">이메일</td>
	<td class="field"><input type="text" name="cust_email" value="${member.cust_email}"></td>
</tr>
<tr>
	<td class="label">연락처</td>
	<td class="field"><input type="text" name="cust_phone_num" size="50" value="${member.cust_phone_num}"></td>
</tr>
<tr>
	<td class="label">주소</td>
	<td class="field"><input type="text" name="cust_address" size="50" value="${member.cust_address}"></td>
</tr>
</table>
	<input type="hidden" name="action" value="${action}">
	<input type="submit" value="  저 장  "> 
	<input type="reset" value="  취  소  ">
</fieldset>
</form>
</body>
</html>