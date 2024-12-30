<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        input[type="number"] {
            width: 60px;
        }
    </style>
    <script>
        // 모든 체크박스의 체크 상태를 토글
        function toggleAllCheckboxes(source) {
            const checkboxes = document.querySelectorAll('.item-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = source.checked;
            });
        }
    </script>
</head>
<body>
    <h1>장바구니</h1>
    <form action="/Cart.do" method="post">
	    <input type="hidden" name="action" value="removeCart" />
	    <table>
	        <thead>
	            <tr>
	                <th><input type="checkbox" onclick="toggleAllCheckboxes(this)" /></th>
	                <th>상품id</th>
	                <th>상품명</th>
	                <th>가격</th>
	                <th>수량</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="item" items="${cartList}">
	                <tr>
	                    <td><input type="checkbox" name="cartIds" value="${item.cartId}" /></td>
	                    <td>${item.product.prodId}</td>
	                    <td>${item.product.prodName}</td>
	                    <td>${item.product.prodPrice}</td>
	                    <td><input type="number" name="quantities" value="${item.cartCount}" min="0" /></td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	    <button type="submit">선택된 항목 제거</button>
	</form>


</body>
</html>
