package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {

	private int id;
	
	private String fullname;
	
	private String email;
	
	private String phone_number;
	
	private String address;
	
	private String password;
	
	private Role role;
	
	public User(String fullname, String email, String phone_number, String address, String password, Role role) {
		this.fullname = fullname;
		this.email = email;
		this.phone_number = phone_number;
		this.address = address;
		this.role = role;
		this.password = password;
	}
}
