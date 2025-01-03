<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .product-detail {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .product-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .product-header img {
            max-width: 200px;
            height: auto;
            border-radius: 5px;
        }
        .product-info table {
            width: 100%;
            border-collapse: collapse;
        }
        .product-info th, .product-info td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .product-info th {
            background-color: #f2f2f2;
            width: 30%;
        }
        button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover {
            background-color: #45a049;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            overflow: auto;
            padding-top: 60px;
        }
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 500px;
            text-align: center;
            border-radius: 10px;
        }
        .close-button {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 25px;
        }
        .close-button:hover,
        .close-button:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script>
        // modal
        function showModal() {
            document.getElementById("cartModal").style.display = "block";
        }

        function closeModal(event) {
            if (event) {
                event.stopPropagation();
            }
            document.getElementById("cartModal").style.display = "none";
        }

        function goToCart() {
            document.getElementById("cartModal").style.display = "none";
            window.location.href = '/Cart.do?action=list';
        }
		
        
        //add listener
        document.addEventListener("DOMContentLoaded", function () {
            var cartBtn = document.getElementById("cartBtn");

            cartBtn.addEventListener("click", function () {
                const formData = new FormData(document.getElementById("cartForm"));

                fetch('/Cart.do', {
                    method: 'POST',
                    body: formData
                })
                .then(function (response) {
                    if (response.ok) {
                        return response.text();
                    } else {
                        throw new Error('bad network response');
                    }
                })
                .then(function (data) {
                    console.log("Server Response:", data);
                    showModal();
                })
                
            });
        });




    </script>

</head>
<body>
    <!-- 모달 -->
    <div id="cartModal" class="modal" onclick="closeModal(event)">
        <div class="modal-content" onclick="event.stopPropagation()">
            <span class="close-button" onclick="closeModal()">&times;</span>
            <h2>장바구니에 추가되었습니다</h2>
            <p>상품이 장바구니에 추가되었습니다. 장바구니로 이동하시겠습니까?</p>
            <button onclick="goToCart()">장바구니로 이동</button>
            <button onclick="closeModal()">계속 쇼핑</button>
        </div>
    </div>

    <!-- 상품 상세 -->
    <div class="product-detail">
        <div class="product-header">
            <img src="${product.prodImageUrl}" alt="${product.prodGoodsName}">
            <h1>${product.prodGoodsName}</h1>
        </div>
        <div class="product-info">
            <table>
                <tr>
                    <th>Product ID</th>
                    <td>${product.prodId}</td>
                </tr>
                <tr>
                    <th>Brand</th>
                    <td>${product.prodBrandName}</td>
                </tr>
                <tr>
                    <th>Price</th>
                    <td>${product.prodSalePrice} ₩</td>
                </tr>
                <tr>
                    <th>Category</th>
                    <td>${product.prodMainCategory} / ${product.prodSubcategory}</td>
                </tr>
                <tr>
                    <th>Region</th>
                    <td>${product.prodRegionName}</td>
                </tr>
                <tr>
                    <th>Weight</th>
                    <td>${product.prodSaleWeight} ${product.prodWeightUnit}</td>
                </tr>
                <tr>
                    <th>Explanation</th>
                    <td>${product.prodExplanation}</td>
                </tr>
            </table>
        </div>
        
        
        <!-- 장바구니 -->
        <form id="cartForm" action="Cart.do" method="post">
		    <input type="hidden" name="productId" value="${product.prodId}" />
		    <input type="hidden" name="custId" value="2" />
		    <input type="number" name="cartQuantity" value="1" min="1" />
		    <input type="hidden" name="action" value="addCart" />
		    <button type="button" id="cartBtn">장바구니</button>
		</form>
    </div>
</body>
</html>
