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
<title>주문 내역</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f0f4f8;
	display: flex;
	flex-direction: column; /* 세로 방향 정렬 */
	min-height: 100vh; /* 전체 화면 높이 */
	color: #333;
}

.order-card {
	background-color: #fff;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
	border-radius: 12px;
	padding: 30px;
	max-width: 800px;
	width: 100%;
	text-align: center;
	margin: auto; /* 세로로 가운데 정렬 */
	flex-grow: 1; /* 메인 콘텐츠 영역 확장 */
}

.order-card h2 {
	color: #444;
	margin-bottom: 20px;
	font-size: 24px;
	font-weight: 600;
}

.order-card .order-detail {
	margin: 15px 0;
	font-size: 16px;
}

.order-card .order-detail label {
	font-weight: bold;
	margin-right: 10px;
}

.order-card .order-detail p {
	color: #555;
	margin: 5px 0;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	text-align: center;
	border: 1px solid #ddd;
	font-size: 16px;
}

th {
	background-color: #007bff;
	color: white;
	font-weight: bold;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

.order-summary {
	background-color: #f4f7fa;
	padding: 20px;
	margin-top: 30px;
	border-radius: 8px;
	text-align: left;
	font-size: 16px;
}

.order-summary .total {
	font-weight: bold;
	font-size: 20px;
	color: #333;
	margin-top: 20px;
}

.order-card button {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 12px 25px;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
	margin-top: 20px;
	transition: background-color 0.3s;
}

.order-card button:hover {
	background-color: #218838;
}

.message {
	font-size: 18px;
	font-weight: 500;
	color: #28a745;
	margin-top: 15px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="order-card">
		<h2>주문 확인</h2>
		<p class="message">${message}</p>

		<table>
			<thead>
				<tr>
					<th>주문번호</th>
					<th>상품 ID</th>
					<th>수량</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="order" items="${orderList}">
					<tr>
						<td>${order.orderNum}</td>
						<td>${order.prodId}</td>
						<td>${order.orderCount}</td>
						<td>${order.orderAddress}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<button onclick="location.href='/'">주문 완료</button>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<jsp:include page="/WEB-INF/views/footer.jsp" />

</body>
</html>