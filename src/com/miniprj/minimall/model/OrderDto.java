package com.miniprj.minimall.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDto {
    private int orderId;            // 주문 ID
    private int orderCount;         // 주문 수량
    private int custId;             // 고객 ID
    private int prodId;             // 상품 ID
    private Date orderDate;         // 주문 날짜
    private String orderAddress;    // 주문 주소
    private String orderNum;           // 주문 번호
}