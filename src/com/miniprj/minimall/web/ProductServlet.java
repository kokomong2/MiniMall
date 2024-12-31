package com.miniprj.minimall.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.miniprj.minimall.dao.ProductDAO;
import com.miniprj.minimall.model.ProductDto;


@WebServlet("/Product.do")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ProductServlet() {
        super();
        
    }

	
	public void init(ServletConfig config) throws ServletException {
		
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
        ProductDAO productDAO = new ProductDAO();
        String action = request.getParameter("action");
        
        if("list".equals(action))
        {
        	List<ProductDto> productList = productDAO.listProducts();

            // 제품 목록을 request 객체에 저장
            request.setAttribute("productList", productList);

            // forwarding
            RequestDispatcher disp=request.getRequestDispatcher("/WEB-INF/views/listproduct.jsp");
    		disp.forward(request, response);
        }
        else if("detail".equals(action))
        {
        	RequestDispatcher disp=request.getRequestDispatcher("/WEB-INF/views/productdetailtestform.jsp");
    		disp.forward(request, response);	
        }		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}
