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

@WebServlet("/auth/Login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CustomerDao dao = new CustomerDao();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		String view = "index.jsp";
		
		if("loginform".equals(action) || action==null) {
			request.setAttribute("action", "login");
			view = "auth/loginform.jsp";
		} else if("loginok".equals(action)) {
			view = "auth/loginok.jsp";
		} else if ("logout".equals(action)) {
            session.invalidate(); 
            response.sendRedirect("/Login.do?action=loginform"); 
            return;
        } else if ("checkemail".equals(action)) {
        	view = "auth/loginok.jsp";
        }
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		String view = "loginok.jsp";
		
		if("login".equals(action)) {
			String cust_email = request.getParameter("cust_email");
			String cust_password = request.getParameter("cust_password");
			HttpSession session = request.getSession();
			
			try {
				boolean loginResult = dao.login(cust_email, cust_password);
				
				if(loginResult) { 
					session.setAttribute("cust_email", cust_email);
					System.out.println("로그인이 완료되었습니다.");
					response.sendRedirect("/auth/Login.do?action=loginok");
					return;
				} else {
					request.setAttribute("message", "이메일 또는 비밀번호가 일치하지 않습니다.");
					view = "auth/loginform.jsp";  
				}
			} catch(Exception e) {
				session.invalidate();
				request.setAttribute("message", e.getMessage());
				view = "auth/loginerror.jsp";
			}
		}
		
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/" + view);
		disp.forward(request, response);
	}

}
