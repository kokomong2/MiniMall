package com.miniprj.minimall.web;

import java.io.IOException;
import java.net.URLEncoder;

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
		}else if("mypage".equals(action)) {
			showMypage(request,response);
		}
		
	}
	
	private void showMypage(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/customer/mypage.jsp");
		dispatcher.forward(request, response);
		
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
		// 세션에서 이메일 가져오기
	    CustomerDto sessionCustomer = (CustomerDto) request.getSession().getAttribute("customer");
	    String cust_email = sessionCustomer.getCust_email();
	    // 수정할 정보 가져오기
		String cust_phone_num = request.getParameter("cust_phone_num");
		String cust_postcode = request.getParameter("cust_postcode");
		String cust_address = request.getParameter("cust_address");
		String cust_detail_address = request.getParameter("cust_detail_address");
		
	    // 업데이트를 위한 CustomerDto 생성
	    CustomerDto updatedCustomer = new CustomerDto(
	        cust_email,
	        cust_phone_num,
	        cust_postcode,
	        cust_address,
	        cust_detail_address
	    );
		response.setContentType("text/html; charset=utf-8");
		
		try {
	        // DB 업데이트 실행
	        customerDao.editCustomerInfo(updatedCustomer);

	        // DB에서 최신 정보 가져오기
	        CustomerDto refreshedCustomer = customerDao.findByEmail(cust_email);

	        // 세션에 최신 정보 저장
	        request.getSession().setAttribute("customer", refreshedCustomer);

	        // 리다이렉트로 수정 완료 페이지로 이동
	        response.sendRedirect("/customer/Customer.do?action=mypageEditForm&functionSuccess=true" 
	        		   + "&title=" + URLEncoder.encode("회원정보 수정에 성공하였습니다.", "UTF-8")
	        		   + "&message=" + URLEncoder.encode("변경된 회원정보를 확인하세요.", "UTF-8")
	        		   + "&redirectUrl=/customer/Customer.do?action=mypageEditForm");
		}catch(Exception e) {
            request.setAttribute("errorMessage", "정보 수정 중 오류가 발생했습니다: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/signupform.jsp");
            dispatcher.forward(request, response);
		}
		
		
		
	}

}