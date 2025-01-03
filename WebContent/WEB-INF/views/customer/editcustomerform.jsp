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
                if (input.id !== 'cust_name' && input.id !== 'cust_email') {
                    input.disabled = false;
                }
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
        margin: 0;
        display: flex;
        flex-direction: column;
    }

    header, footer {
        flex-shrink: 0;
        color: white;
        text-align: center;
        padding: 1rem;
    }

	main {
		display: flex;
        justify-content: center;
        align-items: center;
    }
    
    .container {
    	width: 100%; 
    	max-width: 600px;  
	}
    
    .field {
    	margin-bottom: 10px;
    }
    
    .edit-container {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
    }

    h1 {
        font-size: 1.8rem;
        margin-bottom: 20px;
        color: #333;
        text-align: center;
    }

	.label {
        display: block;
        font-size: 0.85rem;
        margin-bottom: 0.5rem;
        color: #666;
    }
    
    .edit-form input[type="text"],
    .edit-form input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
    }

    .field input:disabled {
        background-color: #f0f0f0;
        color: #666;
    }
    
    .postcode-field{
        display: flex;
        align-items: center;
    }
    
    .postcode-field input[type="text"]:not([disabled]) {
        width: 78%; 
        margin-right: 10px; 
    }
    
    .postcode-field button {
    	width: 22%; 
        height: 37px;
        background-color: #2e4631; 
    	color: #fff; 
    	border: none;
    	border-radius: 4px;
    	cursor: pointer;
    }
    
    .button-container {
        margin-top: 30px;
    }
    
    #editBtn {
        color: #fff;
        background-color: #2e4631;
        margin-right: 10px;
        width: 100%;
        padding: 0.8rem;
        font-size: 1rem;
        border-radius: 4px;
        cursor: pointer;
    }

    #editBtn:hover {
        background-color: #243626;
    }
    
    .button-group {
    	display: flex;
        justify-content: space-between;
        margin-top: 30px;
    }
    
    #saveBtn, #backBtn {
        width: 100%;
        padding: 0.8rem;
        font-size: 1rem;
        border-radius: 4px;
        cursor: pointer;
    }

    #saveBtn {
        color: #fff;
        background-color: #2e4631;
        border: none;
        margin-right: 10px;
    }

    #saveBtn:hover {
        background-color: #243626;
    }

    #backBtn {
        background-color: #fff;
        border: 1px solid #2e4631;
        color: #2e4631;
    }

    #backBtn:hover {
        background-color: #f3f3f3;
    }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/header.jsp" />

<main>
<div class="container">
    <div class="edit-container">
    	<h1>정보 수정</h1>
    	<form action="/customer/Customer.do?action=mypageEdit" method="post" onsubmit="validateForm(event)" class="edit-form">
        <%
        	// 세션에서 사용자 정보를 가져옴
            CustomerDto customer = (CustomerDto) session.getAttribute("customer");
            if (customer != null) {
        %>
        <div class="field">
    		<label class="label" for="cust_name">이름</label>
    		<input type="text" id="cust_name" value="<%= customer.getCust_name() %>" disabled>
		</div>
		<div class="field">
    		<label class="label" for="cust_email">이메일</label>
    		<input type="text" id="cust_email" value="<%= customer.getCust_email() %>" disabled>
		</div>
		<div class="field">
            <label class="label" for="cust_phone_num">연락처</label>
            <input type="text" id="cust_phone_num" name="cust_phone_num" value="<%= customer.getCust_phone_num() %>" disabled>
        </div>
        <div class="field">
            <label class="label" for="sample6_postcode">우편번호</label>
            <div class="postcode-field">
            	<input type="text" id="sample6_postcode" name="cust_postcode" size="50" value="<%= customer.getCust_postcode() %>" disabled>
            	<button type="button" id="postcodeBtn" onclick="sample6_execDaumPostcode()" style="display: none;">우편번호 찾기</button>
        	</div>
        </div>
        <div class="field">
            <label class="label" for="sample6_address">주소</label>
            <input type="text" id="sample6_address" name="cust_address" size="50" value="<%= customer.getCust_address() %>" disabled>
        </div>
        <div class="field">
            <label class="label" for="sample6_detailAddress">상세주소</label>
            <input type="text" id="sample6_detailAddress" name="cust_detail_address" value="<%= customer.getCust_detail_address() %>" disabled>
        </div>
        
        <div class="button-container">
        	<button type="button" id="editBtn" onclick="enableEditing()">수정</button>
        	<div class="button-group">
            	<button type="submit" id="saveBtn" style="display: none;">저장</button>
            	<button type="button" id="backBtn" onclick="cancelEditing()" style="display: none;">취소</button>
        	</div>
        </div>
        
        <%
            }
        %>
        </form>   
  	</div>
</div>
</main>

<jsp:include page="/WEB-INF/views/footer.jsp" />
<jsp:include page="/WEB-INF/successModalForward.jsp" />
</body>
</html>