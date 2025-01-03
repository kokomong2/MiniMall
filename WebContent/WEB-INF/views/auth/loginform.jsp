<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
	max-width: 450px;
}

.field {
	margin-bottom: 10px;
}

.login-container {
	background-color: white;
	padding: 20px;
	border-radius: 12px; /* 뽀죡한 모서리 제거!!! */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 외곽 그림자 추가!!! */
	transition: box-shadow 0.3s ease; /* 부드러운 효과 */
}

.login-container:hover {
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* 호버 시 그림자 강조!!! */
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

.login-form input[type="email"], .login-form input[type="password"] {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
	font-size: 14px;
}

.button-container {
	margin-top: 30px;
}

.login-button, .signup-button {
	width: 100%;
	padding: 0.8rem;
	font-size: 1rem;
	border-radius: 4px;
	cursor: pointer;
}

.login-button {
	color: #fff;
	background-color: #2e4631;
	border: none;
	margin-bottom: 0.8rem;
}

.login-button:hover {
	background-color: #243626;
}

.signup-button {
	color: #2e4631;
	background-color: #fff;
	border: 1px solid #2e4631;
}

.signup-button:hover {
	background-color: #f3f3f3;
}

.login-container .links {
	margin-top: 1rem;
	font-size: 0.9rem;
	color: #666;
	text-align: center;
}

.login-container .links a {
	color: #2e4631;
	text-decoration: none;
	margin: 0 0.5rem;
}

.login-container .links a:hover {
	color: #243626;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/header.jsp" />

	<main>
		<div class="container">
	<br><br><br><br><br>
			<div class="login-container">
				<h1>로그인</h1>
				<form action="/auth/Auth.do?action=login" method="post"
					class="login-form">
					<div class="field">
						<label class="label" for="cust_email">이메일</label> <input
							type="email" id="cust_email" name="cust_email" placeholder="이메일"
							required>
					</div>
					<div class="field">
						<label class="label" for="cust_password">비밀번호</label> <input
							type="password" id="cust_password" name="cust_password"
							placeholder="비밀번호" required>
					</div>

					<div class="button-container">
						<button type="submit" class="login-button">로그인</button>
						<button class="signup-button"
							onclick="location.href='/auth/Auth.do?action=signupform'">회원가입</button>
					</div>

					<div class="links">
						<a href="#">비밀번호 찾기</a>
					</div>
				</form>
			</div>
		<br><br><br><br><br>
		</div>
	</main>

	<jsp:include page="/WEB-INF/views/footer.jsp" />
	<jsp:include page="/WEB-INF/failModalForward.jsp" />
</body>
</html>