package com.miniprj.minimall.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.miniprj.minimall.dao.CartDao;
import com.miniprj.minimall.model.CartDto;


@WebServlet("/Cart.do")
public class CartServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 public CartServlet() {
     super();
 }
int custID=1;

 protected void doGet(HttpServletRequest request, HttpServletResponse response) 
         throws ServletException, IOException {
     CartDao cartDao = new CartDao();
     List<CartDto> cartList = cartDao.listCartWithProductInfo(custID);//이거 custID로 변경해야함

     request.setAttribute("cartList", cartList);
     request.getRequestDispatcher("/cartform.jsp").forward(request, response);
 }

 
 @Override
 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException 
 {
     String action = request.getParameter("action");  // 어떤 동작인지 구분

     if ("addToCart".equals(action)) {
         // 장바구니에 상품을 추가
         addToCart(request, response);
     } else if ("updateCart".equals(action)) {
         // 장바구니 수량을 업데이트
         updateCart(request, response);
     } else if ("removeCart".equals(action)) {
         // 장바구니에서 상품을 제거
         removeFromCart(request, response);
     } else {
         // 장바구니 목록을 보여주는
         doGet(request, response);
     }
 }


 private void addToCart(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException 
 {
     int productId = Integer.parseInt(request.getParameter("productId"));
     int customerId = 1;
     int quantity = 1;
     
     // 장바구니에 추가
     CartDao cartDao = new CartDao();
     cartDao.addCart(productId, quantity, customerId);  // DB에 장바구니 추가
     
     response.sendRedirect("/Cart.do");
 }


 private void updateCart(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
	 
     // 요청에서 수량 정보 추출
     String[] cartIds = request.getParameterValues("cartIds");
     String[] quantities = request.getParameterValues("quantities");

     if (cartIds != null && quantities != null) {
         CartDao cartDao = new CartDao();
         for (int i = 0; i < cartIds.length; i++) {
             int cartId = Integer.parseInt(cartIds[i]);
             int quantity = Integer.parseInt(quantities[i]);
             cartDao.updateCart((long)cartId, quantity);  // 수량 업데이트
         }
     }

     // 장바구니 페이지로 리다이렉트
     //response.sendRedirect("/Cart.do");
 }


 private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    String[] cartIds = request.getParameterValues("cartIds");
    
   
    if (cartIds != null) {
        CartDao cartDao = new CartDao();
        for (String cartId : cartIds) {
            cartDao.removeCart(Integer.parseInt(cartId), custID);
        }
    }

    // 장바구니 페이지로 리다이렉트
    response.sendRedirect("/Cart.do");
}
 


}
