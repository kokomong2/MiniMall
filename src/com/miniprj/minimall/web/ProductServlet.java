package com.miniprj.minimall.web;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.miniprj.minimall.dao.ProductDao;
import com.miniprj.minimall.model.ProductDto;

@WebServlet("/product/Product.do")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ProductDao dao = new ProductDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("list".equals(action)) {
			// 데이터 가져오기
			List<ProductDto> products = dao.getAllProducts();

			// 데이터를 요청 객체에 저장
			request.setAttribute("products", products);

			// JSP로 요청 포워딩
			request.getRequestDispatcher("/WEB-INF/views/productList.jsp").forward(request, response);
		}
		if ("detailform".equals(action)) {
			
			int prod_id = Integer.parseInt(request.getParameter("prod_id"));
			
			ProductDto product = dao.getProductDetail(prod_id);
			
			request.setAttribute("product", product);

			// 상품 상세 정보 JSP로 포워딩
			request.getRequestDispatcher("/WEB-INF/views/productdetailform.jsp").forward(request, response);
		}

			
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
