package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail {
	private int id;
	
	private Order order;
	
	private Product product;
	
	private int price;
	
	private int quantity;
	
	private int total_money;
}
