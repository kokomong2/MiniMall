package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.miniprj.minimall.model.CartDto;
import com.miniprj.minimall.model.ProductDto;

public class CartDao {
    private DataSource ds;

    public CartDao() {
        try {
            Context ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }


    public void addCart(int productId, int quantity, int customerId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = ds.getConnection();

            // 장바구니에 해당 상품있는지 확인
            String checkSql = "SELECT CART_ID, CART_COUNT FROM CART WHERE PROD_ID = ? AND CUST_ID = ?";
            pstmt = con.prepareStatement(checkSql);
            pstmt.setInt(1, productId);
            pstmt.setInt(2, customerId);
            rs = pstmt.executeQuery();

            
            // 이미 상품이 장바구니에 있음
            if (rs.next()) {

                int currentQuantity = rs.getInt("CART_COUNT");
                int newQuantity = currentQuantity + quantity;

                String updateSql = "UPDATE CART SET CART_COUNT = ? WHERE PROD_ID = ? AND CUST_ID = ?";
                pstmt = con.prepareStatement(updateSql);
                pstmt.setInt(1, newQuantity);
                pstmt.setInt(2, productId);
                pstmt.setInt(3, customerId);
                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    System.out.println("Cart updated successfully.");
                } else {
                    System.out.println("No cart found to update.");
                }
                
            } 
            // 장바구니에 상품이 없음
            else {
                
                String insertSql = "INSERT INTO CART (CART_ID, PROD_ID, CART_COUNT, CUST_ID) "
                                 + "VALUES (SEQ_CART.NEXTVAL, ?, ?, ?)";
                pstmt = con.prepareStatement(insertSql);
                pstmt.setInt(1, productId);
                pstmt.setInt(2, quantity);
                pstmt.setInt(3, customerId);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            throw new RuntimeException("CartDao addCart error=" + e.getMessage());
        } finally {
        	closeResources(rs,pstmt,con);
        }
    }




    // 장바구니 특정 항목 제거
    public void removeCart(int cartId, int custId) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
        	
            con = ds.getConnection();
            String sql = "DELETE FROM cart WHERE cart_id = ?";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, cartId);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            throw new RuntimeException("CartDao removeCart error=" + e.getMessage());
        } finally {
        	closeResources(null,pstmt,con);
        }
    }
    

    
    

    
    public void updateCart(Long cartId, int cartCount) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = ds.getConnection();
            String sql = "UPDATE cart SET cart_count = ? WHERE cart_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, cartCount);
            pstmt.setLong(2, cartId);

            pstmt.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("CartDao updateCart error=" + e.getMessage());
        } finally {
        	closeResources(null,pstmt,con);
        }
    }

    
    
    //장바구니+상품정보 조회
 // 장바구니+상품정보 조회
    public List<CartDto> listCartWithProductInfo(int custId) {
        List<CartDto> cartList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = ds.getConnection();
            String sql = "SELECT c.cart_id, c.cart_count, c.cust_id, c.prod_id, "
                    + "p.prod_inspection_date, p.prod_subcategory, p.prod_main_category, "
                    + "p.prod_region_name, p.prod_image_url, p.prod_model_name, "
                    + "p.prod_sales_office_name, p.prod_brand_name, p.prod_goods_name, "
                    + "p.prod_sale_price, p.prod_pack_capacity, p.prod_pack_unit, "
                    + "p.prod_sale_weight, p.prod_weight_unit, p.prod_explanation "
                    + "FROM cart c "
                    + "JOIN product p ON c.prod_id = p.prod_id "
                    + "WHERE c.cust_id = ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, custId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CartDto cart = new CartDto();
                cart.setCartId(rs.getLong("cart_id"));
                cart.setCartCount(rs.getLong("cart_count"));
                cart.setCustId(rs.getLong("cust_id"));
                cart.setProdId(rs.getLong("prod_id"));

                // 상품 정보를 ProductDto에 직접 설정
                ProductDto product = new ProductDto();
                product.setProdId(rs.getInt("prod_id"));
                product.setProdInspectionDate(rs.getString("prod_inspection_date"));
                product.setProdSubcategory(rs.getString("prod_subcategory"));
                product.setProdMainCategory(rs.getString("prod_main_category"));
                product.setProdRegionName(rs.getString("prod_region_name"));
                product.setProdImageUrl(rs.getString("prod_image_url"));
                product.setProdModelName(rs.getString("prod_model_name"));
                product.setProdSalesOfficeName(rs.getString("prod_sales_office_name"));
                product.setProdBrandName(rs.getString("prod_brand_name"));
                product.setProdGoodsName(rs.getString("prod_goods_name"));
                product.setProdSalePrice(rs.getInt("prod_sale_price"));
                product.setProdPackCapacity(rs.getInt("prod_pack_capacity"));
                product.setProdPackUnit(rs.getString("prod_pack_unit"));
                product.setProdSaleWeight(rs.getDouble("prod_sale_weight"));
                product.setProdWeightUnit(rs.getString("prod_weight_unit"));
                product.setProdExplanation(rs.getString("prod_explanation"));

                cart.setProduct(product);
                cartList.add(cart);
            }
        } catch (Exception e) {
            throw new RuntimeException("CartDao listCartWithProductInfo error=" + e.getMessage());
        } finally {
            closeResources(rs, pstmt, con);
        }
        return cartList;
    }


    // 상품 정보를 조회
    private ProductDto getProductById(long prodId) {
        ProductDao productDao = new ProductDao();
        return productDao.getProductDetail((int)prodId);
    }


    

    //리소스 정리
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
