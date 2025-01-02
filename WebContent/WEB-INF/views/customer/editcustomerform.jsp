<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.miniprj.minimall.model.CustomerDto" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>정보 수정</title>
    <!-- Daum API 스크립트 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        let originalValues = {};

        function enableEditing() {
            document.querySelectorAll('.field input').forEach(input => {
                originalValues[input.id] = input.value;
                input.disabled = false;
            });
            document.getElementById('saveBtn').style.display = 'inline';
            document.getElementById('editBtn').style.display = 'none';
            document.getElementById('backBtn').style.display = 'inline';
            document.getElementById('postcodeBtn').style.display = 'inline';

            const phoneField = document.querySelector('input[name="cust_phone_num"]');
            phoneField.addEventListener('blur', validatePhoneNumber);
        }

        function validatePhoneNumber() {
            const phoneField = document.querySelector('input[name="cust_phone_num"]');
            const phoneMessage = document.createElement('span');
            const phoneRegex = /^01([0|1|6|7|8|9])-\d{3,4}-\d{4}$/;

            // 기존 메시지 제거
            if (phoneField.nextSibling) {
                phoneField.nextSibling.remove();
            }

            // 유효성 검사
            if (!phoneRegex.test(phoneField.value)) {
                phoneMessage.textContent = "유효하지 않은 연락처 형식입니다.";
                phoneMessage.style.color = "red";
                phoneField.insertAdjacentElement('afterend', phoneMessage);
                return false; // 유효하지 않음
            } else {
                phoneMessage.textContent = "올바른 연락처 형식입니다.";
                phoneMessage.style.color = "green";
                phoneField.insertAdjacentElement('afterend', phoneMessage);
                return true; // 유효함
            }
        }

        function validateForm(event) {
            // 전화번호 유효성 검사
            const isPhoneValid = validatePhoneNumber();

            if (!isPhoneValid) {
                event.preventDefault(); // 폼 제출 방지
                alert("전화번호 형식을 올바르게 입력하세요.");
            }
        }

        function cancelEditing() {
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
                    var addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById('sample6_address').value = addr;
                    document.getElementById('sample6_detailAddress').focus();
                }
            }).open();
        }
    </script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding-top: 4rem; /* 헤더 높이 */
            padding-bottom: 4rem; /* 푸터 높이 */
        }

        h1 {
            text-align: center;
            margin: 2rem 0;
            font-size: 1.8rem;
            color: #333;
        }

        table {
            width: 70%;
            margin: 0 auto;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        td {
            padding: 10px;
            vertical-align: middle;
        }

        .label {
            text-align: right;
            font-weight: bold;
            width: 25%;
            color: #333;
        }

        .field input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
            font-size: 0.95rem;
        }

        .field input:disabled {
            background-color: #f0f0f0;
            color: #666;
        }

        .button-group {
            text-align: center;
            margin-top: 20px;
        }

        .button-group button {
            padding: 10px 20px;
            font-size: 1rem;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        #editBtn {
            background-color: #007bff;
            color: #fff;
        }

        #editBtn:hover {
            background-color: #0056b3;
        }

        #saveBtn {
            background-color: #28a745;
            color: #fff;
        }

        #saveBtn:hover {
            background-color: #218838;
        }

        #backBtn {
            background-color: #dc3545;
            color: #fff;
        }

        #backBtn:hover {
            background-color: #c82333;
        }

        #postcodeBtn {
            background-color: #6c757d;
            color: #fff;
        }

        #postcodeBtn:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/header.jsp" />

    <main>
        <form action="/customer/Customer.do?action=mypageEdit" method="post" onsubmit="validateForm(event)">
            <%
                // 세션에서 사용자 정보를 가져옴
                CustomerDto customer = (CustomerDto) session.getAttribute("customer");
                if (customer != null) {
            %>
            <h1>정보 수정</h1>
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
                        <input type="text" id="sample6_postcode" name="cust_postcode" value="<%= customer.getCust_postcode() %>" disabled>
                    </td>
                    <td>
                        <button type="button" id="postcodeBtn" onclick="sample6_execDaumPostcode()" style="display: none;">우편번호 찾기</button>
                    </td>
                </tr>
                <tr>
                    <td class="label">주소</td>
                    <td class="field" colspan="2">
                        <input type="text" id="sample6_address" name="cust_address" value="<%= customer.getCust_address() %>" disabled>
                    </td>
                </tr>
                <tr>
                    <td class="label">상세주소</td>
                    <td class="field" colspan="2">
                        <input type="text" id="sample6_detailAddress" name="cust_detail_address" value="<%= customer.getCust_detail_address() %>" disabled>
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
    </main>

    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />
    
</body>
</html>
