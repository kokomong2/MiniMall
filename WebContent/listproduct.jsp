<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product List</title>
</head>
<body>
    <h1>Product List</h1>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Sigun Name</th>
                <th>Division</th>
                <th>Enterprise Name</th>
                <th>Product Name</th>
                <th>Tele</th>
            </tr>
        </thead>
        <tbody>
            <!-- 각 제품 정보 출력 -->
            <c:forEach var="product" items="${productList}">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.sigun_nm}</td>
                    <td>${product.division}</td>
                    <td>${product.entrps_nm}</td>
                    <td>${product.prodlist_nm}</td>
                    <td>${product.telno}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>