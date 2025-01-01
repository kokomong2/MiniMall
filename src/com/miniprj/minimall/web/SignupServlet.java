package com.miniprj.minimall.web;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.miniprj.minimall.dao.CustomerDao;
import com.miniprj.minimall.model.CustomerDto;

@WebServlet("/auth/Auth.do")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    CustomerDao dao = new CustomerDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		String view = "index.jsp";
		
		if("signupform".equals(action) || action==null) {
			request.setAttribute("action", "signup");
			view = "auth/signupform.jsp";
		} else if("checkemail".equals(action)) {
			String cust_email = request.getParameter("cust_email");
            boolean isEmailUsed = dao.checkEmail(cust_email);
            response.setContentType("application/json");
            response.getWriter().write("{\"emailUsed\": " + isEmailUsed + "}");
            return;
		} else if ("logout".equals(action)) {
        	logout(request,response);
        }
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		
		if("signup".equals(action)) {
			String cust_name = request.getParameter("cust_name");
			String cust_email = request.getParameter("cust_email");
			String cust_password = request.getParameter("cust_password");
			String cust_phone_num = request.getParameter("cust_phone_num");
			String cust_postcode = request.getParameter("cust_postcode");
			String cust_address = request.getParameter("cust_address");
			String cust_detail_address = request.getParameter("cust_detail_address");
			String encryptedPassword = encryptPassword(cust_password);
			CustomerDto customer = new CustomerDto(cust_name, cust_email, encryptedPassword, cust_phone_num, cust_postcode, cust_address, cust_detail_address);
			try {
				dao.signup(customer);
				response.sendRedirect("/auth/Login.do?action=loginform");
				return;
			}catch(Exception e) {
				throw new RuntimeException(e);
			}
		}
	}
	
	private String encryptPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 알고리즘이 지원되지 않습니다.", e);
        }
    }
	
	private void logout(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.getSession().invalidate();
		response.sendRedirect("/index.jsp");
	}

}