<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Product List</title>
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

table {
	width: 100%;
	border-collapse: collapse;
	margin: 0 auto;
	background-color: #fff;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

th, td {
	padding: 10px 15px;
	text-align: center;
}

th {
	background-color: #4CAF50;
	color: white;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

tr:hover {
	background-color: #ddd;
}

img {
	max-width: 100px;
	height: auto;
	border-radius: 4px;
}

.no-image {
	font-size: 12px;
	color: #888;
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
			</select> <select id="sub-category" name="prod_sub_category">
				<option value="">서브 카테고리를 선택하세요</option>
			</select>

			<button type="submit">조회</button>
		</form>

		<table border="1">
			<tr>
				<th>Product ID</th>
				<th>Image</th>
				<th>Goods Name</th>
				<th>Brand</th>
				<th>Price</th>
				<th>Category</th>
				<th>Region</th>
				<th>Explanation</th>
				<th>Cart</th>
			</tr>
			<c:forEach var="product" items="${products}">
				<tr>
					<td>${product.prodId}</td>
					<td><c:choose>
							<c:when test="${not empty product.prodImageUrl}">
								<a href="Product.do?action=detailform&prod_id=${product.prodId}">
									<img src="${product.prodImageUrl}" alt="Product Image">
								</a>
							</c:when>
							<c:otherwise>
								<div class="no-image">No Image</div>
							</c:otherwise>
						</c:choose></td>
					<td>${product.prodGoodsName}</td>
					<td>${product.prodBrandName}</td>
					<td>${product.prodSalePrice}₩</td>
					<td>${product.prodSubcategory}/${product.prodMainCategory}</td>
					<td>${product.prodRegionName}</td>
					<td>${product.prodExplanation}</td>
					<!-- 장바구니 버튼 -->
					<td>
						<form method="post" action="/cart/Cart.do">
							<input type="hidden" name="custId" value="2" /> <input
								type="hidden" name="cartQuantity" value="1" min="1" /> <input
								type="hidden" name="productId" value="${product.prodId}" /> <input
								type="hidden" name="action" value="addCart" />
							<button type="submit">Add to Cart</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
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