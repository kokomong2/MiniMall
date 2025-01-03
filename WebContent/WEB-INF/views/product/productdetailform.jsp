<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Product Detail</title>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
   rel="stylesheet">
<style>
body {
   font-family: Arial, sans-serif;
   margin: 20px;
   padding: 20px;
   background-color: #f9f9f9;
}

.product-detail {
   display: flex;
   max-width: 1000px;
   margin: 0 auto;
   background: #fff;
   border-radius: 10px;
   box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
   padding: 0 20px 20px 20px;
}

.product-image {
   flex: 1; /* 이미지 비율 5:5로 설정 */
   text-align: center;
   margin-top: 50px;
   margin-right: 30px;
}

.product-image img {
   max-width: 100%;
   height: auto;
   border-radius: 5px;
}

.product-info {
   flex: 1; /* 정보 비율 5:5로 설정 */
   display: flex;
   flex-direction: column;
   text-align: right; /* 오른쪽 정렬 */
}

.product-header h1 {
   font-size: 2rem;
   color: #333;
   font-weight: bold;
   text-align: right; /* 제목 오른쪽 정렬 */
}

.info-row {
   margin-bottom: 15px;
   padding: 15px;
   text-align: right; /* 오른쪽 정렬 */
}

.product-actions {
   margin-top: 30px;
   display: flex;
   justify-content: flex-end;
   align-items: center;
}

.product-actions form {
   display: inline-block;
   margin: 0 10px;
}

.product-actions button {
   padding: 15px 30px;
   font-size: 1.1rem;
   color: white;
   background-color: #4CAF50;
   border: none;
   border-radius: 5px;
   cursor: pointer;
   transition: background-color 0.3s ease;
}

.product-actions button:hover {
   background-color: #45a049;
}

.quantity-input {
   width: 100px; /* 수량 입력 크기 키움 */
   padding: 10px;
   font-size: 1.1rem;
   margin-right: 10px;
}

.product-description {
   margin-top: 30px;
   text-align: right;
   padding: 20px;
   font-size: 1.2rem;
   color: #333;
   line-height: 1.6;
}

.product-description p {
   text-align: right; /* 텍스트 왼쪽 정렬 */
   margin-top: 10px;
   margin-right: 250px;
   font-weight: 500; /* 글씨 조금 두껍게 */
}

.product-description .product-image {
   text-align: center;
   margin-bottom: 20px; /* 이미지 아래쪽 여백 추가 */
}

.product-description .product-image img {
   max-width: 100%; /* 이미지 크기 자동으로 맞추기 */
   border-radius: 10px; /* 이미지 모서리 둥글게 */
}

.product-description strong {
   font-size: 1.3rem;
   color: #FF6F3C; /* 당근색 */
}

.product-actions button.buy-button {
   background-color: #FF6F3C; /* 당근색 */
}

.product-actions button.buy-button:hover {
   background-color: #e65c1f; /* 당근색의 어두운 톤 */
}
</style>
</head>
<body>

   <jsp:include page="/WEB-INF/views/header.jsp" />

   <main>
      <div class="product-detail">
         <!-- 이미지 -->
         <div class="product-image">
            <img src="${product.prodImageUrl}" alt="${product.prodGoodsName}">
         </div>

         <!-- 제품 정보 -->
         <div class="product-info">
            <div class="product-header">
               <h1>${product.prodGoodsName}</h1>
            </div>
            <div class="info-row">${product.prodSalePrice}₩</div>
            <div class="info-row">${product.prodRegionName}&nbsp;${product.prodBrandName}</div>
            <div class="info-row">${product.prodSaleWeight} ${product.prodWeightUnit}</div>





<div class="product-actions">
<!-- 장바구니 폼 -->
<form action="/cart/Cart.do" method="post">
    <input type="hidden" name="productId" value="${product.prodId}" />
    <input type="hidden" name="custId" value="2" />
    
    <!-- 장바구니 수량 -->
    <input type="number" name="cartQuantity" class="quantity-input" value="1" min="1" id="cartQuantity" oninput="syncQuantities()"/>

    <input type="hidden" name="action" value="addCart" />
    <button type="submit" id="cartBtn">장바구니</button>
</form>

<!-- 구매 폼 -->
<form id="orderForm" action="/order/Order.do" method="post">
    <input type="hidden" name="action" value="buy">
    <input type="hidden" name="prodId" value="${product.prodId}"> <!-- 상품 ID -->
    <input type="hidden" name="orderPrice" value="${product.prodSalePrice}"> <!-- 가격 -->
    <input type="hidden" name="customerEmail" value="${sessionScope.customer.cust_email}">
    
    <!-- 구매 수량 (숨겨서 사용) -->
    <input type="number" id="orderCount" name="orderCount" class="quantity-input" value="1" min="1" style="display: none;" />

    <!-- 구매하기 버튼 -->
    <button type="button" class="buy-button" onclick="submitCheckedItems()">구매하기</button>
</form>



            </div>
         </div>
      </div>

<script>
    // 장바구니 수량과 구매 수량을 동일하게 유지하는 함수
    function syncQuantities() {
        const cartQuantity = document.getElementById('cartQuantity').value; // 장바구니 수량
        document.getElementById('orderCount').value = cartQuantity; // 구매 수량에 동일하게 반영
    }

    // 구매 버튼 클릭 시 동작하는 함수
    function submitCheckedItems() {
        const cartQuantity = document.getElementById('orderCount').value; // 구매 수량

        // 폼 데이터 확인 (디버깅 용)
        const form = document.getElementById('orderForm');
        const formData = new FormData(form);
        formData.forEach((value, key) => {
            console.log(key + ': ' + value); // key와 value를 콘솔에 찍어본다
        });

        // 폼 제출 전에 orderCount 값 확인
        console.log("orderCount: ", document.getElementById('orderCount').value);

        // 폼 제출
        form.submit(); // 폼을 직접 제출
    }
</script>

      <!-- 부가적인 설명 -->
      <div class="product-description">
         <p style="text-align: right;">
            <strong>${product.prodGoodsName}</strong><br><br>
         <div class="image" style="width: 50%; text-align: center; margin: 0 auto;">
            <img src="${product.prodImageUrl}" alt="${product.prodGoodsName}" style="width: 80%;">
         </div>
         </p>
      </div>

      <jsp:include page="/WEB-INF/views/product/dailybestsell.jsp" />
   </main>

   <jsp:include page="/WEB-INF/views/footer.jsp" />

</body>
</html>