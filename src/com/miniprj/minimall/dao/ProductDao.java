package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    public List<ProductDto> getAllProducts() {
        List<ProductDto> products = new ArrayList<>();
        String sql = "SELECT * FROM product";
        try (Connection con = dataSource.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ProductDto product = new ProductDto();
                product.setProdId(rs.getInt("PROD_ID"));
			    product.setProdInspectionDate(rs.getString("PROD_INSPECTION_DATE"));
			    product.setProdSubcategory(rs.getString("PROD_SUBCATEGORY"));
			    product.setProdMainCategory(rs.getString("PROD_MAIN_CATEGORY"));
			    product.setProdRegionName(rs.getString("PROD_REGION_NAME"));
			    product.setProdImageUrl(rs.getString("PROD_IMAGE_URL"));
			    product.setProdModelName(rs.getString("PROD_MODEL_NAME"));
			    product.setProdSalesOfficeName(rs.getString("PROD_SALES_OFFICE_NAME"));
			    product.setProdBrandName(rs.getString("PROD_BRAND_NAME"));
			    product.setProdGoodsName(rs.getString("PROD_GOODS_NAME"));
			    product.setProdSalePrice(rs.getInt("PROD_SALE_PRICE"));
			    product.setProdPackCapacity(rs.getInt("PROD_PACK_CAPACITY"));
			    product.setProdPackUnit(rs.getString("PROD_PACK_UNIT"));
			    product.setProdSaleWeight(rs.getDouble("PROD_SALE_WEIGHT"));
			    product.setProdWeightUnit(rs.getString("PROD_WEIGHT_UNIT"));
			    product.setProdExplanation(rs.getString("PROD_EXPLANATION"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public ProductDto getProductDetail(int prodId) {
        ProductDto product = null;
        String sql = "SELECT * FROM product WHERE prod_id = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, prodId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new ProductDto();
                    product.setProdId(rs.getInt("PROD_ID"));
    			    product.setProdInspectionDate(rs.getString("PROD_INSPECTION_DATE"));
    			    product.setProdSubcategory(rs.getString("PROD_SUBCATEGORY"));
    			    product.setProdMainCategory(rs.getString("PROD_MAIN_CATEGORY"));
    			    product.setProdRegionName(rs.getString("PROD_REGION_NAME"));
    			    product.setProdImageUrl(rs.getString("PROD_IMAGE_URL"));
    			    product.setProdModelName(rs.getString("PROD_MODEL_NAME"));
    			    product.setProdSalesOfficeName(rs.getString("PROD_SALES_OFFICE_NAME"));
    			    product.setProdBrandName(rs.getString("PROD_BRAND_NAME"));
    			    product.setProdGoodsName(rs.getString("PROD_GOODS_NAME"));
    			    product.setProdSalePrice(rs.getInt("PROD_SALE_PRICE"));
    			    product.setProdPackCapacity(rs.getInt("PROD_PACK_CAPACITY"));
    			    product.setProdPackUnit(rs.getString("PROD_PACK_UNIT"));
    			    product.setProdSaleWeight(rs.getDouble("PROD_SALE_WEIGHT"));
    			    product.setProdWeightUnit(rs.getString("PROD_WEIGHT_UNIT"));
    			    product.setProdExplanation(rs.getString("PROD_EXPLANATION"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<ProductDto> listByCategory(String prodCategory) {
        List<ProductDto> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE prod_main_category = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, prodCategory);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDto product = new ProductDto();
                    product.setProdId(rs.getInt("PROD_ID"));
    			    product.setProdInspectionDate(rs.getString("PROD_INSPECTION_DATE"));
    			    product.setProdSubcategory(rs.getString("PROD_SUBCATEGORY"));
    			    product.setProdMainCategory(rs.getString("PROD_MAIN_CATEGORY"));
    			    product.setProdRegionName(rs.getString("PROD_REGION_NAME"));
    			    product.setProdImageUrl(rs.getString("PROD_IMAGE_URL"));
    			    product.setProdModelName(rs.getString("PROD_MODEL_NAME"));
    			    product.setProdSalesOfficeName(rs.getString("PROD_SALES_OFFICE_NAME"));
    			    product.setProdBrandName(rs.getString("PROD_BRAND_NAME"));
    			    product.setProdGoodsName(rs.getString("PROD_GOODS_NAME"));
    			    product.setProdSalePrice(rs.getInt("PROD_SALE_PRICE"));
    			    product.setProdPackCapacity(rs.getInt("PROD_PACK_CAPACITY"));
    			    product.setProdPackUnit(rs.getString("PROD_PACK_UNIT"));
    			    product.setProdSaleWeight(rs.getDouble("PROD_SALE_WEIGHT"));
    			    product.setProdWeightUnit(rs.getString("PROD_WEIGHT_UNIT"));
    			    product.setProdExplanation(rs.getString("PROD_EXPLANATION"));
    			    
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<ProductDto> searchProducts(String query) {
        List<ProductDto> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE prod_goods_name LIKE ? OR prod_brand_name LIKE ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            String searchQuery = "%" + query + "%";
            stmt.setString(1, searchQuery);
            stmt.setString(2, searchQuery);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDto product = new ProductDto();
                    product.setProdId(rs.getInt("PROD_ID"));
    			    product.setProdInspectionDate(rs.getString("PROD_INSPECTION_DATE"));
    			    product.setProdSubcategory(rs.getString("PROD_SUBCATEGORY"));
    			    product.setProdMainCategory(rs.getString("PROD_MAIN_CATEGORY"));
    			    product.setProdRegionName(rs.getString("PROD_REGION_NAME"));
    			    product.setProdImageUrl(rs.getString("PROD_IMAGE_URL"));
    			    product.setProdModelName(rs.getString("PROD_MODEL_NAME"));
    			    product.setProdSalesOfficeName(rs.getString("PROD_SALES_OFFICE_NAME"));
    			    product.setProdBrandName(rs.getString("PROD_BRAND_NAME"));
    			    product.setProdGoodsName(rs.getString("PROD_GOODS_NAME"));
    			    product.setProdSalePrice(rs.getInt("PROD_SALE_PRICE"));
    			    product.setProdPackCapacity(rs.getInt("PROD_PACK_CAPACITY"));
    			    product.setProdPackUnit(rs.getString("PROD_PACK_UNIT"));
    			    product.setProdSaleWeight(rs.getDouble("PROD_SALE_WEIGHT"));
    			    product.setProdWeightUnit(rs.getString("PROD_WEIGHT_UNIT"));
    			    product.setProdExplanation(rs.getString("PROD_EXPLANATION"));
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
}
