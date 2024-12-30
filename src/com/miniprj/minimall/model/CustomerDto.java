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
	private String cust_address; // cust_address
}
