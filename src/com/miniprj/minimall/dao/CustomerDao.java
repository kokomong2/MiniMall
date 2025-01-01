package com.miniprj.minimall.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
	
	public void signup(CustomerDto customer) {
		Connection con = null;
		
		try {
			con = dataSource.getConnection();
			String sql = "INSERT INTO customer (cust_name, cust_email, cust_password, cust_phone_num, cust_postcode, cust_address, cust_detail_address) VALUES (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, customer.getCust_name());
			stmt.setString(2, customer.getCust_email());
			stmt.setString(3, customer.getCust_password());
			stmt.setString(4, customer.getCust_phone_num());
			stmt.setString(5, customer.getCust_postcode());
			stmt.setString(6, customer.getCust_address());
			stmt.setString(7, customer.getCust_detail_address());
			int rowCount = stmt.executeUpdate();
			System.out.println(rowCount + "개 행이 추가되었습니다.");
			if (rowCount<=0) {
				throw new SQLException("저장된 행이 없습니다.");
			}
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
	}
	
	public CustomerDto login(String cust_email, String cust_password) {
		String email = "";
		String password = "";
		Connection con = null;
		
		try {
			con = dataSource.getConnection();
			String sql = "SELECT * FROM customer WHERE cust_email = ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, cust_email);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				String storedPassword = rs.getString("cust_password");
				String encryptedInputPassword = encryptPassword(cust_password);
				
				if (storedPassword.equals(encryptedInputPassword)) {
					return new CustomerDto(
		                    rs.getString("cust_name"),
		                    rs.getString("cust_email"),
		                    rs.getString("cust_password"),
		                    rs.getString("cust_phone_num"),
		                    rs.getString("cust_postcode"),
		                    rs.getString("cust_address"),
		                    rs.getString("cust_detail_address")
		                );
	            }
			}else {
				return null;
			}
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
		return null;
	} 
	
	public boolean checkEmail(String cust_email) {
		String email = "";
		Connection con = null;
		
		try {
			con = dataSource.getConnection();
			String sql = "SELECT * FROM customer WHERE cust_email = ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, cust_email);
			ResultSet rs = stmt.executeQuery();
			return rs.next();
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
	}
	
	private void closeConnection(Connection con) {
		if(con!=null) {
			try {
				con.close();
			}catch(Exception e) {
			}
		}
 	}
	
	private String encryptPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 알고리즘이 지원되지 않습니다.", e);
        }
    }
	
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

	public void editCustomerInfo(CustomerDto customer) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = getConnection();
            String sql = "UPDATE customer SET cust_phone_num = ?, cust_postcode = ?, cust_address = ?, cust_detail_address = ? WHERE cust_email = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, customer.getCust_phone_num());
            pstmt.setString(2, customer.getCust_postcode());
            pstmt.setString(3, customer.getCust_address());
            pstmt.setString(4, customer.getCust_detail_address());
            pstmt.setString(5, customer.getCust_email());
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

}
