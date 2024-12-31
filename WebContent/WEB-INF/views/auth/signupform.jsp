<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Daum API 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 로컬 스크립트 불러오기 -->
<script src="/js/daumPostcode.js"></script>
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
			 <td class="field">
				<input type="text" id="sample6_postcode" name="cust_postcode" placeholder="우편번호">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="sample6_address" name="cust_address" placeholder="주소">
				<input type="text" id="sample6_detailAddress" name="cust_detail_address" placeholder="상세주소">
			 </td>
		 </tr>
		 
	 </table>
	<input type="submit" value="  저 장  "> 
	<input type="reset" value="  취  소  ">
	</fieldset>
</form>
</body>
</html>