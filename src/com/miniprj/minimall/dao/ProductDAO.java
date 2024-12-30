package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.miniprj.minimall.model.ProductDto;

public class ProductDAO {

	
	private DataSource ds;
	
	public ProductDAO()
	{
		try {
			Context ctx=new InitialContext();
			ds=(DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	}
	
	public List<ProductDto> listProducts() {
        List<ProductDto> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = ds.getConnection();
            String sql = "SELECT * FROM product";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDto product = new ProductDto();
                
                // 값 설정
                product.setProdId(rs.getLong("PROD_ID"));
                product.setProdCategory(rs.getString("PROD_CATEGORY"));
                product.setProdName(rs.getString("PROD_NAME"));
                product.setProdPrice(rs.getBigDecimal("PROD_PRICE"));
                product.setProdStock(rs.getLong("PROD_STOCK"));
                product.setProdLocal(rs.getString("PROD_LOCAL"));
                product.setProdInfo(rs.getString("PROD_INFO"));  // CLOB 처리, 필요시 CLOB 전용 처리 필요
                product.setProdImg(rs.getString("PROD_IMG"));    // CLOB 처리, 필요시 CLOB 전용 처리 필요

                // 리스트에 추가
                productList.add(product);
            }

        } catch (Exception e) {
            throw new RuntimeException("sql error="+e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return productList;
    }

	public ProductDto getProductById(long prodId) {
        ProductDto product = null;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
        	conn = ds.getConnection();
            String sql = "SELECT PROD_ID, PROD_CATEGORY, PROD_NAME, PROD_PRICE, PROD_STOCK, PROD_LOCAL, PROD_INFO, PROD_IMG FROM product WHERE PROD_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, prodId);  // prodId를 쿼리 파라미터로 설정

            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 결과가 있으면 ProductDto 객체에 데이터를 매핑
                product = new ProductDto();
                product.setProdId(rs.getLong("PROD_ID"));
                product.setProdCategory(rs.getString("PROD_CATEGORY"));
                product.setProdName(rs.getString("PROD_NAME"));
                product.setProdPrice(rs.getBigDecimal("PROD_PRICE"));
                product.setProdStock(rs.getLong("PROD_STOCK"));
                product.setProdLocal(rs.getString("PROD_LOCAL"));
                product.setProdInfo(rs.getString("PROD_INFO"));
                product.setProdImg(rs.getString("PROD_IMG"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return product;  // 조회된 상품 정보를 반환
    }
	

}
