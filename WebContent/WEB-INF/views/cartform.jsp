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
    
    
	    function toggleAllCheckboxes(source) {
	        const checkboxes = document.querySelectorAll('.item-checkbox');
	        checkboxes.forEach(function(checkbox) {
	            checkbox.checked = source.checked;
	            
	        });
	        
	        changeTotalPayment();
	    }
	    
	    //PRICE UPDATE/////////////////////////////////////////////////////////////////////
		//각 가격 업데이트
	    function changeEachPrice() {

	        document.querySelectorAll('tbody tr').forEach(function(row) {
	        	
	            const price = parseInt(row.querySelector('.product-price').innerText, 10);
	            const quantity = parseInt(row.querySelector('.quantity-input').value, 10);
	            const totalPriceCell = row.querySelector('.total-price');
	
	            totalPriceCell.innerText = quantity*price+"원";
	        });
	
	        changeTotalPayment();
	    }
	
	    //총 결제 금액 업데이트
	    function changeTotalPayment() {
	        let totalPaymentNum = 0;
	
	        // 체크된 항목들만 합산
	        document.querySelectorAll('tbody tr').forEach(function(row) {
	            const checkbox = row.querySelector('.item-checkbox');
	            const totalPriceCell = row.querySelector('.total-price');
	            const totalPrice = parseInt(totalPriceCell.innerText.replace('원', ''), 10);
	
	            if (checkbox.checked) {
	                totalPaymentNum += totalPrice;
	            }
	        });
	
			console.log(totalPaymentNum);
	        document.getElementById('total-payment').innerText = totalPaymentNum;
	    }
	
	    
	    
	 	//CART UPDATE/////////////////////////////////////////////////////////////////
        function updateCartQuantity(cartId, quantity) {
		    fetch('/Cart.do', {
		        method: 'POST',
		        body: new URLSearchParams({
		            action: 'updateCart',
		            cartId: cartId,
		            quantity: quantity
		        })
		    })
		    .then(function(data) {
		        changeEachPrice();
		    });
		}

	 	
        
	    
	    
	    //ADD EVENT LISTENER/////////////////////////////////////////////////////////////
	    document.addEventListener('DOMContentLoaded', function() {

	    	//quantity input
	        document.querySelectorAll('.quantity-input').forEach(function(input) {
	        	input.addEventListener('input', function(event) {
                    const row = event.target.closest('tr');
                    const cartId = row.querySelector('input[name="cartIds"]').value;
                    const quantity = event.target.value;

                    updateCartQuantity(cartId, quantity);
                });
	        });
	
	        //check box
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
                  <th>상품id</th>
                  <th>상품명</th>
                  <th>가격</th>
                  <th>수량</th>
                  <th>총가격</th>
                  <th>delete</th>
              </tr>
          </thead>
          
          <tbody>
              <c:forEach var="item" items="${cartList}">
                  <tr>
                      <td>
                      	<input type="checkbox" name="cartIds" value="${item.cartId}" class="item-checkbox" />
                      </td>
                      
                      <td>${item.product.prodId}</td>
                      
                      <td>${item.product.prodModelName}</td>
                      
                      <td class="product-price">${item.product.prodSalePrice}</td>
                      
                      <td>
                      	<input type="number" name="quantities" value="${item.cartCount}" min="0" class="quantity-input" />
                      </td>
                      
                      <td class="total-price">
                      	${item.product.prodSalePrice * item.cartCount}원
                      </td>

                      <td>
                        <form method="post" action="/Cart.do">
					    <input type="hidden" name="cartId" value="${item.cartId}" />
					    <input type="hidden" name="action" value="removeCart" />
					    <button type="submit">delete</button>
						</form>
	                  </td>
                      
                  </tr>
              </c:forEach>
          </tbody>
      </table>
       
    <div id="total-payment">0원</div>
   
   	<button>purchase</button>



</body>
</html>