function checkEmail() {
    var email = document.getElementById("cust_email").value;
    var resultSpan = document.getElementById("emailCheckResult");
    var emailInput = document.getElementById("cust_email");

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/auth/Auth.do?action=checkemail&cust_email=" + encodeURIComponent(email), true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            if (response.emailUsed) {
                resultSpan.innerText = "이미 존재하는 이메일입니다.";
                resultSpan.style.color = "red";
                emailInput.value = "";
            } else {
                resultSpan.innerText = "사용 가능한 이메일입니다.";
                resultSpan.style.color = "green";
            }
        }
    };
    xhr.send();
    return false;  
}