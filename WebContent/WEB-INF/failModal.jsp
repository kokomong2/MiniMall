<%@ page contentType="text/html; charset=UTF-8" %>
<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
    }
    .modal-content {
        background-color: #fefefe;
        padding: 20px;
        width: 80%;
        max-width: 400px;
        text-align: center;
        position: absolute;
        top: 50%; 
        left: 50%;
        transform: translate(-50%, -50%);
        border-radius: 8px; 
    }
    .close {
        color: #aaa;
        font-size: 28px;
        font-weight: ;
        cursor: pointer;
        position: absolute; 
        top: 15px;
        right: 20px;
    }
    .modal-img {
    	width: 70px;
    	height: 70px;
    	margin-top: 10px;
    }
    .ok-btn {
    	background-color: #ffa500;
    	border: 1px solid #ffa500;
    	border-radius: 4px;
    	color: #fff;
    	width: 100%;
    	padding: 0.5rem;
    	margin-top: 10px;
    	font-size: 0.9rem;
    }
</style>

<div id="failModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <img src="/img/fail.png" alt="실패 이미지" class="modal-img">
        <h3>${title}</h3><br>
        <p>${message}</p>
        <button id="redirectLogin" class="ok-btn">확인</button>
    </div>
    
</div>

<script>
    function showFailModal() {
        var modal = document.getElementById("failModal");
        var closeBtn = document.getElementsByClassName("close")[0];
        var redirectLoginBtn = document.getElementById("redirectLogin");

        modal.style.display = "block";

        redirectLoginBtn.onclick = function() {
        	var redirectUrl = '${redirectUrl}';  
            window.location.href = redirectUrl;
        };

        closeBtn.onclick = function() {
            modal.style.display = "none";
        };

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        if ('${functionFail}' == 'true') {
            showFailModal();
        } 
    });
</script>