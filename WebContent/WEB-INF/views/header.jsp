<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.miniprj.minimall.model.CustomerDto" %>
<header class="header">
    <a href="/" class="logo">농산물 마켓</a>
    <nav class="nav-links">
        <a href="/">Home</a>
        <a href="#">Features</a>
        <a href="#">Pricing</a>
        <a href="#">FAQs</a>
        <a href="#">About</a>
    </nav>
    <div class="auth-buttons">
        <%
            // 세션에서 사용자 정보를 가져옴
            CustomerDto customer = (CustomerDto) session.getAttribute("customer");
            if (customer != null) {
        %>
            <span>안녕하세요, <%= customer.getCust_name() %> 님!</span>
            <a href="/auth/Auth.do?action=logout" class="logout">로그아웃</a>            
            <a href="/customer/Customer.do?action=mypage" class="mypage">마이페이지</a>
            <a href="/customer/Customer.do?action=mypageEditForm" class="mypageEdit">내 정보 수정</a>
            <a href="/cart/Cart.do?action=list" class="cart">장바구니</a>
        <%
            } else {
        %>
            <a href="/auth/Auth.do?action=loginform" class="login">로그인</a>
            <a href="/auth/Auth.do?action=signupform" class="signup">회원가입</a>
        <%
            }
        %>
    </div>
</header>

<style>
    /* 헤더 스타일 */
    .header {
        position: fixed; /* 화면 상단 고정 */
        top: 0; /* 화면 위쪽에 위치 */
        left: 0; /* 왼쪽 여백 없음 */
        width: 100%; /* 화면 전체 너비 */
        background-color: #fff; /* 흰색 배경 */
        border-bottom: 1px solid #eaeaea; /* 아래쪽 테두리 */
        z-index: 1000; /* 최상위 레이어 */
        padding: 1rem 2rem; /* 패딩 */
        display: flex; /* 내부 요소 정렬 */
        justify-content: space-between; /* 좌우 정렬 */
        align-items: center; /* 세로 정렬 */
    }

    .logo {
        font-size: 1.5rem;
        font-weight: bold;
        color: #333;
        text-decoration: none;
    }

    .nav-links {
        display: flex;
        gap: 1rem; /* 링크 사이 간격 */
    }

    .nav-links a {
        text-decoration: none;
        font-size: 1rem;
        color: #333;
        transition: color 0.3s;
    }

    .nav-links a:hover {
        color: #007bff;
    }

    .auth-buttons {
        display: flex;
        gap: 1rem; /* 버튼 사이 간격 */
        align-items: center;
    }

    .auth-buttons a {
        text-decoration: none;
        padding: 0.5rem 1rem;
        border-radius: 5px;
        font-size: 0.9rem;
        text-align: center;
        transition: background-color 0.3s, color 0.3s;
    }

    .auth-buttons .login {
        color: #007bff;
        border: 1px solid #007bff;
        background-color: #fff;
    }

    .auth-buttons .login:hover {
        background-color: #007bff;
        color: #fff;
    }

    .auth-buttons .signup {
        color: #fff;
        background-color: #007bff;
    }

    .auth-buttons .signup:hover {
        background-color: #0056b3;
    }

    .auth-buttons .cart {
        color: #333;
        font-size: 0.9rem;
        text-decoration: none;
    }

    .auth-buttons .cart:hover {
        text-decoration: underline;
    }
    
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding-top: 4rem; /* 헤더 높이만큼 여백 */
        background-color: #f9f9f9;
    }
</style>
