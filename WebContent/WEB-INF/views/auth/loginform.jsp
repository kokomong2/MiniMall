<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }

        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .login-btn,
        .signup-btn {
            width: 100%;
            padding: 10px;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }

        .login-btn {
            background-color: #2c3e50;
        }

        .login-btn:hover {
            background-color: #1a242f;
        }

        .signup-btn {
            background-color: #5a9367;
            margin-top: 5px;
        }

        .signup-btn:hover {
            background-color: #467251;
        }

        .login-links {
            margin-top: 15px;
            font-size: 14px;
            color: #666;
        }

        .login-links a {
            color: #2c3e50;
            text-decoration: none;
            margin: 0 5px;
        }

        .login-links a:hover {
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
<div class="container">
	<div class="login-container">
        <h1>로그인</h1>
        <% String message = (String) request.getAttribute("message");
           if (message != null) { %>
           <p class="error-message"><%= message %></p>
        <% } %>
        <form action="/auth/Login.do" method="post" class="login-form">
            <input type="text" name="cust_email" placeholder="이메일">
            <input type="password" name="cust_password" placeholder="비밀번호">
            <input type="hidden" name="action" value="login">
            <button type="submit" class="login-btn">로그인</button>
        </form>
        <form action="/auth/Auth.do" method="get">
            <input type="hidden" name="action" value="signupform">
            <button type="submit" class="signup-btn">회원가입</button>
        </form>
        <div class="login-links">
            <a href="/find-password">비밀번호 찾기</a> | 
            <a href="/guest-order">비회원 주문 조회</a>
        </div>
    </div>
</div> 
</body>
</html>
