<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .products-container {
        display: grid; /* 그리드 레이아웃 적용 */
        grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); /* 가로 배치 */
        gap: 1.5rem; /* 아이템 간 간격 */
        justify-items: center; /* 아이템 가운데 정렬 */
        margin-bottom: 2rem;
    }

    .product-item {
        text-align: center;
        padding: 1rem;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s, background-color 0.3s;
        width: 150px; /* 각 아이템의 고정 너비 */
    }

    .product-item img {
        width: 100px;
        height: 100px;
        margin-bottom: 0.5rem;
    }

    .product-item h3 {
        font-size: 1rem;
        color: #333;
        margin-bottom: 0.5rem;
    }

    .product-item .price {
        font-size: 1.1rem;
        font-weight: bold;
        color: #007bff;
    }

    .product-item:hover {
        transform: translateY(-5px);
        background-color: #f1f1f1;
    }
</style>


<div class="products-container">
    <a href="/product-detail?productId=1" class="product-item">
        <img src="https://via.placeholder.com/100" alt="Apple">
        <h3>Apple</h3>
        <div class="price">$13.00</div>
    </a>
    <a href="/product-detail?productId=2" class="product-item">
        <img src="https://via.placeholder.com/100" alt="Kiwi">
        <h3>Kiwi</h3>
        <div class="price">$9.00</div>
    </a>
    <a href="/product-detail?productId=3" class="product-item">
        <img src="https://via.placeholder.com/100" alt="Banana">
        <h3>Banana</h3>
        <div class="price">$12.00</div>
    </a>
    <a href="/product-detail?productId=4" class="product-item">
        <img src="https://via.placeholder.com/100" alt="Tomato">
        <h3>Tomato</h3>
        <div class="price">$10.00</div>
    </a>
    <a href="/product-detail?productId=5" class="product-item">
        <img src="https://via.placeholder.com/100" alt="Milk">
        <h3>Milk</h3>
        <div class="price">$5.00</div>
    </a>
</div>