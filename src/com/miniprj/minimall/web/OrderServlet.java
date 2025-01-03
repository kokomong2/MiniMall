package com.miniprj.minimall.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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

                if (orderList == null || orderList.isEmpty()) {
                    System.out.println("No orders found for customer ID: " + cust_id);
                }

                // 구매 내역 페이지로 포워딩
                RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/order/myorders.jsp");
                disp.forward(request, response);
                return; // 추가 실행 방지
            }

            if ("detail".equals(action)) {
                String orderNum = request.getParameter("order_num");
                if (orderNum == null || orderNum.isEmpty()) {
                    request.setAttribute("error", "주문 번호가 제공되지 않았습니다.");
                    RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/error.jsp");
                    disp.forward(request, response);
                    return;
                }

                System.out.println("Fetching details for orderNum: " + orderNum);

                // 주문 상세 내역 조회
                List<OrderDto> detailList = dao.getOrderDetails(orderNum);

                if (detailList != null && !detailList.isEmpty()) {
                    // 첫 번째 아이템에서 배송지 정보 가져오기 (같은 주문 번호라면 동일한 배송지 사용)
                    String orderAddress = detailList.get(0).getOrderAddress();
                    request.setAttribute("orderAddress", orderAddress);
                }

                request.setAttribute("detailList", detailList);
                request.setAttribute("orderNum", orderNum);

                // 상세 주문 페이지로 포워딩
                RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/order/mydetailorder.jsp");
                disp.forward(request, response);
                return; // 추가 실행 방지
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/error.jsp");
            disp.forward(request, response);
            return; // 추가 실행 방지
        }

        // 기본적으로 ordercheck.jsp로 포워딩
        RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/order/ordercheck.jsp");
        disp.forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        // 세션에서 고객 정보 가져오기
        CustomerDto sessionCustomer = (CustomerDto) request.getSession().getAttribute("customer");
        if (sessionCustomer == null || sessionCustomer.getCust_email() == null) {
            response.sendRedirect("/auth/Auth.do?action=loginform");
            return;
        }

        // 체크된 상품 데이터만 처리
        String[] prodIdParams = request.getParameterValues("prodId");
        String[] orderCountParams = request.getParameterValues("orderCount");
        String[] orderPriceParams = request.getParameterValues("orderPrice");

        // 콘솔에 값 찍어보기
        System.out.println("prodIdParams: " + Arrays.toString(prodIdParams));
        System.out.println("orderCountParams: " + Arrays.toString(orderCountParams));
        System.out.println("orderPriceParams: " + Arrays.toString(orderPriceParams));

        if (prodIdParams == null || prodIdParams.length == 0) {
            response.getWriter().println("상품이 선택되지 않았습니다!");
            return;
        }

        String custEmail = sessionCustomer.getCust_email();
        String custAddress = sessionCustomer.getCust_address();
        List<OrderDto> orderList = new ArrayList<>();

        try {
            for (int i = 0; i < prodIdParams.length; i++) {
                int prodId = Integer.parseInt(prodIdParams[i]);
                int orderCount = Integer.parseInt(orderCountParams[i]);
                int orderPrice = Integer.parseInt(orderPriceParams[i]);
                String orderNum = new java.text.SimpleDateFormat("yyyyMMddHHmm").format(new java.util.Date()) + custEmail;

                OrderDto order = new OrderDto();
                order.setOrderCount(orderCount);
                order.setOrderPrice(orderPrice);
                order.setProdId(prodId);
                order.setOrderDate(new java.util.Date());
                order.setOrderAddress(custAddress);
                order.setOrderNum(orderNum);

                dao.insertOrder(order, custEmail);
                orderList.add(order);
            }

            request.setAttribute("orderList", orderList);
            request.setAttribute("message", "주문이 성공적으로 완료되었습니다.");
            RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/views/order/ordercheck.jsp");
            disp.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("에러: " + e.getMessage());
        }
    }
}