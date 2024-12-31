<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %> <!-- List import -->
<%@ page import="com.miniprj.minimall.model.ProductDto" %> <!-- ProductDto import -->
<!DOCTYPE html>
<html>
<head>
    <title>Gyeonggi Food Data</title>
</head>
<body>
    <h1>Gyeonggi Food Data</h1>
    
    <!-- 테이블 헤더 -->
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>시군명</th>
                <th>구분</th>
                <th>업체명</th>
                <th>품목명</th>
                <th>전화번호</th>
            </tr>
        </thead>
        <tbody>
            <!-- productList를 순회하여 데이터를 출력 -->
            <%
                List<ProductDto> productList = (List<ProductDto>) request.getAttribute("productList");
                for (ProductDto product : productList) {
            %>
                <tr>
                    <td><%= product.getId() %></td>
                    <td><%= product.getSigunNm() %></td>
                    <td><%= product.getDiv() %></td>
                    <td><%= product.getEntrpsNm() %></td>
                    <td><%= product.getProdlstNm() %></td>
                    <td><%= product.getTelno() %></td>
                    <td>                <!-- 구매 버튼 -->
	                <form method="get" action="/order/Order.do">
	                    <!-- action 파라미터 -->
	                    <input type="hidden" name="action" value="buy">
	                    <input type="hidden" name="productId" value="<%= product.getId() %>">
	                    <input type="submit" value="구매하기">
	                </form>
                </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
