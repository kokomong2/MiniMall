<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        button {
            padding: 8px 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Product List</h1>
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
                <td>
				    <c:choose>
				        <c:when test="${not empty product.prodImageUrl}">
				            <a href="Product.do?action=detailform&prod_id=${product.prodId}">
				                <img src="${product.prodImageUrl}" alt="Product Image">
				            </a>
				        </c:when>
				        <c:otherwise>
				            <div class="no-image">No Image</div>
				        </c:otherwise>
				    </c:choose>
				</td>
                <td>${product.prodGoodsName}</td>
                <td>${product.prodBrandName}</td>
                <td>${product.prodSalePrice} ₩</td>
                <td>${product.prodSubcategory} / ${product.prodMainCategory}</td>
                <td>${product.prodRegionName}</td>
                <td>${product.prodExplanation}</td>
                <!-- AJAX 장바구니 버튼 -->
                <td>
                    <button type="button" class="add-to-cart" 
                            data-product-id="${product.prodId}" 
                            data-cust-id="2">Add to Cart</button>
                </td>
            </tr>
        </c:forEach>
    </table>

    <script>
        // AJAX 요청을 통해 장바구니에 상품 추가
        document.querySelectorAll(".add-to-cart").forEach(button => {
            button.addEventListener("click", () => {
                const productId = button.getAttribute("data-product-id");
                const custId = button.getAttribute("data-cust-id");

                fetch("/Cart.do", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                    },
                    body: new URLSearchParams({
                        action: "addCart",
                        productId: productId,
                        custId: custId,
                        cartQuantity: 1,
                    }),
                })
                .then(response => {
                    if (response.ok) {
                        alert("상품이 장바구니에 추가되었습니다.");
                    } else {
                        alert("장바구니 추가에 실패했습니다.");
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("오류가 발생했습니다. 다시 시도해주세요.");
                });
            });
        });
    </script>
</body>
</html>
