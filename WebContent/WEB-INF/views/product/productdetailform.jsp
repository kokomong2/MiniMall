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
               <h1>
                  <br>
                  <br>${product.prodGoodsName}</h1>
            </div>
            <%--                <div class="info-row">
                   ${product.prodId}
               </div> --%>

            <div class="info-row">${product.prodSalePrice}₩</div>
            <%--                <div class="info-row">
                   ${product.prodMainCategory} / ${product.prodSubcategory}
               </div> --%>
            <div class="info-row">${product.prodRegionName}&nbsp
               ${product.prodBrandName}</div>
            <div class="info-row">${product.prodSaleWeight}
               ${product.prodWeightUnit}</div>

            <!-- 버튼들 -->
            <div class="product-actions">
               <form action="/cart/Cart.do" method="post">
                  <input type="hidden" name="productId" value="${product.prodId}" />
                  <input type="hidden" name="custId" value="2" /> <input
                     type="number" name="cartQuantity" class="quantity-input"
                     value="1" min="1" /> <input type="hidden" name="action"
                     value="addCart" />

                  <button type="submit" id="cartBtn">장바구니</button>
               </form>

               <form action="/order/Order.do" method="post">
                  <input type="hidden" name="action" value="buy"> <input
                     type="hidden" name="prodId" value="${product.prodId}"> <input
                     type="hidden" name="customerEmail"
                     value="${sessionScope.customer.cust_email}">
                  <button type="submit" class="buy-button">구매하기</button>
               </form>
            </div>
         </div>
      </div>

      <!-- 부가적인 설명 -->
      <div class="product-description">
         <p style="text-align: right;">
            <!-- 오른쪽 정렬 추가 -->
            <strong>${product.prodGoodsName}</strong><br>
            <br>
         <div class="image"
            style="width: 50%; text-align: center; margin: 0 auto;">
            <img src="${product.prodImageUrl}" alt="${product.prodGoodsName}"
               style="width: 80%;">
         </div>

<%--          <span style="display: block; text-align: right; margin-right: 220px;">${product.prodBrandName}</span><br>
         <br> <span style="display: block; text-align: right;margin-right: 220px;">${product.prodSalePrice}
            ₩</span><br>
         <br> <span style="display: block; text-align: right;margin-right: 220px;">${product.prodMainCategory}
            / ${product.prodSubcategory}</span><br>
         <br> <span style="display: block; text-align: right;margin-right: 220px;">${product.prodRegionName}</span><br>
         <br> <span style="display: block; text-align: right;margin-right: 220px;">${product.prodSaleWeight}${product.prodWeightUnit}</span><br>
         <br> --%>
         </p>
      </div>
        <jsp:include page="/WEB-INF/views/product/dailybestsell.jsp" />

   </main>

   <jsp:include page="/WEB-INF/views/footer.jsp" />

</body>
</html>
