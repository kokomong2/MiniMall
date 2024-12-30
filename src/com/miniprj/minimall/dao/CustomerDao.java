package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.miniprj.minimall.model.CustomerDto;

public class CustomerDao {

    public Connection getConnection() {
        DataSource ds = null;
        Connection con = null;
        try {
            Context ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
            con = ds.getConnection();
            System.out.println("Connection established: " + (con != null));
        } catch (Exception e) {
            System.err.println("Database Connection Error: " + e.getMessage());
            e.printStackTrace();
        }
        return con;
    }

    public void insert(CustomerDto customer) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = getConnection();
            String sql = "insert into customer(cust_name, cust_email, cust_password, cust_phone_num, cust_address) values(?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, customer.getCust_name());
            pstmt.setString(2, customer.getCust_email());
            pstmt.setString(3, customer.getCust_password());
            pstmt.setString(4, customer.getCust_phone_num());
            pstmt.setString(5, customer.getCust_address());
            System.out.println("Executing SQL: " + sql);
            int rowCount = pstmt.executeUpdate();
            if (rowCount != 1) {
                throw new SQLException("No rows affected");
            }
        } catch (Exception e) {
            throw new RuntimeException("CustomerDao.insert() : SQL Error - " + e.getMessage(), e);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
    }
    
    public CustomerDto findbyEmailAndPassword(String cust_emil, String cust_password) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            String sql = "SELECT * FROM customer WHERE cust_email = ? AND cust_password = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, cust_emil);
            pstmt.setString(2, cust_password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return new CustomerDto(
                    rs.getString("cust_name"),
                    rs.getString("cust_email"),
                    rs.getString("cust_password"),
                    rs.getString("cust_phone_num"),
                    rs.getString("cust_address")
                );
            }
        } catch (Exception e) {
            throw new RuntimeException("CustomerDao.findbyEmailAndPassword() : SQL Error - " + e.getMessage(), e);
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }

        return null; // 사용자 없음
    }

	
	
}
