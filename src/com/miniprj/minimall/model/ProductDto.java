package com.miniprj.minimall.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDto {
		
	private int prodId;
	private String prodInspectionDate;
	private String prodSubcategory;
	private String prodMainCategory;
	private String prodRegionName;
	private String prodImageUrl;
	private String prodModelName;
	private String prodSalesOfficeName;
	private String prodBrandName;
	private String prodGoodsName;
	private int prodSalePrice;
	private int prodPackCapacity;
	private String prodPackUnit;
	private double prodSaleWeight;
	private String prodWeightUnit;
	private String prodExplanation;
	private int total_quantity;

}
