package com.miniprj.minimall.model;
import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductDto {
	private Long prodId;            // 상품 ID
    private String prodCategory;    // 상품 카테고리
    private String prodName;        // 상품 이름
    private BigDecimal prodPrice;   // 상품 가격
    private Long prodStock;         // 상품 재고
    private String prodLocal;       // 상품 지역
    private String prodInfo;        // 상품 정보
    private String prodImg;         // 상품 이미지 
}
