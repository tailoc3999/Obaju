package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import models.Item;
import models.Order;
import models.Status;
import models.User;
import utils.ConnectDBUlti;

public class OrderDAO {
	private Connection conn;

	private Statement st;

	private ResultSet rs;

	private PreparedStatement pst;

	public void addOrder(Order order, List<Item> list) {
		try {
			// add order
			String Query = "INSERT INTO `order`(user_id, fullname, email, phone_number, address, note, code, total_money) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			conn = ConnectDBUlti.getConnection();
			pst = conn.prepareStatement(Query);
			pst.setInt(1, order.getUser().getId());
			pst.setString(2, order.getFullname());
			pst.setString(3, order.getEmail());
			pst.setString(4, order.getPhone_number());
			pst.setString(5, order.getAddress());
			pst.setString(6, order.getNote());
			pst.setString(7, order.getCode());
			pst.setInt(8, order.getTotal_money());
			pst.executeUpdate();
			// lay id cua order vua add
			String Query2 = "SELECT id FROM `order` order BY id DESC";
			st = conn.createStatement();
			rs = st.executeQuery(Query2);
			// add Order_detail
			if (rs.next()) {
				int oid = rs.getInt("id");
				for (Item i : list) {
					String Query3 = "INSERT INTO `order_detail`(order_id, product_id, price, num, total_money) "
							+ "VALUES (?, ?, ?, ?, ?)";
					PreparedStatement pst2 = conn.prepareStatement(Query3);
					pst2.setInt(1, oid);
					pst2.setInt(2, i.getProduct().getId());
					pst2.setInt(3, i.getPrice());
					pst2.setInt(4, i.getQuantity());
					pst2.setInt(5, i.getPrice() * i.getQuantity());
					pst2.executeUpdate();
				}
			}
			// cap nhat lai so luong san pham
//			String Query4 = "update products set quantity = quantity - ? where id = ?";
//			PreparedStatement pst3 = conn.prepareStatement(Query4);
//			for (Item i : cart.getItems()) {
//				pst3.setInt(1, i.getQuantity());
//				pst3.setInt(2, i.getProduct().getId());
//				pst3.executeUpdate();
//			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst, rs);
			ConnectDBUlti.close(st);
		}
	}

	public List<Order> getOrderByUserId(User user) {
		List<Order> list = new ArrayList<Order>();
		String Query = "SELECT o.*, s.* FROM `order` AS o INNER JOIN status AS s "
				+ "ON o.status = s.id "
				+ "WHERE user_id = ? "
				+ "ORDER BY o.id DESC";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, user.getId());
			rs = pst.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("o.id");
				String fullname = rs.getString("o.fullname");
				String email = rs.getString("o.email");
				String phone_number = rs.getString("o.phone_number");
				String address = rs.getString("o.address");
				String note = rs.getString("o.note");
				Timestamp order_date = rs.getTimestamp("o.order_date");
				Status status = new Status(rs.getInt("s.id"), rs.getString("s.name"), rs.getString("s.class_name"));
				String code = rs.getString("o.code");
				int totalMoney = rs.getInt("o.total_money");
				Order order = new Order(id, user, fullname, email, phone_number, address, note, order_date, status, code, totalMoney);
				list.add(order);
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
