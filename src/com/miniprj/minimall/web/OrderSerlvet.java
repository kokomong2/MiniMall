package com.miniprj.minimall.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.miniprj.minimall.dao.OrderDao;
import com.miniprj.minimall.model.CustomerDto;
import com.miniprj.minimall.model.OrderDto;
@WebServlet("/order/Order.do")
public class OrderSerlvet extends HttpServlet {
    OrderDao dao = new OrderDao();  

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 단순히 ordercheck.jsp로 포워딩
        RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/order/ordercheck.jsp");
        disp.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 파라미터 처리
        request.setCharacterEncoding("utf-8");

        // 세션에서 고객 정보 가져오기
        CustomerDto sessionCustomer = (CustomerDto) request.getSession().getAttribute("customer");
        if (sessionCustomer == null || sessionCustomer.getCust_email() == null) {
            System.out.println("세션 고객 정보 없음");
            response.sendRedirect("/auth/Auth.do?action=loginform");
            return;
        }

        // prodIds와 orderCounts를 배열로 받음
        String[] prodIdParams = request.getParameterValues("prodId");
        String[] orderCountParams = request.getParameterValues("orderCount");

        if (prodIdParams == null || prodIdParams.length == 0) {
            response.getWriter().println("상품 ID가 누락되었습니다!");
            return;
        }

        // 고객 정보
        String custEmail = sessionCustomer.getCust_email();
        String custAddress = sessionCustomer.getCust_address();

        // 주문 목록
        List<OrderDto> orderList = new ArrayList<>();  // 주문 목록을 저장할 리스트 생성

        // 각 상품에 대해 처리
        try {
            System.out.println("Inserting orders to DB...");

            for (int i = 0; i < prodIdParams.length; i++) {
                int prodId = Integer.parseInt(prodIdParams[i]);
                int orderCount = (orderCountParams != null && orderCountParams.length > i) ? Integer.parseInt(orderCountParams[i]) : 1;
                String orderNum = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()) + custEmail + "_" + prodId;

                System.out.println("Received order: prodId=" + prodId + ", orderCount=" + orderCount);

                // 주문 객체 생성
                OrderDto order = new OrderDto();
                order.setOrderCount(orderCount);
                order.setProdId(prodId);
                order.setOrderDate(new java.util.Date());
                order.setOrderAddress(custAddress);
                order.setOrderNum(orderNum);

                // DB에 주문 삽입
                dao.insertOrder(order, custEmail);
                System.out.println("Order for prodId=" + prodId + " successfully inserted");

                // 주문 목록에 추가
                orderList.add(order);
            }

            // 주문 완료 후 페이지로 포워딩
            request.setAttribute("orderList", orderList);  // 주문 목록을 request에 저장
            request.setAttribute("message", "주문이 성공적으로 완료되었습니다.");
            RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/order/ordercheck.jsp");
            disp.forward(request, response);

        } catch (Exception e) {
            response.getWriter().println("에러: " + e.getMessage());
            e.printStackTrace(); // 예외 출력
        }
    }
}