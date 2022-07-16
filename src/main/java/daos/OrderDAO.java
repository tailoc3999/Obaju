package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import models.Cart;
import models.Item;
import models.User;
import utils.ConnectDBUlti;

public class OrderDAO {
	private Connection conn;

	private Statement st;

	private ResultSet rs;

	private PreparedStatement pst;

	public void addOrder(User user, Cart cart) {
		try {
			// add order
			String Query = "insert into [Order] (user_id, total_money) " + "values(?, ?)";
			conn = ConnectDBUlti.getConnection();
			pst = conn.prepareStatement(Query);
			pst.setInt(1, user.getId());
			pst.setInt(2, cart.TotalMoney());
			pst.executeUpdate();
			// lay id cua order vua add
			String Query2 = "select top 1 id from [order] order by id desc";
			st = conn.createStatement();
			rs = st.executeQuery(Query2);
			// add Order_detail
			if (rs.next()) {
				int oid = rs.getInt("id");
				for (Item i : cart.getItems()) {
					String Query3 = "insert into [Order_Detail] values (?, ?, ?, ?)";
					PreparedStatement pst2 = conn.prepareStatement(Query3);
					pst2.setInt(1, oid);
					pst2.setInt(2, i.getProduct().getId());
					pst2.setInt(3, i.getPrice());
					pst2.setInt(4, i.getQuantity());
					pst2.executeUpdate();
				}
			}
			// cap nhat lai so luong san pham
			String Query4 = "update products set quantity = quantity - ? where id = ?";
			PreparedStatement pst3 = conn.prepareStatement(Query4);
			for (Item i : cart.getItems()) {
				pst3.setInt(1, i.getQuantity());
				pst3.setInt(2, i.getProduct().getId());
				pst3.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
