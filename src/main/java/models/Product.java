package models;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
	private int id;
	
	private Category cat;
	
	private String title;
	
	private int price;
	
	private int discount;
	
	private String thumbnail;
	
	private String description;
	
	private Timestamp create_at;
	
	public Product(int cat_id, String title, int price, String thumbnail, String description) {
		this.cat = new Category(cat_id);
		this.title = title;
		this.price = price;
		this.thumbnail = thumbnail;
		this.description = description;
	}
	
	public Product(int id) {
		this.id = id;
	}
}
