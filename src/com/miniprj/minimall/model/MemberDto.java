package com.miniprj.minimall.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor @AllArgsConstructor
public class MemberDto {

	private String cust_name;
	private String cust_email;
	private String cust_password;
	private String cust_phone_num;
	private String cust_address;

}
