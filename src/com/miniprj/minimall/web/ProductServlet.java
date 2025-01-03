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
            request.getRequestDispatcher("/WEB-INF/views/product/productlist.jsp").forward(request, response);
        } else if ("detailform".equals(action)) {
            int prodId = Integer.parseInt(request.getParameter("prod_id"));
            ProductDto product = dao.getProductDetail(prodId);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/views/product/productdetailform.jsp").forward(request, response);
        }else if ("category".equals(action)) {
			String mainCategory = request.getParameter("prod_main_category");
			String subCategory = request.getParameter("prod_sub_category");

			List<ProductDto> products = dao.listByCategory(mainCategory, subCategory);

			List<String> subCategories = null;
			if (mainCategory != null && !mainCategory.isEmpty() && !"기타".equals(mainCategory)) {
				subCategories = dao.getSubCategories(mainCategory);
			}

			request.setAttribute("products", products);
			request.setAttribute("selectedMainCategory", mainCategory);
			request.setAttribute("selectedSubCategory", subCategory);
			request.setAttribute("subCategories", subCategories);
			request.getRequestDispatcher("/WEB-INF/views/product/productlist.jsp").forward(request, response);
		} else if ("search".equals(action)) {
			String searchQuery = request.getParameter("search_query");
			List<ProductDto> products = dao.searchProducts(searchQuery);
			request.setAttribute("products", products);
			request.getRequestDispatcher("/WEB-INF/views/product/productlist.jsp").forward(request, response);
		} else if ("getSubCategories".equals(action)) {
			String mainCategory = request.getParameter("main_category");
			List<String> subCategories = dao.getSubCategories(mainCategory);

			response.setContentType("application/json; charset=UTF-8");
			StringBuilder json = new StringBuilder("[");
			for (int i = 0; i < subCategories.size(); i++) {
				json.append("\"").append(subCategories.get(i)).append("\"");
				if (i < subCategories.size() - 1) {
					json.append(",");
				}
			}
			json.append("]");
			response.getWriter().write(json.toString());
		} else if ("bestsell".equals(action)) {
	        // 최다 구매 상품 데이터 가져오기
	        List<ProductDto> topSellingProducts = dao.getTopSellingProducts();
	        request.setAttribute("topSellingProducts", topSellingProducts);
	        request.getRequestDispatcher("/WEB-INF/views/product/dailybestsell.jsp").forward(request, response);
	    } else {
	        // 기본 페이지 처리 (index.jsp에 데이터 전달)
	        List<ProductDto> topSellingProducts = dao.getTopSellingProducts();
	        request.setAttribute("topSellingProducts", topSellingProducts);
	        request.getRequestDispatcher("/index.jsp").forward(request, response);
	    }
    }




}