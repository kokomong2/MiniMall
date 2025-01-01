package com.miniprj.minimall.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor 
public class CustomerDto {
	private String cust_name;
	private String cust_email;
	private String cust_password;
	private String cust_phone_num;
	private String cust_postcode;
	private String cust_address;
	private String cust_detail_address;
	
	public CustomerDto(String cust_email, String cust_phone_num, String cust_postcode, String cust_address, String cust_detail_address) {
	    this.cust_email = cust_email;
	    this.cust_phone_num = cust_phone_num;
	    this.cust_postcode = cust_postcode;
	    this.cust_address = cust_address;
	    this.cust_detail_address = cust_detail_address;
	}
}