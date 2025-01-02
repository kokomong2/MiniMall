<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="footer">
    <div class="footer-content">
        <span>&copy; 2022 Company, Inc</span>
        <a href="#" class="logo">
            <img src="https://via.placeholder.com/20" alt="Logo">
        </a>
        <nav class="footer-nav">
            <a href="#">Home</a>
            <a href="#">Features</a>
            <a href="#">Pricing</a>
            <a href="#">FAQs</a>
            <a href="#">About</a>
        </nav>
    </div>
</footer>

<style>
    .footer {
        position: fixed; /* 화면 하단 고정 */
        bottom: 0; /* 하단 여백 없음 */
        left: 0; /* 왼쪽 여백 없음 */
        width: 100%; /* 화면 전체 너비 */
        background-color: #fff; /* 배경색 */
        border-top: 1px solid #eaeaea; /* 위쪽 테두리 */
        z-index: 1000; /* 최상위 레이어 */
        padding: 1rem 2rem; /* 내부 여백 */
        display: flex; /* 내부 요소 정렬 */
        justify-content: center; /* 중앙 정렬 */
        align-items: center; /* 수직 정렬 */
    }

    .footer-content {
        width: 100%;
        max-width: 1200px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
    }

    .footer-content span {
        font-size: 0.9rem;
        color: #666;
    }

    .footer-content .logo img {
        width: 20px;
        height: 20px;
    }

    .footer-nav {
        display: flex;
        gap: 1rem; /* 링크 간 간격 */
    }

    .footer-nav a {
        text-decoration: none;
        font-size: 0.9rem;
        color: #666;
        transition: color 0.3s;
    }

    .footer-nav a:hover {
        color: #007bff;
    }
</style>
