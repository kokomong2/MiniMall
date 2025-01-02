<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/daumPostcode.js"></script>
<script src="/js/checkEmail.js"></script>
<script src="/js/validateForm.js"></script>
<style>
	body {
        font-family: 'Arial', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .signup-container {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
    }

    h1 {
        font-size: 24px;
        margin-bottom: 20px;
        color: #333;
        text-align: center;
    }
    
    .label {
        display: block;
        font-size: 13px;
    }
    
    .signup-form input[type="text"],
    .signup-form input[type="password"] {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
    }
    
    .email-field, .postcode-field{
        display: flex;
        align-items: center;
    }
    
    .email-field input[type="text"] {
        width: 84%; 
        margin-right: 10px; 
    }
    
    .email-field button {
        width: 16%; 
        height: 37px;
    }

    .postcode-field input[type="text"] {
        width: 78%; 
        margin-right: 10px; 
    }
    
    .postcode-field button {
        width: 22%; 
        height: 37px;
    }
    
    .signup-btn {
            background-color: #2c3e50;
            width: 100%;
            padding: 10px;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }

        .signup-btn:hover {
            background-color: #1a242f;
        }
    
</style>
</head>
<body>
<div class="container">
    <div class="signup-container">
        <h1>회원가입</h1>
        <form action="/auth/Auth.do" method="post" class="signup-form">
        	<div class="field">
        		<label class="label" for="cust_name">이름</label>
                <input type="text" id="cust_name" name="cust_name" placeholder="이름을 입력해주세요" value="${member.cust_name}">
           </div>
           <div class="field">
                <label class="label" for="cust_email">이메일</label>
                <div class="email-field">
                	<input type="text" id="cust_email" name="cust_email" placeholder="이메일을 입력해주세요" value="${member.cust_email}">
                	<button type="button" onclick="checkEmail()">중복확인</button>
                </div>
                <span id="emailCheckResult"></span>
            </div>
            <div class="field">
                <label class="label" for="cust_password">비밀번호</label>
                <input type="password" id="cust_password" name="cust_password" placeholder="비밀번호를 입력해주세요" value="${member.cust_password}">
            </div>
            <div class="field">
                <label class="label" for="cust_confirm_password">비밀번호 확인</label>
                <input type="password" id="cust_confirm_password" name="cust_confirm_password" placeholder="비밀번호를 재입력해주세요">
            </div>
            <div class="field">
                <label class="label" for="cust_phone_num">연락처</label>
                <input type="text" id="cust_phone_num" name="cust_phone_num" placeholder="-을 포함하여 연락처를 입력해주세요" value="${member.cust_phone_num}">
            </div>
            <div class="field">
                <label class="label" for="sample6_postcode">우편번호</label>
                <div class="postcode-field">
                	<input type="text" id="sample6_postcode" name="cust_postcode" size="50">
                	<button type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
                </div>
            </div>
            <div class="field">
                <label class="label" for="sample6_address">주소</label>
                <input type="text" id="sample6_address" name="cust_address" size="50">
            </div>
            <div class="field">
                <label class="label" for="sample6_detailAddress">상세주소</label>
                <input type="text" id="sample6_detailAddress" name="cust_detail_address" placeholder="상세주소를 입력해주세요">
            </div>
            <input type="hidden" name="action" value="signup">
            <button type="submit" class="signup-btn">회원가입</button>
        </form>
    </div>
</div>
</body>
</html>
