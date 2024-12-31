package com.miniprj.minimall.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CustomerDto {
	private String cust_name; // cust_name
	private String cust_email; // cust_email
	private String cust_password; // cust_password
	private String cust_phone_num; // cust_phone_num
	private String cust_postcode; // cust_postcode 우편번호
	private String cust_address; // cust_address 주소
	private String cust_detail_address;// cust_detail_address 상세 주소
	
	public CustomerDto(String cust_email, String cust_phone_num, String cust_postcode, String cust_address, String cust_detail_address) {
	    this.cust_email = cust_email;
	    this.cust_phone_num = cust_phone_num;
	    this.cust_postcode = cust_postcode;
	    this.cust_address = cust_address;
	    this.cust_detail_address = cust_detail_address;
	}
} 


