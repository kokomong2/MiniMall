<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Apple</h1>
	<h2>1000</h2>
	<form action="/Cart.do" method="post">
		<input type="hidden" name="productId" value="10"/>
		<input type="hidden" name="custId" value="1"/>
		
		<input type="number" name="cartQuantity" value="0" min="0"/>
		<input type="hidden" name="action" value="addCart" />
		<button type="submit" id="cartBtn">장바구니</button>
	</form>
</body>
</html>