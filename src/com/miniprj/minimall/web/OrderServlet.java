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

import com.miniprj.minimall.dao.CartDao;
import com.miniprj.minimall.dao.OrderDao;
import com.miniprj.minimall.model.CartDto;
import com.miniprj.minimall.model.CustomerDto;
import com.miniprj.minimall.model.OrderDto;
@WebServlet("/order/Order.do")
public class OrderServlet extends HttpServlet {
    OrderDao dao = new OrderDao();  

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // 세션에서 CustomerDto 가져오기
        CustomerDto sessionCustomer = (CustomerDto) request.getSession().getAttribute("customer");

        if (sessionCustomer == null || sessionCustomer.getCust_email() == null) {
            // 세션에 고객 정보가 없으면 로그인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/auth/Auth.do?action=loginform");
            return;
        }

        String customerEmail = sessionCustomer.getCust_email();
        System.out.println("Customer Email: " + customerEmail);

        try {
            // 이메일로 고객 ID 조회
            int cust_id = dao.getCustomerIdByEmail(customerEmail);
            System.out.println("Customer ID: " + cust_id);

            if (cust_id == -1) {
                throw new RuntimeException("Customer ID not found for email: " + customerEmail);
            }

            if ("myorderlist".equals(action)) {
                System.out.println("myorderlist action triggered");

                // 구매 내역 조회
                List<OrderDto> orderList = dao.myOrderList(cust_id);
                request.setAttribute("orderList", orderList);

                // 구매 내역 페이지로 포워딩
                RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/order/myorders.jsp");
                disp.forward(request, response);
                System.out.println("Forwarded to myorders.jsp");
                return; // 추가 코드 실행 방지
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
        }

        // 기본적으로 ordercheck.jsp로 포워딩
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
                String orderNum = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()) + custEmail;

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