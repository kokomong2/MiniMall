package com.miniprj.minimall.web;

import java.io.IOException;
import java.util.List;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.miniprj.minimall.dao.ProductDao;
import com.miniprj.minimall.model.ProductDto;

@WebServlet({ "/ProductServlet", "/product/Product.do" })
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDao dao = new ProductDao();
        List<ProductDto> productList = dao.productlist(); // 수정된 부분: List<ProductDto> 반환

        // 데이터를 JSP로 전달
        request.setAttribute("productList", productList);
        
        // UTF-8 설정
        response.setContentType("text/html; charset=UTF-8");

        // JSP로 포워드
        RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/product/productlist.jsp");
        disp.forward(request, response);
    }
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
