<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            width: 100%;
            max-width: 400px;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .login-container h1 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 1.5rem;
        }

        .login-container label {
            display: block;
            text-align: left;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            color: #666;
        }

        .login-container input {
            width: 100%;
            padding: 0.8rem;
            margin-bottom: 1.2rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        .login-container button {
            width: 100%;
            padding: 0.8rem;
            font-size: 1rem;
            color: #fff;
            background-color: #2e4631;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-bottom: 1rem;
        }

        .login-container button:hover {
            background-color: #243626;
        }

        .login-container .signup-button {
            width: 100%;
            padding: 0.8rem;
            font-size: 1rem;
            color: #2e4631;
            background-color: #fff;
            border: 1px solid #2e4631;
            border-radius: 4px;
            cursor: pointer;
        }

        .login-container .signup-button:hover {
            background-color: #f3f3f3;
        }

        .login-container .links {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #666;
        }

        .login-container .links a {
            color: #2e4631;
            text-decoration: none;
            margin: 0 0.5rem;
        }

        .login-container .links a:hover {
            text-decoration: underline;
        }
        
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/header.jsp" />	

	<!-- 메인 콘텐츠 -->
	<main>
	    <div class="login-container">
	        <h1>로그인</h1>
	        <% String message = (String) request.getAttribute("message");
            	if (message != null) { %>
           		<p class="error-message"><%= message %></p>
        	<% } %>
	        <form action="/auth/Auth.do?action=login" method="post">
	            <label for="cust_email">이메일</label>
	            <input type="email" name="cust_email" id="cust_email" placeholder="이메일" required>
	
	            <label for="cust_password">비밀번호</label>
	            <input type="password" name="cust_password" id="cust_password" placeholder="비밀번호" required>
	
	            <button type="submit">로그인</button>
	        </form>
	
	        <button class="signup-button" onclick="location.href='/auth/Auth.do?action=signupform'">회원가입</button>
	
	        <div class="links">
	            <a href="#">비밀번호 찾기</a>
	        </div>
	    </div>
    </main>
    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>
