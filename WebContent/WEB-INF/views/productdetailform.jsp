<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .product-detail {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .product-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .product-header img {
            max-width: 200px;
            height: auto;
            border-radius: 5px;
        }
        .product-info {
            padding: 20px;
        }
        .product-info table {
            width: 100%;
            border-collapse: collapse;
        }
        .product-info th, .product-info td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .product-info th {
            background-color: #f2f2f2;
            width: 30%;
        }
    </style>
</head>
<body>
    <div class="product-detail">
        <div class="product-header">
            <img src="${product.prodImageUrl}" alt="${product.prodGoodsName}">
            <h1>${product.prodGoodsName}</h1>
        </div>
        <div class="product-info">
            <table>
                <tr>
                    <th>Product ID</th>
                    <td>${product.prodId}</td>
                </tr>
                <tr>
                    <th>Brand</th>
                    <td>${product.prodBrandName}</td>
                </tr>
                <tr>
                    <th>Price</th>
                    <td>${product.prodSalePrice} ₩</td>
                </tr>
                <tr>
                    <th>Category</th>
                    <td>${product.prodMainCategory} / ${product.prodSubcategory}</td>
                </tr>
                <tr>
                    <th>Region</th>
                    <td>${product.prodRegionName}</td>
                </tr>
                <tr>
                    <th>Weight</th>
                    <td>${product.prodSaleWeight} ${product.prodWeightUnit}</td>
                </tr>
                <tr>
                    <th>Explanation</th>
                    <td>${product.prodExplanation}</td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
