package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Feedback {
	private int id;
	
	private String first_name;
	
	private String last_name;
	
	private String email;
	
	private String subject;
	
	private String message;
}
