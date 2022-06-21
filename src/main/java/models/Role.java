package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@AllArgsConstructor
public class Role {
	private int id;
	
	private String name;
	
	public Role(int id) {
		this.id = id;
	}
}
