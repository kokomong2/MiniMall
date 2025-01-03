<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 내역</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }
    th, td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #f4f4f4;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" />
	
	<main>
		<h1>구매 내역</h1>
		
		<c:choose>
		    <c:when test="${not empty orderList}">
		        <table>
		            <thead>
		                <tr>
		                    <th>주문 번호</th>
		                    <th>주문 날짜</th>
		                    <th>배송지</th>
		                    <th>상세 보기</th>
		                </tr>
		            </thead>
		            <tbody>
						<c:forEach var="order" items="${orderList}">
						    <tr>
						        <td>${order.orderNum}</td>
						        <td>${order.orderDate}</td>
						        <td>${order.orderAddress}</td>
						        <td><a href="/order/Order.do?action=detail&order_num=${order.orderNum}">상세 보기</a></td>
						    </tr>
						</c:forEach>
		            </tbody>
		        </table>
		    </c:when>
		    <c:otherwise>
		        <p>구매 내역이 없습니다.</p>
		    </c:otherwise>
		</c:choose>
	</main>
	
	<jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>
