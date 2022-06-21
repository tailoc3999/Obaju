package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import constants.DefineConstants;
import models.Category;
import models.Product;
import utils.ConnectDBUlti;

public class ProductDAO {
	private Connection conn;
	
	private Statement st;
	
	private ResultSet rs;
	
	private PreparedStatement pst;

	public List<Product> getAll() {
		List<Product> list = new ArrayList<Product>();
		String Query = "SELECT p.*, cat.* "
				+ "FROM products AS p "
				+ "INNER JOIN categories AS cat "
				+ "ON p.cat_id = cat.id "
				+ "ORDER BY p.id DESC";
		conn = ConnectDBUlti.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(Query);
			while(rs.next()) {
				int id = rs.getInt("id");
				Category cat = new Category(rs.getInt("cat.id"), rs.getString("cat.name"));
				String title = rs.getString("p.title");
				int price = rs.getInt("p.price");
				int discount = rs.getInt("p.discount");
				String picture = rs.getString("p.picture");
				String description = rs.getString("p.description");
				Timestamp create_at = rs.getTimestamp("p.create_at");
				Product item = new Product(id, cat, title, price, discount, picture, description, create_at);
				list.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, st, rs);
		}

		return list;
	}
	
	public int getNumberOfProducts() {
		String Query = "SELECT COUNT(*) as c FROM products";
		conn = ConnectDBUlti.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(Query);
			if(rs.next()) {
				int result = rs.getInt("c");
				return result;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int getNumberOfProducts(int id) {
		String Query = "SELECT COUNT(*) as c FROM products WHERE cat_id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				int result = rs.getInt("c");
				return result;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst, rs);
		}
		
		return 0;
	}
	
	public List<Product> getPagination(int offset) {
		List<Product> list = new ArrayList<Product>();
		String Query = "SELECT p.*, cat.* "
				+ "FROM products AS p "
				+ "INNER JOIN categories AS cat "
				+ "ON p.cat_id = cat.id "
				+ "ORDER BY p.id DESC "
				+ "LIMIT ?, ? ";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, offset);
			pst.setInt(2, DefineConstants.NUMBER_PER_PAGE_PRODUCT);
			rs = pst.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				Category cat = new Category(rs.getInt("cat.id"), rs.getString("cat.name"));
				String title = rs.getString("p.title");
				int price = rs.getInt("p.price");
				int discount = rs.getInt("p.discount");
				String picture = rs.getString("p.picture");
				String description = rs.getString("p.description");
				Timestamp create_at = rs.getTimestamp("p.create_at");
				Product item = new Product(id, cat, title, price, discount, picture, description, create_at);
				list.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, st, rs);
		}

		return list;
	}
	
	public List<Product> getPaginationByCatId(int offset, int cat_id, int numPerPage) {
		List<Product> list = new ArrayList<Product>();
		String Query = "SELECT p.*, cat.* "
				+ "FROM products AS p "
				+ "INNER JOIN categories AS cat "
				+ "ON p.cat_id = cat.id "
				+ "WHERE p.cat_id = ? "
				+ "ORDER BY p.id DESC "
				+ "LIMIT ?, ? ";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, cat_id);
			pst.setInt(2, offset);
			pst.setInt(3, numPerPage);
			rs = pst.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				Category cat = new Category(rs.getInt("cat.id"), rs.getString("cat.name"));
				String title = rs.getString("p.title");
				int price = rs.getInt("p.price");
				int discount = rs.getInt("p.discount");
				String picture = rs.getString("p.picture");
				String description = rs.getString("p.description");
				Timestamp create_at = rs.getTimestamp("p.create_at");
				Product item = new Product(id, cat, title, price, discount, picture, description, create_at);
				list.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, st, rs);
		}

		return list;
	}
	
	public int add(Product pro) {
		String Query = "INSERT INTO `products`(cat_id, title, price, picture, description) VALUES (?, ?, ?, ?, ?)";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, pro.getCat().getId());
			pst.setString(2, pro.getTitle());
			pst.setInt(3, pro.getPrice());
			pst.setString(4, pro.getThumbnail());
			pst.setString(5, pro.getDescription());
			int result = pst.executeUpdate();
			if(result > 0 ) {
				return result;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst);
		}
		return 0;
	}

	public Product getbyId(int id) {
		String Query = "SELECT p.*, c.* FROM products AS p INNER JOIN categories AS c ON p.cat_id = c.id WHERE p.id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				Category cat = new Category(rs.getInt("c.id"), rs.getString("c.name"));
				String title = rs.getString("title");
				int price = rs.getInt("price");
				int discount = rs.getInt("discount");
				String picture = rs.getString("picture");
				String description = rs.getString("description");
				Timestamp create_at = rs.getTimestamp("create_at");
				Product product = new Product(id, cat, title, price, discount, picture, description, create_at);
				return product;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int edit(Product product) {
		conn = ConnectDBUlti.getConnection();
		String Query  = "UPDATE products SET "
				+ "cat_id = ?, title = ?, price = ?, picture = ?, description = ? "
				+ "WHERE id = ?";
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, product.getCat().getId());
			pst.setString(2, product.getTitle());
			pst.setInt(3, product.getPrice());
			pst.setString(4, product.getThumbnail());
			pst.setString(5, product.getDescription());
			pst.setInt(6, product.getId());
			int result = pst.executeUpdate();
			if(result > 0) {
				return result;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst);
		}
		return 0;
	}
	
	public int del(int id) {
		String Query = "DELETE FROM products WHERE id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, id);
			int result = pst.executeUpdate();
			if(result > 0) {
				return result;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst);
		}
		
		return 0;
	}
	
	public List<Product> getByCatId(int id) {
		List<Product> products = new ArrayList<Product>();
		conn = ConnectDBUlti.getConnection();
		String Query = "SELECT p.*, c.* FROM products AS p "
				+ "INNER JOIN categories AS c "
				+ "ON p.cat_id = c.id "
				+ "WHERE p.cat_id = ?";
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while(rs.next()) {
				Category cat = new Category(rs.getInt("c.id"), rs.getString("c.name"));
				String title = rs.getString("title");
				int price = rs.getInt("price");
				int discount = rs.getInt("discount");
				String picture = rs.getString("picture");
				String description = rs.getString("description");
				Timestamp create_at = rs.getTimestamp("create_at");
				Product product = new Product(rs.getInt("p.id"), cat, title, price, discount, picture, description, create_at);
				products.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst, rs);
		}
		return products;
	}
	
	public static void main(String[] args) {
		ProductDAO dao = new ProductDAO();
	//	int p = dao.getNumberOfProducts();
		List<Product> p = dao.getPaginationByCatId(0, 2, 2);
	//	Product pro = dao.getbyId(1);
		System.out.println(p);
	}
}
