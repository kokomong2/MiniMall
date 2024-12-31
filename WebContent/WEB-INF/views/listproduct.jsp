<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product List</title>
</head>
<body>
    <h1>Product List</h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Category</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Local</th>
                <th>Info</th>
                <th>Image</th>
                <th>Cart</th>
            </tr>
        </thead>
        <tbody>
            <!-- 각 제품 정보 출력 -->
            <c:forEach var="product" items="${productList}">
                <tr>
                    <td>${product.prodId}</td>
                    <td>${product.prodCategory}</td>
                    <td>${product.prodName}</td>
                    <td>${product.prodPrice}</td>
                    <td>${product.prodStock}</td>
                    <td>${product.prodLocal}</td>
                    <td>${product.prodInfo}</td> 
                    <td><img src="${product.prodImg}" alt="Product Image" width="100" height="100" /></td>
                    <td>
                        
                        <!-- 장바구니 버튼 -->
                        <form method="post" action="/Cart.do">
						    <input type="hidden" name="productId" value="${product.prodId}" />
						    <input type="hidden" name="action" value="addToCart" />
						    <button type="submit">Add to Cart</button>
						</form>
                        
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
