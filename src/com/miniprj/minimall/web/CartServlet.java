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
		 
		 
		 if("list".equals(action))
		 {
			 System.out.println("this one is working");
			 int cust_id=2;//임시로 회원 정함
			 List<CartDto> cartList = cartDao.listCartWithProductInfo(cust_id);
		     request.setAttribute("cartList", cartList);
		     
		     RequestDispatcher disp=request.getRequestDispatcher("/WEB-INF/views/cartform.jsp");
			 disp.forward(request, response);
		 }
	 }
	
	 
	 
	 
	 
	 @Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response)
	         throws ServletException, IOException 
	 {
	     String action = request.getParameter("action");
	
	     if ("addCart".equals(action)) 
	     {
	         // 장바구니에 상품을 추가
	    	 String prod_id = request.getParameter("productId");
		     String cust_id = request.getParameter("custId");
		     String cart_quantity = request.getParameter("cartQuantity");
		     
		     if(prod_id!=null && cust_id!=null && cart_quantity!=null)
		     {
		    	// 장바구니에 추가
			     try {
			    	 CartDao cartDao = new CartDao();
				     cartDao.addCart( Integer.parseInt(prod_id), Integer.parseInt(cart_quantity), Integer.parseInt(cust_id));
				     
				     
			     }catch (Exception e) {
			    	 e.printStackTrace();
			    	 System.out.println("addCart error="+e.getMessage());
		     }
			}
		    //ADDNEW
		    // 원래 요청한 페이지로 리디렉션
	        String referer = request.getHeader("Referer");
	        if (referer != null && !referer.isEmpty()) {
	            response.sendRedirect(referer);  // 이전 페이지로 리디렉션
	        } else {
	            response.sendRedirect("/Cart.do?action=list");  // 기본적으로 장바구니 리스트 페이지로 리디렉션
	        }
	     } 
	     else if ("updateCart".equals(action)) 
	     {
	    	 String cart_id=request.getParameter("cartId");
	    	 String cart_quantity=request.getParameter("quantity");
	    	 
	    	 if(cart_id!=null&& cart_quantity!=null)
	    	 {
	    		 CartDao cartDao=new CartDao();
	    		 cartDao.updateCart(Long.parseLong(cart_id), Integer.parseInt(cart_quantity));
	    	 }
	    	 
	    	 //ADDNEW
		     //response.sendRedirect("/Cart.do?action=list");
	     } 
	     else if ("removeCart".equals(action)) 
	     {
	         // 장바구니에서 상품을 제거
	    	 int cart_id = Integer.parseInt(request.getParameter("cartId"));
	 	     int cust_id=Integer.parseInt("2");//수정!!!
	 	     
	 	     try {
	 	    	 CartDao cartDao = new CartDao();
	 	         cartDao.removeCart(cart_id, cust_id);
			} catch (Exception e) {
				 e.printStackTrace();
		    	 System.out.println("removeCart error="+e.getMessage());
			}
	 	     
	 	     response.sendRedirect("/Cart.do?action=list");
	     } 
	     else 
	     {
	         // 장바구니 목록
	         doGet(request, response);
	     }
	 }




}
