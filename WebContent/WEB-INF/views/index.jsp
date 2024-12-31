<%@ page contentType="text/html; charset=UTF-8"
		 import="java.util.Date, 
		         java.util.Random,
		         java.util.Enumeration"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome page</title>
</head>

<body>
<c:forEach var="i" begin="0" end="10">
${i} 
</c:forEach>
<%@ include file="header.jsp" %>
<a href="<c:url value='/Login.do'/>">로그인</a>
<c:url value="/member/Member.do" var="memberInsert" scope="page"/>
<a href="${memberInsert}">회원가입</a>
<a href="/member/Member.do?action=select">회원정보 수정</a>
<a href="/member/Member.do?action=delete">회원정보 삭제</a><br>
<%
out.println(new Date() + "<br>");
out.println(new Random().nextInt());
%><br>
RemoteAddr: <%= request.getRemoteAddr() %><br>
URI: <%= request.getRequestURI() %><br>
URL: <%= request.getRequestURL() %><br>
<%
Enumeration<String> headerNames = request.getHeaderNames();
while(headerNames.hasMoreElements()) {
	String headerName = headerNames.nextElement();
	String headerValue = request.getHeader(headerName);
	out.println(headerName + ": " + headerValue + "<br>");
}
%>
<jsp:include page="footer.jsp"/>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="https://www.naver.com"/> --%>
</body>
</html>