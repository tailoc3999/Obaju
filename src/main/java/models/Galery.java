package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Galery {
	private int id;
	
	private Product product;
	
	private String thumbnail;
	
	public Galery (Product p, String thumbnail) {
		this.thumbnail = thumbnail;
		this.product = p;
	}
}
