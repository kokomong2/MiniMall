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

		 /* Check box /////////////////////////////////////////////////////// */
        [type=checkbox] {
		    width: 1.5rem;
		    height: 1.5rem;
		    color: black; /*black!!!!*/
		    vertical-align: middle;
		    -webkit-appearance: none;
		    background: none;
		    border: 0;
		    outline: 0;
		    flex-grow: 0;
		    border-radius: 50%;
		    background-color: #7B7B7B;
		    transition: background 300ms;
		    cursor: pointer;
		    position: relative;
		}
		
		/* Pseudo element for check styling */
		[type=checkbox]::before {
		    content: "";
		    display: block;
		    width: inherit;
		    height: inherit;
		    border-radius: inherit;
		    background-color: transparent;
		    box-shadow: inset 0 0 0 1px #CCD3D8;
		    position: relative;
		}
		
		/* Checked */
		[type=checkbox]:checked {
		    background-color: currentcolor;
		}
		
		[type=checkbox]:checked::before {
		    box-shadow: none;
		    background-color: #4CAF50; /* Green background for checked */
		}
		
		/* Add the checkmark directly using pseudo-element */
		[type=checkbox]:checked::after {
		    content: "✔"; /* Checkmark symbol */
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    font-size: 1.2rem; /* Adjust checkmark size */
		    color: white; /* White color for the checkmark */
		    transform: translate(-50%, -50%); /* Center the checkmark */
		}
		
		/* Disabled */
		[type=checkbox]:disabled {
		    background-color: #CCD3D8; /*gray*/
		    opacity: 0.84;
		    cursor: not-allowed;
		}
		
		/* IE */
		[type=checkbox]::-ms-check {
		    content: "";
		    color: transparent;
		    display: block;
		    width: inherit;
		    height: inherit;
		    border-radius: inherit;
		    border: 0;
		    background-color: transparent;
		    background-size: contain;
		    box-shadow: inset 0 0 0 1px #CCD3D8; /*gray*/
		}
		
		[type=checkbox]:checked::-ms-check {
		    box-shadow: none;
		    background-color: #4CAF50; /* Green background for checked */
		}
		
		/*Quantity number/////////////////////////////////////////////////////*/
		.quantity-container {
		    display: flex;
		    align-items: center;
		    width: 100%; /* 적절한 너비 설정 */
		}
		
		.quantity-input {
		    width: 60px;
		    padding: 5px;
		    text-align: center;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    font-size: 1rem;
		    position: relative;
		}
		
		/* 증감 버튼을 위한 스타일 */
		.quantity-input::before,
		.quantity-input::after {
		    content: "";
		    position: absolute;
		    top: 50%;
		    transform: translateY(-50%);
		    width: 20px;
		    height: 20px;
		    background-color: #f0f0f0;
		    border: 1px solid #ccc;
		    border-radius: 50%;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    cursor: pointer;
		}
		
		.quantity-input::before {
		    left: -25px; /* 왼쪽 버튼 위치 */
		}
		
		.quantity-input::after {
		    right: -25px; /* 오른쪽 버튼 위치 */
		}
		
		/* 증감 버튼에 해당하는 기호 */
		.quantity-input::before::after {
		    content: "+";
		    font-size: 18px;
		    color: #333;
		}
		
		.quantity-input::after::after {
		    content: "-";
		    font-size: 18px;
		    color: #333;
		}
		
		/* 번호 입력 필드 테두리 스타일 */
		.quantity-container input[type="number"] {
		    padding-left: 25px; /* 왼쪽 버튼이 겹치지 않도록 여백 추가 */
		    padding-right: 25px; /* 오른쪽 버튼이 겹치지 않도록 여백 추가 */
		}
				

		 /* Button /////////////////////////////////////////////////////// */
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
        <div><input type="checkbox" onclick="toggleAllCheckboxes(this)" /></div>
        <tbody>
            <c:forEach var="item" items="${cartList}">
                <tr>
                    <td><input type="checkbox" name="cartIds" value="${item.cartId}" class="item-checkbox" /></td>
                    <td><img src="${item.product.prodImageUrl}" alt="상품 이미지" class="product-image" /></td>
                    <td>No. ${item.product.prodId}</td>
                    <td>${item.product.prodModelName}</td>
                    <td class="product-price">${item.product.prodSalePrice}</td>
                    <td>
					    <div class="quantity-container">
					        <input type="number" name="quantities" value="${item.cartCount}" min="0" class="quantity-input" />
					    </div>
					</td>

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
