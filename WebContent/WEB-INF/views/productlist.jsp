<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            text-align: center;
            margin-bottom: 20px;
        }

        form input[type="text"] {
            padding: 10px;
            font-size: 14px;
            width: 300px;
            margin-right: 10px;
        }

        form select {
            padding: 10px;
            font-size: 14px;
            margin-right: 10px;
        }

        form button {
            padding: 10px 20px;
            font-size: 14px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px 15px;
            text-align: center;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        img {
            max-width: 100px;
            height: auto;
            border-radius: 4px;
        }

        .no-image {
            font-size: 12px;
            color: #888;
        }
    </style>
</head>
<body>
    <h1>Product List</h1>

    <!-- 검색 및 카테고리 선택 폼 -->
    <form action="/product/Product.do" method="get">
        <input type="hidden" name="action" value="search">
        <input type="text" name="search_query" placeholder="상품명 또는 설명 검색">
        <button type="submit">검색</button>
    </form>

    <form action="/product/Product.do" method="get">
        <input type="hidden" name="action" value="category">
        <select name="prod_category">
            <option value="">카테고리를 선택하세요</option>
            <option value="채소">채소</option>
            <option value="과일">과일</option>
            <option value="약재">약재</option>
            <option value="조미료">조미료</option>
            <option value="곡물">곡물</option>
            <option value="버섯">버섯</option>
            <option value="기타">기타</option>
        </select>
        <button type="submit">조회</button>
    </form>

    <table border="1">
        <tr>
            <th>Product ID</th>
            <th>Image</th>
            <th>Goods Name</th>
            <th>Brand</th>
            <th>Price</th>
            <th>Category</th>
            <th>Region</th>
            <th>Explanation</th>
        </tr>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>
                    <a href="/product/Product.do?action=detailform&prod_id=${product.prodId}">
                        ${product.prodId}
                    </a>
                </td>
                <td>
                    <c:if test="${not empty product.prodImageUrl}">
                        <img src="${product.prodImageUrl}" alt="${product.prodGoodsName}">
                    </c:if>
                    <c:if test="${empty product.prodImageUrl}">
                        <span class="no-image">No Image</span>
                    </c:if>
                </td>
                <td>${product.prodGoodsName}</td>
                <td>${product.prodBrandName}</td>
                <td>${product.prodSalePrice} ₩</td>
                <td>${product.prodMainCategory} / ${product.prodSubcategory}</td>
                <td>${product.prodRegionName}</td>
                <td>${product.prodExplanation}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
