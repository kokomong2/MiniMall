package com.miniprj.minimall.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.miniprj.minimall.dao.MemberDao;

@WebServlet({ "/LoginServlet", "/auth/Login.do" })
public class LoginServlet extends HttpServlet {
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 세션을 얻어옴
	    HttpSession session = request.getSession();
	    
	    // 세션에 사용자 이름이 존재하면 인덱스 페이지로 리다이렉트
	    String cust_name = (String) session.getAttribute("cust_name");
	    
	    if (cust_name != null) {
	        // 이미 로그인된 상태라면 인덱스 페이지로
	        RequestDispatcher disp = request.getRequestDispatcher("/index.jsp");
	        disp.forward(request, response);
	    } else {
	        // 세션에 사용자 이름이 없다면 로그인 폼 페이지로
	        RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/auth/loginform.jsp");
	        disp.forward(request, response);
	    }
	}




	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cust_name = request.getParameter("cust_name");
		String cust_password = request.getParameter("cust_password");
		MemberDao dao = new MemberDao();
		HttpSession session = request.getSession();
		String url ="/index.jsp";
		
		try {
			String dbpw = dao.Login(cust_name);
			if(dbpw.equals(cust_password)) {
				session.setAttribute("cust_name", cust_name);
				request.setAttribute("messge", cust_name+"님 환영합니다.");
				url="/index.jsp";
			}else {
				session.invalidate();
				request.setAttribute("message", "비밀번호가 다릅니다.");
				url="/index.jsp";				
			}
		} catch (Exception e) {
			session.invalidate();
			request.setAttribute("message", e.getMessage());
			url="/index.jsp";
		}
		RequestDispatcher disp = request.getRequestDispatcher(url);
		disp.forward(request, response);
		
	
	}

}
