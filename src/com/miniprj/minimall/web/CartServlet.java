package com.miniprj.minimall.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.miniprj.minimall.dao.CartDao;
import com.miniprj.minimall.model.CartDto;
import com.miniprj.minimall.model.CustomerDto;


@WebServlet("/Cart.do")
public class CartServlet extends HttpServlet 
{
	 
	 public CartServlet() {
	     super();
	 }

	 protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	         throws ServletException, IOException 
	 {
		 CartDao cartDao = new CartDao();
		 String action = request.getParameter("action");
		 CustomerDto sessionCustomer = (CustomerDto) request.getSession().getAttribute("customer");
	     String cust_email=sessionCustomer.getCust_email();
		 
		 if("list".equals(action))
		 {
			 List<CartDto> cartList = cartDao.listCartWithProductInfo(cust_email);
		     request.setAttribute("cartList", cartList);
		     
		     RequestDispatcher disp=request.getRequestDispatcher("/WEB-INF/views/cart/cartform.jsp");
			 disp.forward(request, response);
		 }
	 }
	
	 
	 
	 
	 
	 @Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response)
	         throws ServletException, IOException 
	 {
	     String action = request.getParameter("action");
	     CustomerDto sessionCustomer = (CustomerDto) request.getSession().getAttribute("customer");
	     
	     
	     //no email information
	     if (sessionCustomer == null || sessionCustomer.getCust_email() == null) {
	         response.sendRedirect("/auth/Auth.do?action=loginform");
	         return;
	     }
	     
	     String cust_email=sessionCustomer.getCust_email();
	     
	     
	     if ("addCart".equals(action)) 
	     {
	         // 장바구니에 상품을 추가
	    	 String prod_id = request.getParameter("productId");
		     String cust_id = request.getParameter("custId");
		     
		     String cart_quantity = request.getParameter("cartQuantity");
		     
		     if(prod_id!=null && cust_email!=null && cart_quantity!=null)
		     {
		    	// 장바구니에 추가
			     try {
			    	 CartDao cartDao = new CartDao();
				     cartDao.addCart( Integer.parseInt(prod_id), Integer.parseInt(cart_quantity), cust_email);
				     
			     }catch (Exception e) {
			    	 e.printStackTrace();
			    	 System.out.println("addCart error="+e.getMessage());
		     }
			}
		    response.sendRedirect("/Cart.do?action=list");
	     } 
	     else if ("updateCart".equals(action)) 
	     {
	    	 String cart_quantity=request.getParameter("quantity");
	    	 String cart_id=request.getParameter("cartId");
	    	 if(cust_email!=null&& cart_quantity!=null)
	    	 {
	    		 CartDao cartDao=new CartDao();
	    		 cartDao.updateCart(cust_email, Integer.parseInt(cart_id),Integer.parseInt(cart_quantity));
	    	 }
	    	 
		     response.sendRedirect("/Cart.do?action=list");
	     } 
	     else if ("removeCart".equals(action)) 
	     {
	         // 장바구니에서 상품을 제거
	    	 int cart_id = Integer.parseInt(request.getParameter("cartId"));
	 	     
	 	     try {
	 	    	 CartDao cartDao = new CartDao();
	 	         cartDao.removeCart(cart_id, cust_email);
			} catch (Exception e) {
				 e.printStackTrace();
		    	 System.out.println("removeCart error="+e.getMessage());
			}
	 	     
	 	     response.sendRedirect("/Cart.do?action=list");
	     } 

	 }
}
