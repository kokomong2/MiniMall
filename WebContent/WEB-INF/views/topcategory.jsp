<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .category-container {
        display: flex; /* 가로 정렬 */
        justify-content: space-around; /* 아이템 간격 균등 */
        align-items: center; /* 수직 가운데 정렬 */
        margin-bottom: 2rem;
    }

    .category-item {
        text-align: center;
        padding: 1rem;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 8px;
        transition: transform 0.3s, background-color 0.3s;
        width: 120px; /* 각 아이템의 고정 너비 */
        cursor: pointer;
    }

    .category-item img {
        width: 50px;
        height: 50px;
        margin-bottom: 0.5rem;
    }

    .category-item:hover {
        transform: translateY(-5px);
        background-color: #f1f1f1;
    }

    .category-item span {
        font-size: 1rem;
        color: #333;
    }
</style>


<div class="category-container">
    <div class="category-item" onclick="location.href='http://localhost:8080/product/Product.do?action=list'">
        <img src="https://via.placeholder.com/50" alt="전체">
        <span>전체</span>
    </div>
    <div class="category-item" onclick="location.href='/category?type=fruits'">
        <img src="https://via.placeholder.com/50" alt="곡물">
        <span>곡물</span>
    </div>
    <div class="category-item" onclick="location.href='/category?type=vegetables'">
        <img src="https://via.placeholder.com/50" alt="과일">
        <span>과일</span>
    </div>
    <div class="category-item" onclick="location.href='/category?type=meat'">
        <img src="https://via.placeholder.com/50" alt="버섯">
        <span>버섯</span>
    </div>
    <div class="category-item" onclick="location.href='/category?type=snacks'">
        <img src="https://via.placeholder.com/50" alt="약재">
        <span>약재</span>
    </div>
    <div class="category-item" onclick="location.href='/category?type=milk'">
        <img src="https://via.placeholder.com/50" alt="조미료">
        <span>조미료</span>
    </div>
        <div class="category-item" onclick="location.href='/category?type=milk'">
        <img src="https://via.placeholder.com/50" alt="채소">
        <span>채소</span>
    </div>
    <div class="category-item" onclick="location.href='/category?type=milk'">
        <img src="https://via.placeholder.com/50" alt="기타">
        <span>기타</span>
    </div>
</div>
