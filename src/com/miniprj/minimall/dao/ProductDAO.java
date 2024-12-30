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
			ds=(DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
		} catch (Exception e) {
			throw new RuntimeException("ProdcutDAO error="+e.getMessage());
		}
	}
	
	public List<ProductDto> listProducts() {
        List<ProductDto> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = ds.getConnection();
            String sql = "SELECT * FROM GG_FOOD_DATA";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDto product = new ProductDto();
                product.setId(rs.getInt("ID"));
                product.setSigun_nm(rs.getString("SIGUN_NM"));
                product.setDivision(rs.getString("DIV"));
                product.setEntrps_nm(rs.getString("ENTRPS_NM"));
                product.setProdlist_nm(rs.getString("PRODLST_NM"));
                product.setTelno(rs.getString("TELNO"));
                productList.add(product);
            }
        } catch (Exception e) {
            throw new RuntimeException("ProdcutDAO error-listProducts="+e.getMessage());
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
}
