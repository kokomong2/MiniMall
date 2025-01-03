// 이메일 유효성 검사
function validateEmail() {
    const emailField = document.getElementById('cust_email');
    const emailMessage = document.createElement('span');
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (emailField.nextSibling && emailField.nextSibling.tagName === "SPAN") {
        emailField.nextSibling.remove();
    }
  
    if (!emailRegex.test(emailField.value)) {
    	emailMessage.textContent = "유효하지 않은 이메일 형식입니다.";
        emailMessage.style.color = "red";
    }
    
    emailField.insertAdjacentElement('afterend', emailMessage);
}

// 비밀번호 유효성 검사
function validatePassword() {
    const passwordField = document.querySelector('input[name="cust_password"]');
    const password = passwordField.value;
    const passwordMessage = document.createElement('span');
    const passwordCriteria = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;

    if (passwordField.nextSibling) {
        passwordField.nextSibling.remove();
    }

    if (!passwordCriteria.test(password)) {
    	passwordMessage.textContent = "비밀번호는 8자 이상, 문자, 숫자, 특수문자를 포함해야 합니다.";
        passwordMessage.style.color = "red";
    } 

    passwordField.insertAdjacentElement('afterend', passwordMessage);
}

// 비밀번호 일치 여부
function matchPassword() {
    const passwordField = document.querySelector('input[name="cust_password"]');
    const confirmPasswordField = document.querySelector('input[name="cust_confirm_password"]');
    const password = passwordField.value;
    const confirmPassword = confirmPasswordField.value;
    const matchMessage = document.createElement('span');
    
    if (confirmPasswordField.nextSibling) {
        confirmPasswordField.nextSibling.remove();
    }
    
    if (password === confirmPassword) {
        matchMessage.textContent = "비밀번호가 일치합니다.";
        matchMessage.style.color = "green";
    } else {
        matchMessage.textContent = "비밀번호가 일치하지 않습니다.";
        matchMessage.style.color = "red";
    }
    
    // 비밀번호 확인 입력 필드 뒤에 메시지 삽입
    confirmPasswordField.insertAdjacentElement('afterend', matchMessage);
}

// 핸드폰 번호 유효성 검사
function validatePhoneNumber() {
    const phoneField = document.querySelector('input[name="cust_phone_num"]');
    const phoneMessage = document.createElement('span');
    const phoneRegex = /^01([0|1|6|7|8|9])-\d{3,4}-\d{4}$/;

    if (phoneField.nextSibling) {
        phoneField.nextSibling.remove();
    }

    if (!phoneRegex.test(phoneField.value)) {
    	phoneMessage.textContent = "유효하지 않은 연락처 형식입니다.";
        phoneMessage.style.color = "red";
    } 

    phoneField.insertAdjacentElement('afterend', phoneMessage);
}

window.onload = function() {
    document.querySelector('input[name="cust_email"]').addEventListener('blur', validateEmail);
    document.querySelector('input[name="cust_password"]').addEventListener('blur', validatePassword);
    document.querySelector('input[name="cust_confirm_password"]').addEventListener('blur', matchPassword);
    document.querySelector('input[name="cust_phone_num"]').addEventListener('blur', validatePhoneNumber);
};0