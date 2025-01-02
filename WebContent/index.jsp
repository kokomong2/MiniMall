<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>농산물 마켓</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            background-color: #f9f9f9;
        }

        main {
            padding: 2rem;
        }

        h1 {
            text-align: center;
            margin-bottom: 1rem;
        }

        .category-container, .products-container {
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/header.jsp" />

    <!-- 메인 콘텐츠 -->
    <main>
        <h1>Top Category</h1>
        <jsp:include page="/WEB-INF/views/product/topcategory.jsp" />

        <h1>Daily Best Sell</h1>
        <jsp:include page="/WEB-INF/views/product/dailybestsell.jsp" />
    </main>

    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>
