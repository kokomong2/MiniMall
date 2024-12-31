package com.miniprj.minimall.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.miniprj.minimall.dao.MemberDao;
import com.miniprj.minimall.model.MemberDto;

@WebServlet({ "/MemberServlet", "/auth/Auth.do" })
public class MemberServlet extends HttpServlet {
	MemberDao dao;

	@Override
	public void init() throws ServletException {
		dao = new MemberDao();
		super.init();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원가입 페이지로 자동 포워딩
		RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/auth/signup.jsp");
		disp.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String cust_name = request.getParameter("cust_name");
		String cust_email = request.getParameter("cust_email");
		String cust_password = request.getParameter("cust_password");
		String cust_phone_num = request.getParameter("cust_phone_num");
		String cust_address = request.getParameter("cust_address");

		MemberDto member = new MemberDto();
		member.setCust_name(cust_name);
		member.setCust_email(cust_email);
		member.setCust_password(cust_password);
		member.setCust_phone_num(cust_phone_num);
		member.setCust_address(cust_address);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		try {
			dao.insertMember(member);
			out.println("저장되었습니다.");
		} catch (Exception e) {
			out.println("에러  "+e.getMessage());
		}


	}

}

