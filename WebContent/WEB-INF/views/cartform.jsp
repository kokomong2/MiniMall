<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            color: #333;
            background-color: #f9f9f9;
        }

        h1 {
            text-align: center;
            color: #444;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        input[type="number"] {
            width: 60px;
            text-align: center;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="checkbox"] {
            transform: scale(1.2);
        }

        button {
            background-color: #007BFF;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        button:hover {
            background-color: #0056b3;
        }

        #total-payment {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin-top: 10px;
        }

        .button-container {
            text-align: right;
        }

        .button-container button {
            margin-top: 10px;
        }

        .product-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }
    </style>
    <script>
        function toggleAllCheckboxes(source) {
            const checkboxes = document.querySelectorAll('.item-checkbox');
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = source.checked;
            });
            changeTotalPayment();
        }

        function changeEachPrice() {
            document.querySelectorAll('tbody tr').forEach(function(row) {
                const price = parseInt(row.querySelector('.product-price').innerText, 10);
                const quantity = parseInt(row.querySelector('.quantity-input').value, 10);
                const totalPriceCell = row.querySelector('.total-price');

                totalPriceCell.innerText = quantity * price + "원";
            });

            changeTotalPayment();
        }

        function changeTotalPayment() {
            let totalPaymentNum = 0;

            document.querySelectorAll('tbody tr').forEach(function(row) {
                const checkbox = row.querySelector('.item-checkbox');
                const totalPriceCell = row.querySelector('.total-price');
                const totalPrice = parseInt(totalPriceCell.innerText.replace('원', ''), 10);

                if (checkbox.checked) {
                    totalPaymentNum += totalPrice;
                }
            });

            document.getElementById('total-payment').innerText = totalPaymentNum + "원";
        }

        function updateCartQuantity(cartId, quantity) {
            fetch('/Cart.do', {
                method: 'POST',
                body: new URLSearchParams({
                    action: 'updateCart',
                    cartId: cartId,
                    quantity: quantity
                })
            })
            .then(function() {
                changeEachPrice();
            });
        }

        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.quantity-input').forEach(function(input) {
                input.addEventListener('input', function(event) {
                    const row = event.target.closest('tr');
                    const cartId = row.querySelector('input[name="cartIds"]').value;
                    const quantity = event.target.value;

                    updateCartQuantity(cartId, quantity);
                });
            });

            document.querySelectorAll('.item-checkbox').forEach(function(input) {
                input.addEventListener('change', changeTotalPayment);
            });

            changeTotalPayment();
        });
    </script>
</head>
<body>
    <h1>장바구니</h1>

    <table>
        <thead>
            <tr>
                <th><input type="checkbox" onclick="toggleAllCheckboxes(this)" /></th>
                <th>이미지</th>
                <th>상품 ID</th>
                <th>상품명</th>
                <th>가격</th>
                <th>수량</th>
                <th>총 가격</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${cartList}">
                <tr>
                    <td><input type="checkbox" name="cartIds" value="${item.cartId}" class="item-checkbox" /></td>
                    <td><img src="${item.product.prodImageUrl}" alt="상품 이미지" class="product-image" /></td>
                    <td>${item.product.prodId}</td>
                    <td>${item.product.prodModelName}</td>
                    <td class="product-price">${item.product.prodSalePrice}</td>
                    <td><input type="number" name="quantities" value="${item.cartCount}" min="0" class="quantity-input" /></td>
                    <td class="total-price">${item.product.prodSalePrice * item.cartCount}원</td>
                    <td>
                        <form method="post" action="/Cart.do">
                            <input type="hidden" name="cartId" value="${item.cartId}" />
                            <input type="hidden" name="action" value="removeCart" />
                            <button type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div id="total-payment">0원</div>

    <div class="button-container">
        <button>구매하기</button>
    </div>
</body>
</html>