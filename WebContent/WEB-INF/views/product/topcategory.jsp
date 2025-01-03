<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/topcategory.css">


<div class="category-container">
    <div class="category-item" onclick="location.href='/product/Product.do?action=list'">
        <img src="https://cdn-icons-png.flaticon.com/512/3580/3580126.png" alt="전체"><br/>
        <span>전체</span>
    </div>
    <div class="category-item" onclick="location.href='/product/Product.do?action=category&prod_main_category=곡물'">
        <img src="https://cdn-icons-png.freepik.com/512/898/898133.png" alt="곡물"><br/>
        <span>곡물</span>
    </div>
    <div class="category-item" onclick="location.href='/product/Product.do?action=category&prod_main_category=과일'">
        <img src="https://cdn-icons-png.flaticon.com/512/2843/2843584.png" alt="과일"><br/>
        <span>과일</span>
    </div>
    <div class="category-item" onclick="location.href='/product/Product.do?action=category&prod_main_category=버섯'">
        <img src="https://cdn-icons-png.flaticon.com/512/263/263888.png" alt="버섯"><br/>
        <span>버섯</span>
    </div>
    <div class="category-item" onclick="location.href='/product/Product.do?action=category&prod_main_category=약재'">
        <img src="https://cdn-icons-png.flaticon.com/256/3186/3186179.png" alt="약재"><br/>
        <span>약재</span>
    </div>
    <div class="category-item" onclick="location.href='/product/Product.do?action=category&prod_main_category=조미료'">
        <img src="https://cdn-icons-png.flaticon.com/512/4725/4725913.png" alt="조미료"><br/>
        <span>조미료</span>
    </div>
        <div class="category-item" onclick="location.href='/product/Product.do?action=category&prod_main_category=채소'">
        <img src="https://cdn-icons-png.flaticon.com/512/6266/6266171.png" alt="채소"><br/>
        <span>채소</span>
    </div>
<!--     <div class="category-item" onclick="location.href='/product/Product.do?action=category&prod_category=기타'">
        <img src="https://via.placeholder.com/50" alt="기타"><br/>
        <span>기타</span>
    </div> -->
</div>
