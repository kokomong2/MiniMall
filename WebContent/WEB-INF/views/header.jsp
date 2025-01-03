<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.miniprj.minimall.model.CustomerDto"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
<header class="header">
<a href="/" class="logo">
    <img src="https://i.ibb.co/rGCdyP7/Kakao-Talk-20250103-140255585.png" alt="Kakao-Talk-20250103-140255585" border="0" class="logo-image">
</a>


   <nav class="nav-links">
      <a href="/">Home</a> <a href="#">Features</a> <a href="#">Pricing</a>
      <a href="#">FAQs</a> <a href="#">About</a>
   </nav>
   <div class="auth-buttons">
      <%
            // 세션에서 사용자 정보를 가져옴
            CustomerDto customer = (CustomerDto) session.getAttribute("customer");
            if (customer != null) {
        %>
      <span>안녕하세요, <%= customer.getCust_name() %> 님!
      </span> <a href="/auth/Auth.do?action=logout" class="logout">로그아웃</a> <a
         href="/customer/Customer.do?action=mypage" class="mypage">마이페이지</a> <a
         href="/customer/Customer.do?action=mypageEditForm" class="mypageEdit">내
         정보 수정</a> <a href="/cart/Cart.do?action=list" class="cart">장바구니</a>
      <%
            } else {
        %>
      <a href="/auth/Auth.do?action=loginform" class="login">로그인</a> <a
         href="/auth/Auth.do?action=signupform" class="signup">회원가입</a>
      <%
            }
        %>
   </div>
</header>
