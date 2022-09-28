package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Status;
import utils.ConnectDBUlti;

public class StatusDAO {
	private Connection conn;
	
	private Statement st;
	
	private ResultSet rs;
	
	private PreparedStatement pst;

	public List<Status> getAll() {
		List<Status> list = new ArrayList<Status>();
		String Query = "SELECT * FROM `status` ORDER BY id ASC";
		conn = ConnectDBUlti.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(Query);
			while(rs.next()) {
				Status item = new Status(rs.getInt("id"), rs.getString("name"), rs.getString("class_name"));
				list.add(item);
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
