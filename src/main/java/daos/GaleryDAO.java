package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Galery;
import models.Product;
import utils.ConnectDBUlti;

public class GaleryDAO {
	private Connection conn;
	
	private Statement st;
	
	private ResultSet rs;
	
	private PreparedStatement pst;

	public List<Galery> getByProductId(int id) {
		List<Galery> list = new ArrayList<Galery>();
		String Query = "SELECT * FROM `galery` WHERE product_id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while(rs.next()) {
				Galery item = new Galery(rs.getInt("id"), new Product(id), rs.getString("picture"));
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
