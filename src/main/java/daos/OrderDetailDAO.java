package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import models.Category;
import models.Order;
import models.OrderDetail;
import models.Product;
import models.Status;
import models.User;
import utils.ConnectDBUlti;

public class OrderDetailDAO {
	private Connection conn;
	
	private Statement st;
	
	private ResultSet rs;
	
	private PreparedStatement pst;

	public List<OrderDetail> getOrderDetailById(int oid) {
		List<OrderDetail> list = new ArrayList<OrderDetail>();
		String Query = "SELECT od.*, o.*, p.*, s.* FROM `order_detail` AS od "
				+ "INNER JOIN `order` AS o ON od.order_id = o.id "
				+ "INNER JOIN `products` AS p ON od.product_id = p.id "
				+ "INNER JOIN status AS s ON s.id = o.status "
				+ "WHERE od.order_id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, oid);
			rs = pst.executeQuery();
			while(rs.next()) {
				// get od
				int id = rs.getInt("od.id");
				int price = rs.getInt("od.price");
				int num = rs.getInt("od.num");
				int total_money = rs.getInt("od.total_money");
				// get o
				int user_id = rs.getInt("o.user_id");
				String fullname = rs.getString("o.fullname");
				String email = rs.getString("o.email");
				String phone_number = rs.getString("o.phone_number");
				String address = rs.getString("o.address");
				String note = rs.getString("o.note");
				Timestamp order_date = rs.getTimestamp("o.order_date");
				int status = rs.getInt("o.status");
				String name = rs.getString("s.name");
				String class_name = rs.getString("s.class_name");
				String code = rs.getString("o.code");
				int totalMoney = rs.getInt("o.total_money");
				//get product
				int product_id = rs.getInt("p.id");
				int cat_id = rs.getInt("p.cat_id");
				String title = rs.getString("p.title");
				String picture = rs.getString("p.picture");
				String description = rs.getString("p.description");
				Timestamp create_at = rs.getTimestamp("p.create_at");
				
				Product product = new Product(product_id, new Category(cat_id), title, price, 0, picture, description, create_at);
				Order order = new Order(oid, new User(user_id), fullname, email, phone_number, address, note, order_date, new Status(status, name, class_name), code, totalMoney);
				OrderDetail orderDetail = new OrderDetail(id, order, product, price, num, total_money);
				list.add(orderDetail);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst, rs);
		}
		return list;
	}
}
