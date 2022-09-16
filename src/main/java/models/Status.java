package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Status {
	int id;
	
	String name;
	
	String class_name;
	
	public Status(int id) {
		this.id = id;
	}
}
