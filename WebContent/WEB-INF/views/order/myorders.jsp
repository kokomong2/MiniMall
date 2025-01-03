<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 내역</title>
<style>

   /*TABLE*/
   table {
       width: 100%;
       margin-bottom: 20px;
       background-color: transparent;
       box-shadow: none;
       border-collapse: separate;
       border-spacing: 0 20px; /* 셀 간 세로 간격 */
   }
   
   tr {
       background-color: #fff;
   }
   
   td {
       padding: 40px;
       border-top: 1.5px solid #000; /* 위쪽 선 */
       border-bottom: 1.5px solid #000; /* 아래쪽 선 */
   }
   



   
   /*Wrapper*/
    #wrapper {
        margin: 0 auto;
        display: block;
        width: 800px;
    }
    /*A*/
       a {
        text-decoration: none; /* 밑줄 제거 */
        color: black;
    }
    a:hover {
        text-decoration: none;
        color: #21610B;
    }
</style>

</head>
<body>
   <jsp:include page="/WEB-INF/views/header.jsp" />
   
   <main>
      
      <div id="wrapper">
      <h1>구매 내역</h1>
         <c:choose>
             <c:when test="${not empty orderList}">
                 <table>
                     <tbody>
                     <c:forEach var="order" items="${orderList}">
                         <tr>
                             <td style="text-align: left;">
                                <div style="font-size: 20px">${order.orderDate}</div>
                                <br>
                                <div style="color: #585858">배송지 | ${order.orderAddress}</div>
                                <div style="color: #585858">주문 번호 | ${order.orderNum}</div>
                             </td>
                             <td>
                                <a href="/order/Order.do?action=detail&order_num=${order.orderNum}">|  상세 보기   |</a>
                             </td>
                         </tr>
                     </c:forEach>
                     </tbody>
                 </table>
             </c:when>
             <c:otherwise>
                 <p>구매 내역이 없습니다.</p>
             </c:otherwise>
         </c:choose>
      </div>
   </main>
   
   <jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>
