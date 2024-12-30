package com.miniprj.minimall.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductDto {
	private int id;
    private String sigun_nm;
    private String division;
    private String entrps_nm;
    private String prodlist_nm;
    private String telno;
}

