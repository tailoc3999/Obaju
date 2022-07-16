package models;

import java.util.ArrayList;
import java.util.List;


public class Cart {
	private List<Item> items;
	
	public Cart() {
		items = new ArrayList<>();
	}

	public List<Item> getItems() {
		return items;
	}

	public List<Item> getItemsByUser(User u) {
		List<Item> list = new ArrayList<Item>();
		for(Item item : items) {
			if(item.getUser().getId() == u.getId()) {
				list.add(item);
			}
		}
		
		return list;
	}
	
	public Cart(List<Item> items) {
		this.items = items;
	}
	
	public int getQuantityById(int id) {
		return getItemById(id).getQuantity();
	}
	
	private Item getItemById(int id) {
		for(Item i : items) {
			if(i.getProduct().getId() == id) {
				return i;
			}
		}
		return null;
	}
	
	public void addItem(Item i) {
		if(getItemById(i.getProduct().getId()) != null) {
			Item m = getItemById(i.getProduct().getId());
			m.setQuantity(m.getQuantity() + i.getQuantity());
		} else {
			items.add(i);
		}
	}
	
	public void removeItem(int id) {
		if(getItemById(id) != null) {
			items.remove(getItemById(id));
		}
	}
	
	public int TotalMoney() {
		int total = 0;
		for(Item i : items) {
			total += i.getPrice() * i.getQuantity();
		}
		return total;
	}
	
//	private Product getProductById(int id, List<Product> list) {
//		for(Product i : list) {
//			if(i.getId() == id) {
//				return i;
//			}
//		}
//		return null;
//	}
	
//	public Cart(String txt, List<Product> list) {
//		items = new ArrayList<Item>();
//		try {
//			if(txt != null && txt.length() > 0) {
//				String []s = txt.split("-");
//				for(String i : s) {
//					String []n = i.split(":");
//					int id = Integer.parseInt(n[0]);
//					int quantity = Integer.parseInt(n[1]);
//					Product product = getProductById(id, list);
//					Item t = new Item(product, quantity, product.getPrice() * 2);
//					addItem(t);
//				}
//			}
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//	}
}
