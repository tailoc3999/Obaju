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
	
	private Status status;
	
	private String code;
	
	private int total_money;
	
	public Order(User user, String fullname, String email, String phoneNumber, String address, String note, String code, int totalMoney) {
		this.user = user;
		this.fullname = fullname;
		this.email = email;
		this.phone_number = phoneNumber;
		this.address = address;
		this.note = note;
		this.code = code;
		this.total_money = totalMoney;
	}
}
