package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.miniprj.minimall.model.CustomerDto;

public class CustomerDao {
	static DataSource dataSource;

	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	public void insertMember(CustomerDto customer) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "INSERT INTO customer (cust_name, cust_email, cust_password, cust_phone_num, cust_address) "
					+ "VALUES (?, ?, ?, ?, ?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, customer.getCust_name());
			stmt.setString(2, customer.getCust_email());
			stmt.setString(3, customer.getCust_password());
			stmt.setString(4, customer.getCust_phone_num());
			stmt.setString(5, customer.getCust_address());
			int rowCount = stmt.executeUpdate();
			System.out.println(rowCount + "개 행이 추가되었습니다.");
			if (rowCount<=0) {
				throw new SQLException("저장된 행이 없습니다.");
			}
		}catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			if(con!=null) try { con.close(); } catch(Exception e) {}
		}
	}
}
