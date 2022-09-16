package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Item {
	private User user;
	
	private Product product;
	
	private int quantity;
	
	private int price;
	
	public static void main(String[] args) {
		String code = "" + java.time.LocalDateTime.now().getYear() + java.time.LocalDateTime.now().getMonthValue()
				+ java.time.LocalDateTime.now().getDayOfMonth() + java.time.LocalDateTime.now().getHour()
				+ java.time.LocalDateTime.now().getMinute() + java.time.LocalDateTime.now().getSecond();
		System.out.println(code);
	}
}
