package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.miniprj.minimall.model.MemberDto;

public class MemberDao {
	static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	public void insertMember(MemberDto member) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			String sql = "INSERT INTO customer(cust_name, cust_email, cust_password, cust_phone_num, cust_address)"
			+"VALUES (?, ?, ?, ?, ?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, member.getCust_name());
			stmt.setString(2, member.getCust_email());
			stmt.setString(3, member.getCust_password());
			stmt.setString(4, member.getCust_phone_num()); 
			stmt.setString(5, member.getCust_address());
			int rowCount = stmt.executeUpdate();
			System.out.println(rowCount+"개 행이 변경되었습니다.");
			if(rowCount<=0) {
				throw new SQLException("저장된 행이 없습니다.");
			}
			
		}catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		}finally {
			if(con!=null) try { con.close(); } catch(Exception e) {}
		}
	}
	public String Login(String cust_name) {
	    String pw = "";
	    Connection con = null;
	    
	    try {
	        con = dataSource.getConnection();
	        String sql = "select cust_password from customer where cust_name=?";
	        PreparedStatement pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, cust_name);
	        ResultSet rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            pw = rs.getString("cust_password");
	        } else {
	            throw new RuntimeException("아이디가 존재하지 않습니다.");
	        }
	    } catch (Exception e) {
	        throw new RuntimeException("MemberDAO.getPassword " + e.getLocalizedMessage());
	    } finally {
	        // 커넥션을 닫는 부분은 데이터베이스 연결 종료 전, 반드시 커넥션 풀로 반납!!
	        if (con != null) {
	            try {
	                con.close(); // 실제로 커넥션을 종료하는 부분
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    
	    return pw;
	}

}
