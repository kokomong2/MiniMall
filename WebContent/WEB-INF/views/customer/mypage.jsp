<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.miniprj.minimall.model.CustomerDto" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding-top: 4rem; /* 헤더 높이 */
            padding-bottom: 4rem; /* 푸터 높이 */
        }

        h1 {
            text-align: center;
            margin: 2rem 0;
            font-size: 2rem;
            font-weight: bold;
            color: #2e2e2e;
        }

        .mypage-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1.5rem;
            width: 80%;
            margin: 0 auto;
            padding: 1rem 0;
        }

        .mypage-item {
            background-color: #ffffff;
            text-align: center;
            padding: 1.5rem;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, background-color 0.3s, box-shadow 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .mypage-item:hover {
            transform: translateY(-5px);
            background-color: #f5f5f5;
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
        }

        .mypage-item img {
            width: 50px;
            height: 50px;
            margin-bottom: 1rem;
        }

        .mypage-item span {
            display: block;
            font-size: 1.1rem;
            font-weight: bold;
            color: #333;
        }

        .mypage-item .count {
            font-weight: bold;
            color: #e74c3c;
        }
    </style>
</head>

<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/header.jsp" />

    <main>
        <h1>마이페이지</h1>
        <div class="mypage-container">
            <a href="/customer/Customer.do?action=mypageEditForm" class="mypage-item">
                <img src="https://via.placeholder.com/50" alt="내 정보 수정">
                <span>내 정보 수정</span>
            </a>
            <a href="/Cart.do?action=list" class="mypage-item">
                <img src="https://via.placeholder.com/50" alt="장바구니">
                <span>장바구니 <span class="count">(5)</span></span>
            </a>
            <a href="#" class="mypage-item">
                <img src="https://via.placeholder.com/50" alt="구매 내역">
                <span>구매 내역 <span class="count">(2)</span></span>
            </a>
            <a href="#" class="mypage-item">
                <img src="https://via.placeholder.com/50" alt="리뷰">
                <span>리뷰 작성</span>
            </a>
            <a href="/auth/Auth.do?action=logout" class="mypage-item">
                <img src="https://via.placeholder.com/50" alt="로그아웃">
                <span>로그아웃</span>
            </a>
            <a href="#" class="mypage-item">
                <img src="https://via.placeholder.com/50" alt="회원탈퇴">
                <span>회원탈퇴</span>
            </a>
        </div>
    </main>

    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />
    
</body>
</html>
