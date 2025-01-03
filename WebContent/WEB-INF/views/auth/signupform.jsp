<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Daum API 스크립트 -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- 로컬 스크립트 불러오기 -->
<script src="/js/daumPostcode.js"></script>
<script src="/js/checkEmail.js"></script>
<script src="/js/validateForm.js"></script>
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	display: flex;
	flex-direction: column;
}

header, footer {
	flex-shrink: 0;
	color: white;
	text-align: center;
	padding: 1rem;
}

main {
	display: flex;
	justify-content: center;
	align-items: center;
}

.container {
	width: 100%;
	max-width: 620px;
}

.field {
	margin-bottom: 10px;
}

.signup-container {
	background-color: white;
	padding: 20px;
	border-radius: 12px; /* 뽀죡한 모서리 없애기!!! */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 외곽 그림자 추가!!! */
	transition: box-shadow 0.3s ease; /* 부드러운 그림자 변화 */
}

.signup-container:hover {
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 더 강조!!! */
}

h1 {
	font-size: 1.8rem;
	margin-bottom: 20px;
	color: #333;
	text-align: center;
}

.label {
	display: block;
	font-size: 0.85rem;
	margin-bottom: 0.5rem;
	color: #666;
}

.signup-form input[type="text"], .signup-form input[type="password"] {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
	font-size: 14px;
}

.email-field, .postcode-field {
	display: flex;
	align-items: center;
}

.email-field input[type="text"] {
	width: 84%;
	margin-right: 10px;
}

.email-field button, .postcode-field button {
	height: 37px;
	background-color: #2e4631;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.email-field button {
	width: 16%;
}

.postcode-field button {
	width: 22%;
}

.email-field button:hover {
	background-color: #243626;
}

.postcode-field input[type="text"] {
	width: 78%;
	margin-right: 10px;
}

.button-container {
	display: flex;
	justify-content: space-between;
	margin-top: 30px;
}

.signup-btn, .reset-btn {
	width: 100%;
	padding: 0.8rem;
	font-size: 1rem;
	border-radius: 4px;
	cursor: pointer;
}

.signup-btn {
	color: #fff;
	background-color: #2e4631;
	border: none;
	margin-right: 10px;
}

.signup-btn:hover {
	background-color: #243626;
}

.reset-btn {
	background-color: #fff;
	border: 1px solid #2e4631;
	color: #2e4631;
}

.reset-btn:hover {
	background-color: #f3f3f3;
}

a {
	text-decoration: none;
	color: inherit;
}

span {
	font-size: 11px;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" />

	<main>
		<div class="container">
		<br><br>
			<div class="signup-container">
				<h1>회원가입</h1>
				<form action="/auth/Auth.do?action=signup" method="post"
					class="signup-form">
					<div class="field">
						<label class="label" for="cust_name">이름</label> <input type="text"
							id="cust_name" name="cust_name" placeholder="이름을 입력해주세요"
							value="${member.cust_name}">
					</div>
					<div class="field">
						<label class="label" for="cust_email">이메일</label>
						<div class="email-field">
							<input type="text" id="cust_email" name="cust_email"
								placeholder="이메일을 입력해주세요" value="${member.cust_email}">
							<button type="button" onclick="checkEmail()">중복확인</button>
						</div>
						<span id="emailCheckResult"></span>
					</div>
					<div class="field">
						<label class="label" for="cust_password">비밀번호</label> <input
							type="password" id="cust_password" name="cust_password"
							placeholder="비밀번호를 입력해주세요" value="${member.cust_password}">
					</div>
					<div class="field">
						<label class="label" for="cust_confirm_password">비밀번호 확인</label> <input
							type="password" id="cust_confirm_password"
							name="cust_confirm_password" placeholder="비밀번호를 재입력해주세요">
					</div>
					<div class="field">
						<label class="label" for="cust_phone_num">연락처</label> <input
							type="text" id="cust_phone_num" name="cust_phone_num"
							placeholder="-을 포함하여 연락처를 입력해주세요"
							value="${member.cust_phone_num}">
					</div>
					<div class="field">
						<div class="field">
							<label class="label" for="sample6_postcode">우편번호</label>
							<div class="postcode-field">
								<input type="text" id="sample6_postcode" name="cust_postcode"
									size="50" placeholder="우편번호를 입력해주세요">
								<button type="button" onclick="sample6_execDaumPostcode()">우편번호
									찾기</button>
							</div>
						</div>
						<div class="field">
							<label class="label" for="sample6_address">주소</label> <input
								type="text" id="sample6_address" name="cust_address" size="50"
								placeholder="주소를 입력해주세요">
						</div>
						<div class="field">
							<label class="label" for="sample6_detailAddress">상세주소</label> <input
								type="text" id="sample6_detailAddress"
								name="cust_detail_address" placeholder="상세주소를 입력해주세요">
						</div>

						<div class="button-container">
							<input type="hidden" name="action" value="signupform">
							<button type="submit" class="signup-btn">회원가입</button>
							<button type="button" class="reset-btn">
								<a href="http://localhost:8080/auth/Auth.do?action=loginform">로그인</a>
							</button>
						</div>
						</a>
				</form>
			</div>
		</div>
		<br><br><br>
	</main>

	<jsp:include page="/WEB-INF/successModalForward.jsp" />
	<jsp:include page="/WEB-INF/views/footer.jsp" />
	</div>
</body>
</html>
