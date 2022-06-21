package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Category;
import utils.ConnectDBUlti;

public class CategoryDAO {
	private Connection conn;
	
	private Statement st;
	
	private ResultSet rs;
	
	private PreparedStatement pst;

	public List<Category> getAll() {
		List<Category> list = new ArrayList<Category>();
		String Query = "SELECT * FROM categories ORDER BY id DESC";
		conn = ConnectDBUlti.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(Query);
			while(rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				Category cat = new Category(id, name);
				list.add(cat);
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
	public static void main(String[] args) {
		CategoryDAO categoryDAO = new CategoryDAO();
		List<Category> cat = categoryDAO.getAll();
		System.out.println(cat);
	}
}
