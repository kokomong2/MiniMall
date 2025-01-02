package com.miniprj.minimall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLDataException;
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
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	public List<ProductDto> getAllProducts(){
		Connection con = null;
		List<ProductDto> products = new ArrayList<>();
		try {
			con = dataSource.getConnection();
			String sql = "SELECT \r\n" + 
					"    prod_id AS prodId,\r\n" + 
					"    prod_inspection_date AS prodInspectionDate,\r\n" + 
					"    prod_subcategory AS prodSubcategory,\r\n" + 
					"    prod_main_category AS prodMainCategory,\r\n" + 
					"    prod_region_name AS prodRegionName,\r\n" + 
					"    prod_image_url AS prodImageUrl,\r\n" + 
					"    prod_model_name AS prodModelName,\r\n" + 
					"    prod_sales_office_name AS prodSalesOfficeName,\r\n" + 
					"    prod_brand_name AS prodBrandName,\r\n" + 
					"    prod_goods_name AS prodGoodsName,\r\n" + 
					"    prod_sale_price AS prodSalePrice,\r\n" + 
					"    prod_pack_capacity AS prodPackCapacity,\r\n" + 
					"    prod_pack_unit AS prodPackUnit,\r\n" + 
					"    prod_sale_weight AS prodSaleWeight,\r\n" + 
					"    prod_weight_unit AS prodWeightUnit,\r\n" + 
					"    prod_explanation AS prodExplanation\r\n" + 
					"FROM product";
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				ProductDto product = new ProductDto();
				
				product.setProdId(rs.getInt("prodId"));
			    product.setProdInspectionDate(rs.getString("prodInspectionDate"));
			    product.setProdSubcategory(rs.getString("prodSubcategory"));
			    product.setProdMainCategory(rs.getString("prodMainCategory"));
			    product.setProdRegionName(rs.getString("prodRegionName"));
			    product.setProdImageUrl(rs.getString("prodImageUrl"));
			    product.setProdModelName(rs.getString("prodModelName"));
			    product.setProdSalesOfficeName(rs.getString("prodSalesOfficeName"));
			    product.setProdBrandName(rs.getString("prodBrandName"));
			    product.setProdGoodsName(rs.getString("prodGoodsName"));
			    product.setProdSalePrice(rs.getInt("prodSalePrice"));
			    product.setProdPackCapacity(rs.getInt("prodPackCapacity"));
			    product.setProdPackUnit(rs.getString("prodPackUnit"));
			    product.setProdSaleWeight(rs.getDouble("prodSaleWeight"));
			    product.setProdWeightUnit(rs.getString("prodWeightUnit"));
			    product.setProdExplanation(rs.getString("prodExplanation"));
			    
			    products.add(product);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return products;
	}
	public ProductDto getProductDetail(int prod_id) {
		Connection con = null;
		ProductDto product = new ProductDto();
		try {
			con = dataSource.getConnection();
			String sql = "SELECT \r\n" + 
					"    prod_id AS prodId,\r\n" + 
					"    prod_inspection_date AS prodInspectionDate,\r\n" + 
					"    prod_subcategory AS prodSubcategory,\r\n" + 
					"    prod_main_category AS prodMainCategory,\r\n" + 
					"    prod_region_name AS prodRegionName,\r\n" + 
					"    prod_image_url AS prodImageUrl,\r\n" + 
					"    prod_model_name AS prodModelName,\r\n" + 
					"    prod_sales_office_name AS prodSalesOfficeName,\r\n" + 
					"    prod_brand_name AS prodBrandName,\r\n" + 
					"    prod_goods_name AS prodGoodsName,\r\n" + 
					"    prod_sale_price AS prodSalePrice,\r\n" + 
					"    prod_pack_capacity AS prodPackCapacity,\r\n" + 
					"    prod_pack_unit AS prodPackUnit,\r\n" + 
					"    prod_sale_weight AS prodSaleWeight,\r\n" + 
					"    prod_weight_unit AS prodWeightUnit,\r\n" + 
					"    prod_explanation AS prodExplanation\r\n" + 
					"FROM product\r\n" +
					"WHERE prod_id=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, prod_id);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {				
				product.setProdId(rs.getInt("prodId"));
			    product.setProdInspectionDate(rs.getString("prodInspectionDate"));
			    product.setProdSubcategory(rs.getString("prodSubcategory"));
			    product.setProdMainCategory(rs.getString("prodMainCategory"));
			    product.setProdRegionName(rs.getString("prodRegionName"));
			    product.setProdImageUrl(rs.getString("prodImageUrl"));
			    product.setProdModelName(rs.getString("prodModelName"));
			    product.setProdSalesOfficeName(rs.getString("prodSalesOfficeName"));
			    product.setProdBrandName(rs.getString("prodBrandName"));
			    product.setProdGoodsName(rs.getString("prodGoodsName"));
			    product.setProdSalePrice(rs.getInt("prodSalePrice"));
			    product.setProdPackCapacity(rs.getInt("prodPackCapacity"));
			    product.setProdPackUnit(rs.getString("prodPackUnit"));
			    product.setProdSaleWeight(rs.getDouble("prodSaleWeight"));
			    product.setProdWeightUnit(rs.getString("prodWeightUnit"));
			    product.setProdExplanation(rs.getString("prodExplanation"));
			} else {
				throw new SQLDataException("상품을 찾을 수 없습니다.");
			}	
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("ERROR : " + e.getMessage());
		}
		
		return product;
	}


}
