<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/daumPostcode.js"></script>
<script src="/js/checkEmail.js"></script>
<script src="/js/validateForm.js"></script>
</head>
<body>
<h1>회원가입</h1>
<form action="/auth/Auth.do" method="post">
<fieldset>
<legend>회원정보</legend>
<table>
<tr>
	<td class="label">이름</td>
	<td class="field"><input type="text" name="cust_name" value="${member.cust_name}"></td>
</tr>
<tr>
	<td class="label">이메일</td>
	<td class="field"><input type="text" id="cust_email" name="cust_email" value="${member.cust_email}">
	<button type="button" onclick="checkEmail()">중복확인</button>
	<span id="emailCheckResult"></span></td>
</tr>
<tr>
	<td class="label">비밀번호</td>
	<td class="field"><input type="password" name="cust_password" value="${member.cust_password}"></td>
</tr>
<tr>
	<td class="label">비밀번호 확인</td>
	<td class="field"><input type="password" name="cust_confirm_password"></td>
</tr>
<tr>
	<td class="label">연락처</td>
	<td class="field"><input type="text" name="cust_phone_num" size="50" value="${member.cust_phone_num}"></td>
</tr>
<tr>
	<td class="label">우편번호</td>
	<td class="field"><input type="text" id="sample6_postcode" name="cust_postcode" size="50" >
	<button type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button></td>
</tr>
<tr>
	<td class="label">주소</td>
	<td class="field"><input type="text" id="sample6_address" name="cust_address" size="50"></td>
</tr>
<tr>
	<td class="label">상세주소</td>
	<td class="field"><input type="text" id="sample6_detailAddress" name="cust_detail_address" size="50"></td>
</tr>
</table>
	<input type="hidden" name="action" value="signup">
	<input type="submit" value="  저 장  "> 
	<input type="reset" value="  취  소  ">
</fieldset>
</form>
</body>
</html>
