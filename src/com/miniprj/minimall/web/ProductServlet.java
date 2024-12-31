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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 데이터 가져오기
        List<ProductDto> products = dao.getAllProducts();
        
        // 데이터를 요청 객체에 저장
        request.setAttribute("products", products);

        // JSP로 요청 포워딩
        request.getRequestDispatcher("/WEB-INF/views/productList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
