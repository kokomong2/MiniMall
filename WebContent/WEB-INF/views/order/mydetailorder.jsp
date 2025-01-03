<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 내역</title>
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
        <h1>주문 상세 내역</h1>
        <p>주문 번호: ${orderNum}</p>
        
        <c:choose>
            <c:when test="${not empty detailList}">
                <table>
                    <thead>
                        <tr>
                            <th>상품 ID</th>
                            <th>상품명</th>
                            <th>수량</th>
                            <th>가격</th>
                            <th>배송지</th>
                        </tr>
                    </thead>
                    <tbody>
						<c:forEach var="detail" items="${detailList}">
						    <tr>
						        <td>${detail.prodId}</td>
						        <td>${detail.product.prodGoodsName}</td>
						        <td>${detail.orderCount}</td>
						        <td>${detail.orderPrice}</td>
						        <td>${detail.orderAddress}</td>
						    </tr>
						</c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>주문 상세 내역이 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </main>
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>
