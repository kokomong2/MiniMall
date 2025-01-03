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

/*TABLE////////////////////////////////////////////*/
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

/*CHECK BOX//////////////////////////////////////////*/
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
    background-color: #fff;/*white!!!!*/
    transition: background 300ms;
    cursor: pointer;
    position: relative;
}

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

[type=checkbox]:checked {
    background-color: currentcolor;
}

[type=checkbox]:checked::before {
    box-shadow: none;
    background-color: #3C5F40; /* background for checked */
}

[type=checkbox]:checked::after {
    content: "✔"; /* Checkmark symbol */
    position: absolute;
    top: 50%;
    left: 50%;
    font-size: 1rem; /* checkmark size */
    color: white; /* checkmark color */
    transform: translate(-50%, -50%); /* checkmark center*/
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
    background-color: #3C5F40; /* Green background for checked */
}
		
/*QUANTITY////////////////////////////////////////////////////*/
input[type="number"] {
       width: 60px;
       text-align: center;
       padding: 5px;
       border: 1px solid #ccc;
   }

.quantity input {
  width: 50px;
  text-align: center;
  border: none;
  outline: none;
  -moz-appearance: textfield;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

/*PRODUCT Image/////////////////////////////////////////////////*/
.product-image {
	width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 4px;
}
/*BUTTON///////////////////////////////////////////////////////*/
button {
    background-color: #3C5F40; /*Button color*/
    color: #fff;
    border: none;
    padding: 5px 10px;
    cursor: pointer;   
    font-size: 14px;
}

button:hover {
    background-color: #000000;
}
.button-container {
	text-align: right;
}

.button-container button {
	margin-top: 10px;
}
/*A ///////////////////////////////////////////////////////////////////*/
a {
    text-decoration: none; /* 밑줄 제거 */
    color: black;
}
a:hover {
    text-decoration: none;
    color: black;
}

/*TOTAL PAYMENNT ///////////////////////////////////////////////////////*/
#total-payment {
	font-size: 18px;
	font-weight: bold;
	text-align: right;
	margin-top: 10px;
}

/*and so on//////////////////////////////////////////////////////////////*/
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

/*CHECK BOX//////////////////////////////////////////*/
function toggleAllCheckboxes(source) {
    const checkboxes = document.querySelectorAll('.item-checkbox');
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = source.checked;
    });
    saveCheckboxState();
    changeTotalPayment();
}

// 체크박스 상태 저장
function saveCheckboxState() {
    const checkboxStates = {};
    document.querySelectorAll('.item-checkbox').forEach(function(checkbox) {
        checkboxStates[checkbox.value] = checkbox.checked;
    });
    localStorage.setItem('checkboxStates', JSON.stringify(checkboxStates));
}

// 체크박스 상태 복원
function restoreCheckboxState() {
    const checkboxStates = JSON.parse(localStorage.getItem('checkboxStates') || '{}');
    document.querySelectorAll('.item-checkbox').forEach(function(checkbox) {
        checkbox.checked = checkboxStates[checkbox.value] || false;
    });

    changeTotalPayment();
}


/*QUANTITY//////////////////////////////////////////*/
function changeEachPrice() {
    document.querySelectorAll('tbody tr').forEach(function (row) {
    	
        // '.product-price'에서 숫자만 추출 (콤마 제거)
        const priceText = row.querySelector('.product-price').innerText.replace(/[^\d]/g, ""); // 숫자만 추출
        const price = parseInt(priceText, 10);

        // '.quantity-input' 값 가져오기
        const quantity = parseInt(row.querySelector('.quantity-input').value, 10) || 0;

        // '.total-price' 셀 업데이트
        const totalPriceCell = row.querySelector('.total-price');
        if (!isNaN(price) && !isNaN(quantity)) {
            totalPriceCell.innerText = (quantity * price)+ "원";
        } else {
            totalPriceCell.innerText = "0원";
        }
    });

    changeTotalPayment();
}

function changeTotalPayment() {
    let totalPaymentNum = 0;

    document.querySelectorAll('tbody tr').forEach(function (row) {
        const checkbox = row.querySelector('.item-checkbox');
        const totalPriceCell = row.querySelector('.total-price');
        
        // '.total-price'에서 숫자만 추출
        const totalPriceText = totalPriceCell.innerText.replace(/[^\d]/g, ""); // 숫자만 추출
        const totalPrice = parseInt(totalPriceText, 10);

        if (checkbox.checked && !isNaN(totalPrice)) {
            totalPaymentNum += totalPrice;
        }
    });

    document.getElementById('total-payment').innerText = totalPaymentNum.toLocaleString('ko-KR');
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
function validateInput(input,cartId) {
    const min = parseInt(input.min, 10);
    let value = parseInt(input.value, 10);
    
        if (value < min || value==null) {
        	input.value = min;
        }

        updateCartQuantity(cartId,input.value);
    }

function updateQuantity(button, change,cartId) {
    const quantityInput = button.parentElement.querySelector('input[type="number"]');
    const currentValue = parseInt(quantityInput.value, 10);
    const newValue = currentValue + change;
    if (newValue >= 1 && newValue!=null) {
        quantityInput.value = newValue;
    }
    updateCartQuantity(cartId,quantityInput.value);
  }





/*ADD LISTENER//////////////////////////////////////////////////////*/
document.addEventListener('DOMContentLoaded', function() {
	
	//QUANTITY-----------------------------------------
    document.querySelectorAll('.quantity-input').forEach(function(input) {
        input.addEventListener('input', function(event) {
            const row = event.target.closest('tr');
            const cartId = row.querySelector('input[name="cartIds"]').value;
            const quantity = event.target.value;

            updateCartQuantity(cartId, quantity);
        });
    });
	
  	//CHECK BOX-----------------------------------------
 	// 복원
    restoreCheckboxState();

    // 체크박스 상태 변경 시 저장
    document.querySelectorAll('.item-checkbox').forEach(function(checkbox) {
        checkbox.addEventListener('change', saveCheckboxState);
        checkbox.addEventListener('change', changeTotalPayment);
    });		
    
    
    //PRICE --------------------------------------------
    changeEachPrice();
    changeTotalPayment();
 	// 모든 .product-price 요소 선택
    const priceElements = document.querySelectorAll(".product-price");

    priceElements.forEach(function (priceElement) {
        const price = parseInt(priceElement.innerText, 10);
        if (!isNaN(price)) {
            priceElement.innerText = price.toLocaleString("ko-KR") + "원";
        }
    });
    
    
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
		<!-- CHECK BOX -->
        <div><input type="checkbox" onclick="toggleAllCheckboxes(this)" /></div>
		
		<table>
			
			<tbody>
				<c:choose>
		        <c:when test="${not empty cartList}">
				<c:forEach var="item" items="${cartList}">
					<tr class="cart_bgr">
						
						<!-- CHECK BOX -->
						<td><input type="checkbox" name="cartIds"
							value="${item.cartId}" class="item-checkbox" /></td>
							
							
						<!-- IMAGE -->
						<td><img src="${item.product.prodImageUrl}" alt="상품 이미지"
							class="product-image" /></td>
							
							
						<!-- INFORMATION -->
						<td style="text-align: left;">
							<div style="font-size: 18px; font-weight: bold; margin-bottom: 4px;">
								${item.product.prodModelName}</div>
							<div style="font-size: 13px; margin-bottom: 4px; color:#848484">
								<input type="hidden" class="prodId" value="${item.product.prodId}" />
								No.${item.product.prodId}  ${item.product.prodBrandName}</div>
							<div class="product-price" style="font-size: 15px;">
								${item.product.prodSalePrice}</div>
						</td>
						
						<!-- QUANTITY -->		
						<td>
		                    <div class="quantity-container">
		                    	<button onclick="updateQuantity(this, -1,${item.cartId})">-</button>
					            <input type="number" name="quantities" value="${item.cartCount}" min="1" 
					            class="quantity-input" 
					            onchange="validateInput(this,${item.cartId})">
					            <button onclick="updateQuantity(this, 1,${item.cartId})">+</button>
		                    </div>
		                </td>



						<td style="position: relative;  width: 150px;">
						    <!-- DELETE BUTTON -->
							<form method="post" action="/cart/Cart.do" style="position: absolute; top: 0; right: 0; display:inline;">
								<input type="hidden" name="cartId" value="${item.cartId}" /> 
								<input type="hidden" name="action" value="removeCart" />
								<button type="submit" style="border: none; background: none;">
						        	<!-- https://i.ibb.co/zfr4JRD/trash-can.png -->
						            <img src="https://ifh.cc/g/7LLkgN.png" alt="trash-can" style="width: 20px; height: auto;">
						        </button>
							</form>
							
							
						    <!-- PRICE -->
						    <div class="total-price" style="font-weight: bold;">
						        ${item.product.prodSalePrice * item.cartCount}원
						    </div>
						</td>
						
						
					</tr>
				</c:forEach>
				</c:when>
				
					<c:otherwise>
	                <tr>
	                    <td colspan="3" style="text-align:center;">장바구니가 비어있습니다.</td>
	                </tr>
	            	</c:otherwise>
				
				</c:choose>
			</tbody>
		</table>
		<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom:60px;">
		
		<div class="total_pay_class">총 결제 금액  <span id="total-payment" class="total_pay_class">0</span>원</div>

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
					onclick="submitCheckedItems()">구매</button>
			</form>
		</div>
		</div>
	</div>
	</main>

	<jsp:include page="/WEB-INF/views/footer.jsp" />

</body>
</html>