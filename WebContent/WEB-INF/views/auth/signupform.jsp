<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>회원가입 폼</h1>
<form action="/auth/Auth.do?action=signup" method="post">
	<fieldset>
	<legend>회원정보</legend>
	<table>
		 <tr>
			 <td class="label" for="cust_name">이 름</td>
			 <td class="field"><input type="text" name="cust_name"></td>
		 </tr>
		 <tr>
			 <td class="label" for="cust_email">이 메 일</td>
			 <td class="field"><input type="email" name="cust_email"></td>
		 </tr>
		 <tr>
			 <td class="label" for="cust_password">비 밀 번 호</td>
			 <td class="field"><input type="password" name="cust_password"></td>
		 </tr>
		 <tr>
			 <td class="label" for="passwordCheck">비 밀 번 호 확 인</td>
			 <td class="field"><input type="password" name="passwordCheck"></td>
		 </tr>
		 <tr>
			 <td class="label" for="cust_phone_num">연 락 처</td>
			 <td class="field"><input type="text" name="cust_phone_num"></td>
		 </tr>
		 <tr>
			 <td class="label" for="cust_address">주 소</td>
			 <td class="field"><input type="text" name="cust_address" size="50"></td>
		 </tr>
	 </table>
	<input type="submit" value="  저 장  "> 
	<input type="reset" value="  취  소  ">
	</fieldset>
</form>
</body>
</html>