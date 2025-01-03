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
		#wrapper
        {
            margin: 0 auto;
            display: block;
            width: 800px;
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
		    background-color: #fff;/*white!!!!*/
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
		
		[type=checkbox]:checked {
		    background-color: currentcolor;
		}
		
		[type=checkbox]:checked::before {
		    box-shadow: none;
		    background-color: #000; /* black background for checked */
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
		    background-color: #4CAF50; /* Green background for checked */
		}
		
		
		/*Quantity number/////////////////////////////////////////////////////*/
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
		/*
	    .quantity input::-webkit-inner-spin-button,
	    .quantity input::-webkit-outer-spin-button {
	      -webkit-appearance: none;
	      margin: 0;
	    }
		*/
	    input[type="number"]::-webkit-outer-spin-button,
	    input[type="number"]::-webkit-inner-spin-button {
	        -webkit-appearance: none;
	        margin: 0;
	    }
	    
		/* TABLE/////////////////////////////////////////////////////////*/
		table {
	        width: 100%;
	        margin-bottom: 20px;
	        background-color: transparent; /* 테이블 배경 제거 */
	        box-shadow: none; /* 그림자 제거 */
	        border-collapse: separate; /* 테이블 경계 제거 */
	        border-spacing: 0 10px;/* 셀 간 간격 */
	    }
	
	    .cart_bgr {
	        background-color: #fff; /* 배경색 white */
	        padding: 20px; /* 내부 여백 */
	        margin-bottom: 20px; /* 항목 간 간격 */
	        border-radius: 10px;
	        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	    }
	
	    tr {
	        border: none; /* 행 테두리 제거 */
	    }
	
	    td {
	        border: none; /* 셀 테두리 제거 */
	        padding: 23px; /* 셀 내부 여백 */
	    }
	    
		/* PRODUCT IMAGE /////////////////////////////////////////////////////// */
	    .product-image {
	        width: 100px;
	        height: 100px;
	        object-fit: cover;
	        /*border-radius: 8px;*/
	    }	

		 /* Button /////////////////////////////////////////////////////// */
        button {
            background-color: #555A5F; /*Button color*/
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
		.total_pay_class {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin-top: 10px;
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
		            totalPriceCell.innerText = (quantity * price).toLocaleString('ko-KR') + "원";
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
        function validateInput(input,cartId) {
            const min = parseInt(input.min, 10);
            let value = parseInt(input.value, 10);
            
                if (value < min) {
                	input.value = min;
                }

                updateCartQuantity(cartId,input.value);
            }

        function updateQuantity(button, change,cartId) {
            const quantityInput = button.parentElement.querySelector('input[type="number"]');
            const currentValue = parseInt(quantityInput.value, 10);
            const newValue = currentValue + change;
            if (newValue >= 1) {
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
    </script>
</head>
<body>
    <h1>장바구니</h1>
	<div id="wrapper">
    <table>
    	
    	<!-- CHECK BOX -->
        <div><input type="checkbox" onclick="toggleAllCheckboxes(this)" /></div>
        
        <tbody>
	    <c:forEach var="item" items="${cartList}">

            <tr class="cart_bgr">
				<div style="display: flex; align-items: center;">
					
					<!-- CHECK BOX -->
					<td>
		                <div style="display: flex; justify-content: space-between; align-items: center;">
		                    <input type="checkbox" name="cartIds" value="${item.cartId}" class="item-checkbox" />
						</div>
					</td>
					
					<!-- IMAGE -->
					<td>
					    <a href="product/Product.do?action=detailform&prod_id=${item.product.prodId}">
					        <img src="${item.product.prodImageUrl}" alt="상품 이미지" class="product-image" />
					    </a>
					</td>

	                
					<!-- INFORMATION -->
	                <td style="text-align: left;">
	                	<a href="product/Product.do?action=detailform&prod_id=${item.product.prodId}">
		                    <div style="font-size: 18px; font-weight: bold; margin-bottom: 4px;">
		                        ${item.product.prodModelName} 
		                    </div>
	                    </a>
	                    <div style="font-size: 13px; margin-bottom: 4px; color:#848484">
	                        No.${item.product.prodId}  ${item.product.prodBrandName}
	                    </div>
	                    <div class="product-price" style="font-size: 15px;">
	                        ${item.product.prodSalePrice}
	                    </div>
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
	                
	                <td style="position: relative;">
					    
					    <!-- DELETE BUTTON -->
					    <form method="post" action="/Cart.do" style="position: absolute; top: 0; right: 0; display:inline;">
					        <input type="hidden" name="cartId" value="${item.cartId}" />
					        <input type="hidden" name="action" value="removeCart" />
					        <button type="submit" style="border: none; background: none; cursor: pointer;">
					            <img src="https://i.ibb.co/zfr4JRD/trash-can.png" alt="trash-can" style="width: 20px; height: auto;">
					        </button>
					    </form>
					    
					    <!-- PRICE -->
					    <div class="total-price" style="font-weight: bold;">
					        ${item.product.prodSalePrice * item.cartCount}원
					    </div>
					</td>
                </div>
            </tr>
	            
	    </c:forEach>
	</tbody>

    </table>
    
    <div style="display: flex; justify-content: space-between; align-items: center;">
	    <div class="total_pay_class">총 결제 금액  <span id="total-payment" lass="total_pay_class">0</span>원</div>
	    <button>구매하기</button>
	</div>

 
	</div>
    
</body>
</html>
