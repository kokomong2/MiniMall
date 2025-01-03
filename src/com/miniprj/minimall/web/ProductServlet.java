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

    private final ProductDao dao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "list":
                    handleList(request, response);
                    break;
                case "detailform":
                    handleDetailForm(request, response);
                    break;
                case "category":
                    handleCategory(request, response);
                    break;
                case "search":
                    handleSearch(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ProductDto> products = dao.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/productlist.jsp").forward(request, response);
    }

    private void handleDetailForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int prodId = Integer.parseInt(request.getParameter("prod_id"));
            ProductDto product = dao.getProductDetail(prodId);
            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("/WEB-INF/views/productdetailform.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }

    private void handleCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String prodCategory = request.getParameter("prod_category");
        List<ProductDto> products = dao.listByCategory(prodCategory);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/productlist.jsp").forward(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchQuery = request.getParameter("search_query");
        List<ProductDto> products = dao.searchProducts(searchQuery);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/productlist.jsp").forward(request, response);
    }
}
