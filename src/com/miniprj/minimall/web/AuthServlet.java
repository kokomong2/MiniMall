package com.miniprj.minimall.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.miniprj.minimall.dao.CustomerDao;
import com.miniprj.minimall.model.CustomerDto;

@WebServlet("/auth/Auth.do")
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	CustomerDao customerDao = new CustomerDao();
	
	public void init(ServletConfig config) throws ServletException {
		customerDao = new CustomerDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

        if ("signupform".equals(action)) {
            showSignupForm(request, response);
        } else if ("loginform".equals(action)) {
            showLoginForm(request, response);
        } else if ("logout".equals(action)) {
        	logout(request,response);
        }
        else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid action");
        }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if ("signup".equals(action) ) {
			signup(request, response);
		} else if("login".equals(action)) {
			login(request, response);
		} else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid action" );
		}
	}
	
	// 회원 가입 폼
	private void showSignupForm(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/signupform.jsp");
		dispatcher.forward(request, response);
	}
	
	// 로그인 폼
	private void showLoginForm(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/loginform.jsp");
		dispatcher.forward(request, response);
	}
	
	// 회원 가입  하기
	private void signup(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // 나중에 필터에서 한번에 설정.
		String cust_name = request.getParameter("cust_name"); 
		String cust_email = request.getParameter("cust_email");
		String cust_password = request.getParameter("cust_password");
		String cust_phone_num = request.getParameter("cust_phone_num");
		String cust_postcode = request.getParameter("cust_postcode");
		String cust_address = request.getParameter("cust_address");
		String cust_detail_address = request.getParameter("cust_detail_address");
		
		CustomerDto customer = new CustomerDto(cust_name, cust_email, cust_password, cust_phone_num, cust_postcode, cust_address, cust_detail_address);
		
		response.setContentType("text/html; charset=utf-8");
		
		try {
			System.out.println("cust_name: " + cust_name); // 인코딩 확인용
			System.out.println("cust_address: " + cust_address); // 인코딩 확인용

			customerDao.sinup(customer);
			response.sendRedirect("/auth/Auth.do?action=loginform");
		}catch(Exception e) {
            request.setAttribute("errorMessage", "회원가입 중 오류가 발생했습니다: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/signupform.jsp");
            dispatcher.forward(request, response);
		}
	}
	
	// 로그인 하기
	private void login(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // 후에 필터처리
		String cust_email = request.getParameter("cust_email");
		String cust_password = request.getParameter("cust_password");
		
		try {
			CustomerDto customer = customerDao.findbyEmailAndPassword(cust_email, cust_password);
			if(customer != null) {
				request.getSession().setAttribute("customer", customer);
				response.sendRedirect("/index.jsp");
			} else {
				request.setAttribute("errorMessage",  "로그인 정보가 올바르지 않습니다.");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/loginform.jsp");
				dispatcher.forward(request, response);
			}
			}
			catch (Exception e) {
	            request.setAttribute("errorMessage", "로그인 중 오류가 발생했습니다: " + e.getMessage());
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/index.jsp");
	            dispatcher.forward(request, response);
	        }
	}
	
	private void logout(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.getSession().invalidate();
		response.sendRedirect("/index.jsp");
	}
	
	
	}

