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
            List<ProductDto> products = dao.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/views/productlist.jsp").forward(request, response);
        } else if ("detailform".equals(action)) {
            int prodId = Integer.parseInt(request.getParameter("prod_id"));
            ProductDto product = dao.getProductDetail(prodId);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/views/productdetailform.jsp").forward(request, response);
        } else if ("category".equals(action)) {
            String prodCategory = request.getParameter("prod_category");
            List<ProductDto> products = dao.listByCategory(prodCategory);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/views/productlist.jsp").forward(request, response);
        } else if ("search".equals(action)) {
            String searchQuery = request.getParameter("search_query");
            List<ProductDto> products = dao.searchProducts(searchQuery);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/views/productlist.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
