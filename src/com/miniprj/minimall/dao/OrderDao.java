package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.miniprj.minimall.model.OrderDto;
import javax.naming.Context;

public class OrderDao {

    static DataSource dataSource;

    static {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    // 이메일을 통해 고객 ID를 얻는 메소드
    private int getCustomerIdByEmail(String email) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int customerId = -1;

        try {
            con = dataSource.getConnection();
            String sql = "SELECT CUST_ID FROM CUSTOMER WHERE CUST_EMAIL = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                customerId = rs.getInt("CUST_ID");
            }
        } finally {
            closeResources(rs, pstmt, con);
        }
        return customerId;
    }

    public void insertOrder(OrderDto order, String customerEmail) throws SQLException {
        Connection con = null;
        PreparedStatement stmt = null;

        try {
            int customerId = getCustomerIdByEmail(customerEmail); // 이메일로 customerId를 얻어옴
            if (customerId == -1) {
                throw new SQLException("Customer not found for email: " + customerEmail);
            }

            con = dataSource.getConnection();
            if (con == null) {
                throw new SQLException("Connection failed");
            }

            String sql = "INSERT INTO Orders (order_count, cust_id, prod_id, order_date, order_address, order_num) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(sql);

            stmt.setInt(1, order.getOrderCount());
            stmt.setInt(2, customerId); // 고객 ID를 삽입
            stmt.setInt(3, order.getProdId());
            stmt.setDate(4, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setString(5, order.getOrderAddress());
            stmt.setString(6, order.getOrderNum());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);  // 디버깅용
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("DB 쿼리 실행 실패: " + e.getMessage()); // 더 자세한 에러 메시지 추가
        } finally {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        }
    }


    // 리소스 정리
    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection con) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
