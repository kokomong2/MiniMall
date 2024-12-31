package com.miniprj.minimall.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDto {
	private int id;
    private String sigunNm;
    private String div;
    private String entrpsNm;
    private String prodlstNm;
    private String telno;

}
