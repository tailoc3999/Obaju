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
				+ "ORDER BY o.order_date DESC";
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

	public List<Order> getAllOrder() {
		List<Order> list = new ArrayList<Order>();
		String Query = "SELECT o.*, s.*, u.fullname FROM `order` AS o INNER JOIN status AS s "
				+ "ON o.status = s.id "
				+ "INNER JOIN users AS u ON o.user_id = u.id "
				+ "ORDER BY o.status ASC ";
		conn = ConnectDBUlti.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(Query);
			while(rs.next()) {
				int id = rs.getInt("o.id");
				int user_id = rs.getInt("o.user_id");
				String name = rs.getString("u.fullname");
				String fullname = rs.getString("o.fullname");
				String email = rs.getString("o.email");
				String phone_number = rs.getString("o.phone_number");
				String address = rs.getString("o.address");
				String note = rs.getString("o.note");
				Timestamp order_date = rs.getTimestamp("o.order_date");
				Status status = new Status(rs.getInt("s.id"), rs.getString("s.name"), rs.getString("s.class_name"));
				String code = rs.getString("o.code");
				int totalMoney = rs.getInt("o.total_money");
				Order order = new Order(id, new User(user_id, name, email, null, null, null, null), fullname, email, phone_number, address, note, order_date, status, code, totalMoney);
				list.add(order);
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

	public int editStatus(int oid, int sid) {
		String Query = "UPDATE `order` SET `status`= ? WHERE  id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, sid);
			pst.setInt(2, oid);
			int result = pst.executeUpdate();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst);
		}
		
		return 0;
	}

	public int getNumberOfOrders() {
		conn = ConnectDBUlti.getConnection();
		String Query = "SELECT COUNT(*) AS c FROM `order`";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(Query);
			if(rs.next()) {
				int number = rs.getInt("c");
				return number;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, st, rs);
		}
		
		return 0;
	}

	public List<Order> getPagination(int offset) {
		List<Order> list = new ArrayList<Order>();
		String Query = "SELECT o.*, s.*, u.fullname FROM `order` AS o INNER JOIN status AS s "
				+ "ON o.status = s.id "
				+ "INNER JOIN users AS u ON o.user_id = u.id "
				+ "ORDER BY o.status ASC "
				+ "LIMIT ?, ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, offset);
			pst.setInt(2, DefineConstants.NUMBER_PER_PAGE_ORDER);
			rs = pst.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("o.id");
				int user_id = rs.getInt("o.user_id");
				String name = rs.getString("u.fullname");
				String fullname = rs.getString("o.fullname");
				String email = rs.getString("o.email");
				String phone_number = rs.getString("o.phone_number");
				String address = rs.getString("o.address");
				String note = rs.getString("o.note");
				Timestamp order_date = rs.getTimestamp("o.order_date");
				Status status = new Status(rs.getInt("s.id"), rs.getString("s.name"), rs.getString("s.class_name"));
				String code = rs.getString("o.code");
				int totalMoney = rs.getInt("o.total_money");
				Order order = new Order(id, new User(user_id, name, email, null, null, null, null), fullname, email, phone_number, address, note, order_date, status, code, totalMoney);
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
	public static void main(String[] args) {
		OrderDAO a = new OrderDAO();
		List<Order> b = a.getSearchList("DonHang");
		System.out.println(b);
	}

	public List<Order> getSearchList(String search) {
		List<Order> list = new ArrayList<Order>();
		String Query = "SELECT o.*, s.*, u.fullname FROM `order` AS o INNER JOIN status AS s "
				+ "ON o.status = s.id "
				+ "INNER JOIN users AS u ON o.user_id = u.id "
				+ "WHERE o.code LIKE ? "
				+ "ORDER BY o.status ASC ";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setString(1,"%" + search + "%");
			rs = pst.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("o.id");
				int user_id = rs.getInt("o.user_id");
				String name = rs.getString("u.fullname");
				String fullname = rs.getString("o.fullname");
				String email = rs.getString("o.email");
				String phone_number = rs.getString("o.phone_number");
				String address = rs.getString("o.address");
				String note = rs.getString("o.note");
				Timestamp order_date = rs.getTimestamp("o.order_date");
				Status status = new Status(rs.getInt("s.id"), rs.getString("s.name"), rs.getString("s.class_name"));
				String code = rs.getString("o.code");
				int totalMoney = rs.getInt("o.total_money");
				Order order = new Order(id, new User(user_id, name, email, null, null, null, null), fullname, email, phone_number, address, note, order_date, status, code, totalMoney);
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
