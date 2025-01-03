<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dailybestsell.css">

<div class="products-container">
    <c:forEach var="product" items="${topSellingProducts}">
        <a href="/product-detail?productId=${product.prodId}" class="product-item">
            <img src="${product.prodImageUrl}" alt="${product.prodGoodsName}">
            <h3>${product.prodGoodsName}</h3>
            <div class="price"> ${product.prodSalePrice}원</div>
            <p>판매 수량 : ${product.total_quantity}</p>
        </a>
    </c:forEach>
</div> 


