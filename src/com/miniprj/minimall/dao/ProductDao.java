package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.miniprj.minimall.model.ProductDto;

public class ProductDao {
    static DataSource dataSource;

    static {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    public List<ProductDto> productlist() {
        List<ProductDto> productList = new ArrayList<>();
        Connection con = null;

        try {
            con = dataSource.getConnection();
            String sql = "SELECT * FROM gg_food_data";
            PreparedStatement stmt = con.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductDto product = new ProductDto(
                        rs.getInt("id"),
                        rs.getString("sigun_nm"),
                        rs.getString("div"),
                        rs.getString("entrps_nm"),
                        rs.getString("prodlst_nm"),
                        rs.getString("telno")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        } finally {
            if (con != null) {
                try {
                    con.close(); // 연결 닫기
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return productList; // List 반환
    }
}
