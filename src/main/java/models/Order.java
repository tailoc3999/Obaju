package models;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {
	private int id;
	
	private User user;
	
	private String fullname;
	
	private String email;
	
	private String phone_number;
	
	private String address;
	
	private String note;
	
	private Timestamp order_date;
	
	private int status;
	
	private String code;
	
	private int total_money;
}
