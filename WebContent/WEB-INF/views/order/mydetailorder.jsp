<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>주문 상세 내역</title>
<style>
    table {
        width: 100%;
        margin-bottom: 20px;
        background-color: transparent;
        border-collapse: separate;
        border-spacing: 0 20px;
    }
    tr {
        background-color: #fff;
    }
    td {
        padding: 20px;
        border-top: 1.5px solid #000;
        border-bottom: 1.5px solid #000;
    }
    img {
        height: 130px;
        width: 130px;
    }
    #wrapper {
        margin: 0 auto;
        display: block;
        width: 700px;
    }
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/header.jsp" />
    <main>
        <div id="wrapper">
            <h1>주문 상세 내역</h1>
            <p style="color:#6E6E6E">주문 번호: ${orderNum}</p>
            <p style="color:#6E6E6E">배송지: ${orderAddress}</p>
            <br>
            <div style="font-size:20px; font-weight: bold;">주문 상품</div>
            <c:choose>
                <c:when test="${not empty detailList}">
                    <table>
                        <tbody>
                            <c:forEach var="detail" items="${detailList}">
                                <tr>
                                    <td>
                                        <a href="/product/Product.do?action=detailform&prod_id=${detail.prodId}">
                                            <img src="${detail.product.prodImageUrl}" alt="Product Image">
                                        </a>
                                    </td>
                                    <td style="text-align:left">
                                        <div style="font-size:13px; margin-bottom: 5px;">No. ${detail.prodId}</div>
                                        <div style="font-weight: bold; margin-bottom: 5px;">${detail.product.prodGoodsName}</div>
                                        
                                    </td>
                                    <td>X ${detail.orderCount}</td>
                                    <td>
                                        <fmt:formatNumber value="${detail.orderPrice}" type="number" groupingUsed="true" /> 원
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>주문 상세 내역이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>