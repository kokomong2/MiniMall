package com.miniprj.minimall.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartDto {
    private Long cartId;      // 장바구니 ID
    private Long cartCount;   // 장바구니에 담긴 상품 수량
    private Long custId;      // 고객 ID
    private Long prodId;      // 상품 ID
    private ProductDto product;

}

