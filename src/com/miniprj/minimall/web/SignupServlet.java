package com.miniprj.minimall.web;

import java.io.IOException;

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
			request.setAttribute("action", "insert");
			view = "auth/signupform.jsp";
		}
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		
		if("insert".equals(action)) {
			String cust_name = request.getParameter("cust_name");
			String cust_email = request.getParameter("cust_email");
			String cust_password = request.getParameter("cust_password");
			String cust_phone_num = request.getParameter("cust_phone_num");
			String cust_address = request.getParameter("cust_address");
			CustomerDto customer = new CustomerDto(cust_name, cust_email, cust_password, cust_phone_num, cust_address);
			try {
				dao.insertMember(customer);
				response.sendRedirect("/Login.do");
				return;
			}catch(Exception e) {
				throw new RuntimeException(e);
			}
		}
	}

}
