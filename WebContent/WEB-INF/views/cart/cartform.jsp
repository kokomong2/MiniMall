<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
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

/*TABLE*/
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	background-color: transparent; 
	box-shadow: none;
	border-collapse: separate;
	border-spacing: 0 10px;/* 셀 간 간격 */
	
}

td {
	border: none;
	padding: 23px;
	text-align: center;
}

.cart_bgr {
    background-color: #fff; /* 배경색 white */
    padding: 20px; /* 내부 여백 */
    margin-bottom: 20px; /* 항목 간 간격 */
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/*CHECK BOX*/

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

/*and so on*/
#wrapper
{
    margin: 0 auto;
    display: block;
    width: 800px;
}
#carttitle{
	margin-top:60px;
	margin-bottom:20px;
	display: flex;
	justify-content: center; /* 가로 중앙 */
	align-items: center;
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
            fetch('/cart/Cart.do', {
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
        
        function submitCheckedItems() {
            const form = document.getElementById("orderForm");
            const checkboxes = document.querySelectorAll('.item-checkbox');

            // 기존에 추가된 hidden input 제거
            const existingInputs = form.querySelectorAll("input[name='prodId'], input[name='orderCount'], input[name='orderPrice']");
            existingInputs.forEach(input => input.remove());

            // 체크된 항목만 처리
            checkboxes.forEach((checkbox) => {
                if (checkbox.checked) {
                    const row = checkbox.closest("tr");
                    if (!row) return;

                    // 현재 행의 데이터를 가져오기
                    const prodId = row.querySelector(".prodId").value;
                    const orderCount = row.querySelector(".quantity-input").value;
                    const orderPrice = row.querySelector(".total-price").innerText.replace("원", "").trim();

                    // Hidden input 생성
                    const prodIdInput = document.createElement("input");
                    prodIdInput.type = "hidden";
                    prodIdInput.name = "prodId";
                    prodIdInput.value = prodId;
                    form.appendChild(prodIdInput);

                    const orderCountInput = document.createElement("input");
                    orderCountInput.type = "hidden";
                    orderCountInput.name = "orderCount";
                    orderCountInput.value = orderCount;
                    form.appendChild(orderCountInput);

                    const orderPriceInput = document.createElement("input");
                    orderPriceInput.type = "hidden";
                    orderPriceInput.name = "orderPrice";
                    orderPriceInput.value = orderPrice;
                    form.appendChild(orderPriceInput);
                }
            });

            form.submit();
        }
    </script>
</head>
<body>

	<!-- 헤더 포함 -->
	<jsp:include page="/WEB-INF/views/header.jsp" />

	<main>
	
		<div id="carttitle">
	   		<h2 style="font-weight:bold;">장바구니</h2>
	   	</div>

		<div id="wrapper">
		<table>
			
			<tbody>
				<c:forEach var="item" items="${cartList}">
					<tr class="cart_bgr">
						<td><input type="checkbox" name="cartIds"
							value="${item.cartId}" class="item-checkbox" /></td>
						<td><img src="${item.product.prodImageUrl}" alt="상품 이미지"
							class="product-image" /></td>
						<td><input type="hidden" class="prodId"
							value="${item.product.prodId}" />${item.product.prodId}</td>
						<td>${item.product.prodModelName}</td>
						<td class="product-price">${item.product.prodSalePrice}</td>
						<td><input type="number" class="quantity-input"
							value="${item.cartCount}" min="1" /></td>
						<td class="total-price">${item.product.prodSalePrice * item.cartCount}원</td>
						<td>
							<form method="post" action="/cart/Cart.do">
								<input type="hidden" name="cartId" value="${item.cartId}" /> <input
									type="hidden" name="action" value="removeCart" />
								<button type="submit">삭제</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div id="total-payment">0원</div>

		<div class="button-container">
			<form id="orderForm" action="/order/Order.do" method="post">
				<input type="hidden" name="action" value="buy">
				<c:forEach var="item" items="${cartList}">
					<input type="hidden" class="prodId" value="${item.product.prodId}" />
					<input type="hidden" class="orderCount" value="${item.cartCount}" />
					<input type="hidden" class="orderPrice"
						value="${item.product.prodSalePrice * item.cartCount}" />
				</c:forEach>
				<input type="hidden" name="customerEmail"
					value="${sessionScope.customer.cust_email}" />
				<button type="button" class="buy-button"
					onclick="submitCheckedItems()">구매하기</button>
			</form>
		</div>
	</div>
	</main>

	<jsp:include page="/WEB-INF/views/footer.jsp" />

</body>
</html>