package com.miniprj.minimall.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.miniprj.minimall.dao.CustomerDao;
import com.miniprj.minimall.model.CustomerDto;

@WebServlet("/customer/Customer.do")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	CustomerDao customerDao = new CustomerDao();
	
	public void init(ServletConfig config) throws ServletException {
		customerDao = new CustomerDao();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if ("mypageEditForm".equals(action)) {
			showEditCustomerForm(request, response);
		}
	}
	
	// 내 정보 수정 폼
	private void showEditCustomerForm(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/customer/editcustomerform.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if("mypageEdit".equals(action)) {
			mypageEdit(request,response);
		}
	}


	private void mypageEdit(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		
		String cust_email = ((CustomerDto) request.getSession().getAttribute("customer")).getCust_email();
		String cust_phone_num = request.getParameter("cust_phone_num");
		String cust_postcode = request.getParameter("cust_postcode");
		String cust_address = request.getParameter("cust_address");
		String cust_detail_address = request.getParameter("cust_detail_address");
		
		CustomerDto customer = new CustomerDto(cust_email,cust_phone_num, cust_postcode, cust_address, cust_detail_address);
		response.setContentType("text/html; charset=utf-8");
		
		try {
			customerDao.editCustomerInfo(customer);
			response.sendRedirect("/customer/Customer.do?action=mypageEditForm");
		}catch(Exception e) {
            request.setAttribute("errorMessage", "회원가입 중 오류가 발생했습니다: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/signupform.jsp");
            dispatcher.forward(request, response);
		}
		
		
		
	}

}
