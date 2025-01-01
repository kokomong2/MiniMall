<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.miniprj.minimall.model.CustomerDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
<!-- Daum API 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    let originalValues = {};

    function enableEditing() {
        // 기존 값을 저장
        document.querySelectorAll('.field input').forEach(input => {
            originalValues[input.id] = input.value;
            input.disabled = false; // input 필드를 활성화
        });
        document.getElementById('saveBtn').style.display = 'inline';
        document.getElementById('editBtn').style.display = 'none';
        document.getElementById('backBtn').style.display = 'inline';
        document.getElementById('postcodeBtn').style.display = 'inline';
    }

    function cancelEditing() {
        // 우편번호 버튼과 모든 필드를 비활성화
        document.querySelectorAll('.field input').forEach(input => {
            input.value = originalValues[input.id] || '';
            input.disabled = true;
        });
        document.getElementById('saveBtn').style.display = 'none';
        document.getElementById('editBtn').style.display = 'inline';
        document.getElementById('backBtn').style.display = 'none';
        document.getElementById('postcodeBtn').style.display = 'none';
    }

    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = '';
                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById('sample6_address').value = addr;
                document.getElementById('sample6_detailAddress').focus();
            }
        }).open();
    }
</script>
<style>
    table {
        width: 60%;
        margin: 20px auto;
        border-collapse: collapse;
    }
    td {
        padding: 10px;
        vertical-align: middle;
    }
    .label {
        text-align: right;
        font-weight: bold;
        width: 20%;
    }
    .field input {
        width: 100%;
        padding: 5px;
    }
    .button-group {
        text-align: center;
        margin-top: 20px;
    }
</style>
</head>
<body>
<form action="/customer/Customer.do?action=mypageEdit" method="post">
<%
    // 세션에서 사용자 정보를 가져옴
    CustomerDto customer = (CustomerDto) session.getAttribute("customer");
    if (customer != null) {
%>
<h1 style="text-align: center;">정보 수정</h1>
<table>
    <tr>
        <td class="label">이름</td>
        <td><%= customer.getCust_name() %></td>
    </tr>
    <tr>
        <td class="label">이메일</td>
        <td><%= customer.getCust_email() %></td>
    </tr>
    <tr>
        <td class="label">연락처</td>
        <td class="field">
            <input type="text" id="cust_phone_num" name="cust_phone_num" value="<%= customer.getCust_phone_num() %>" disabled>
        </td>
    </tr>
    <tr>
        <td class="label">우편번호</td>
        <td class="field">
            <input type="text" id="sample6_postcode" name="cust_postcode" placeholder="우편번호" value="<%= customer.getCust_postcode() %>" disabled>
        </td>
        <td>
            <input type="button" id="postcodeBtn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="display: none;">
        </td>
    </tr>
    <tr>
        <td class="label">주소</td>
        <td class="field" colspan="2">
            <input type="text" id="sample6_address" name="cust_address" placeholder="주소" value="<%= customer.getCust_address() %>" disabled>
        </td>
    </tr>
    <tr>
        <td class="label">상세주소</td>
        <td class="field" colspan="2">
            <input type="text" id="sample6_detailAddress" name="cust_detail_address" placeholder="상세주소" value="<%= customer.getCust_detail_address() %>" disabled>
        </td>
    </tr>
</table>
<div class="button-group">
    <button type="button" id="editBtn" onclick="enableEditing()">수정</button>
    <button type="submit" id="saveBtn" style="display: none;">저장</button>
    <button type="button" id="backBtn" onclick="cancelEditing()" style="display: none;">취소</button>
</div>
<%
    }
%>
</form>
</body>
</html>
