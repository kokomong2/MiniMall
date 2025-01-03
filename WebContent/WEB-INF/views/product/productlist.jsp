<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Product List</title>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
   rel="stylesheet">
<style>
body {
   font-family: Arial, sans-serif;
   background-color: #f9f9f9;
   margin: 0;
   padding: 20px;
}

h1 {
   color: #333;
   text-align: center;
   margin-bottom: 20px;
}

form {
   text-align: center;
   margin-bottom: 20px;
}

form input[type="text"] {
   padding: 10px;
   font-size: 14px;
   width: 300px;
   margin-right: 10px;
}

form select {
   padding: 10px;
   font-size: 14px;
   margin-right: 10px;
}

form button {
   padding: 10px 20px;
   font-size: 14px;
   background-color: #4CAF50;
   color: white;
   border: none;
   cursor: pointer;
}

.card-deck {
   display: flex;
   flex-wrap: wrap;
   gap: 20px;
   justify-content: center;
}

.card {
   width: 18rem;
   margin-bottom: 20px;
   border: none; /* 실선 없애기 */
   cursor: pointer; /* 클릭 시 포인터 모양으로 변경 */
}

.card img {
   max-height: 200px;
   object-fit: cover;
   border-radius: 4px;
}

.card-body {
   padding: 15px;
}

.card-title {
   font-size: 1.25rem;
   font-weight: bold;
}

.card-text {
   font-size: 1rem;
}

.card:hover {
   transform: scale(1.05); /* 마우스 오버 시 카드 확대 효과 */
   transition: transform 0.3s ease-in-out;
}

/* a 태그에 밑줄 없애는 스타일 추가 */
a {
   text-decoration: none; /* 밑줄 제거 */
   color: inherit; /* 부모 색상 그대로 사용 */
}
</style>

</head>
<body>
	<!-- 헤더 포함 -->
	<jsp:include page="/WEB-INF/views/header.jsp" />

	<main>
		<h1>Product List</h1>

		<!-- 검색 및 카테고리 선택 폼 -->
		<form action="/product/Product.do" method="get">
			<input type="hidden" name="action" value="search"> <input
				type="text" name="search_query" placeholder="상품명 또는 설명 검색">
			<button type="submit">검색</button>
		</form>

		<form action="/product/Product.do" method="get">
			<input type="hidden" name="action" value="category"> 
			<select id="main-category" name="prod_main_category">
				<option value="">메인 카테고리를 선택하세요</option>
				<option value="채소" ${selectedMainCategory == '채소' ? 'selected' : ''}>채소</option>
				<option value="과일" ${selectedMainCategory == '과일' ? 'selected' : ''}>과일</option>
				<option value="약재" ${selectedMainCategory == '약재' ? 'selected' : ''}>약재</option>
				<option value="조미료"
					${selectedMainCategory == '조미료' ? 'selected' : ''}>조미료</option>
				<option value="곡물" ${selectedMainCategory == '곡물' ? 'selected' : ''}>곡물</option>
				<option value="버섯" ${selectedMainCategory == '버섯' ? 'selected' : ''}>버섯</option>
				<option value="기타" ${selectedMainCategory == '기타' ? 'selected' : ''}>기타</option>
			</select> 
			
			<!-- 서브 카테고리 드롭다운 -->
			<c:if test="${not empty subCategories}">
				<select id="sub-category" name="prod_sub_category">
					<option value="">서브 카테고리를 선택하세요</option>
					<c:forEach var="subCategory" items="${subCategories}">
						<option value="${subCategory}"
							${selectedSubCategory == subCategory ? 'selected' : ''}>${subCategory}</option>
					</c:forEach>
				</select>
			</c:if>

			<button type="submit">조회</button>
		</form>

      <!-- 카드로 제품 출력 -->
      <div class="card-deck">
         <c:forEach var="product" items="${products}">
            <!-- 카드 전체를 링크로 감싸기 -->
            <a href="Product.do?action=detailform&prod_id=${product.prodId}"
               class="card"> <c:choose>
                  <c:when test="${not empty product.prodImageUrl}">
                     <img src="${product.prodImageUrl}" class="card-img-top"
                        alt="Product Image">
                  </c:when>
                  <c:otherwise>
                     <img src="default-image.jpg" class="card-img-top" alt="No Image">
                  </c:otherwise>
               </c:choose>
               <div class="card-body">
                  <h5 class="card-title">${product.prodGoodsName}</h5>
                  <p class="card-text">${product.prodExplanation}</p>
                  <p class="card-text" style="text-align: right;">
                     <strong>${product.prodSalePrice}₩</strong>
                  </p>
                  <%--                   <p class="card-text">Category: ${product.prodSubcategory}/${product.prodMainCategory}</p>
 --%>
               </div>
            </a>
         </c:forEach>
      </div>

	</main>

	<!-- 헤더 포함 -->
	<jsp:include page="/WEB-INF/views/footer.jsp" />

	<script>
	document.getElementById('main-category').addEventListener('change', function () {
	    const mainCategory = this.value;
	    const subCategorySelect = document.getElementById('sub-category'); 

	    subCategorySelect.innerHTML = '<option value="">서브 카테고리를 선택하세요</option>';

	    if (mainCategory) { 

	        fetch("/product/Product.do?action=getSubCategories&main_category=" + encodeURIComponent(mainCategory))
	            .then(response => {
	                if (!response.ok) throw new Error("Failed to fetch subcategories");
	                return response.json();
	            })
	            .then(data => {
	                data.forEach(subCategory => {
	                    const option = document.createElement('option');
	                    option.value = subCategory;
	                    option.textContent = subCategory;
	                    subCategorySelect.appendChild(option);
	                });
	            })
	            .catch(error => console.error('Error fetching subcategories:', error));
	    } else {
	        console.log('No main category selected or empty');
	    }
	});


    </script>
</body>
</html>