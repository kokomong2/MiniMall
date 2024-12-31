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
                <td>${product.prodId}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty product.prodImageUrl}">
                            <img src="${product.prodImageUrl}" alt="Product Image">
                        </c:when>
                        <c:otherwise>
                            <div class="no-image">No Image</div>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${product.prodGoodsName}</td>
                <td>${product.prodBrandName}</td>
                <td>${product.prodSalePrice} ₩</td>
                <td>${product.prodSubcategory} / ${product.prodMainCategory}</td>
                <td>${product.prodRegionName}</td>
                <td>${product.prodExplanation}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
