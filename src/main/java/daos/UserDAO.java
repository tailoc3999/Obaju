package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import constants.DefineConstants;
import models.Role;
import models.User;
import utils.ConnectDBUlti;

public class UserDAO {
	private Connection conn;

	private Statement st;

	private ResultSet rs;

	private PreparedStatement pst;

	public List<User> getAll() {
		List<User> users = new ArrayList<User>();
		conn = ConnectDBUlti.getConnection();
		String Query = "SELECT u.*, r.* "
				+ "FROM users AS u "
				+ "INNER JOIN role AS r "
				+ "ON u.role_id = r.id "
				+ "ORDER BY u.id DESC";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(Query);
			while (rs.next()) {
				int id = rs.getInt("u.id");
				String fullname = rs.getString("fullname");
				String email = rs.getString("email");
				String phone_number = rs.getString("phone_number");
				String address = rs.getString("address");
				String password = rs.getString("password");
				Role role = new Role(rs.getInt("r.id"), rs.getString("name"));
				User user = new User(id, fullname, email, phone_number, address, password, role);
				users.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, st, rs);
		}

		return users;
	}
	
	public int getNumberOfUsers() {
		conn = ConnectDBUlti.getConnection();
		String Query = "SELECT COUNT(*) AS c FROM users";
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
	
	public List<User> getPagination(int offset) {
		List<User> users = new ArrayList<User>();
		conn = ConnectDBUlti.getConnection();
		String Query = "SELECT u.*, r.* "
				+ "FROM users AS u "
				+ "INNER JOIN role AS r "
				+ "ON u.role_id = r.id "
				+ "ORDER BY u.id DESC "
				+ "LIMIT ?, ?";
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, offset);
			pst.setInt(2, DefineConstants.NUMBER_PER_PAGE_USER);
			rs = pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("u.id");
				String fullname = rs.getString("fullname");
				String email = rs.getString("email");
				String phone_number = rs.getString("phone_number");
				String address = rs.getString("address");
				String password = rs.getString("password");
				Role role = new Role(rs.getInt("r.id"), rs.getString("name"));
				User user = new User(id, fullname, email, phone_number, address, password, role);
				users.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst, rs);
		}

		return users;
	}
	

	public int add(User user) {
		int result = 0;
		conn = ConnectDBUlti.getConnection();
		String Query = "INSERT INTO users(`fullname`, `email`, `phone_number`, `address`, `password`, `role_id`) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pst = conn.prepareStatement(Query);
			pst.setString(1, user.getFullname());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPhone_number());
			pst.setString(4, user.getAddress());
			pst.setString(5, user.getPassword());
			pst.setInt(6, user.getRole().getId());
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst);
		}
		return result;
	}

	public int checkDuplicate(String email) {
		String Query = "SELECT * FROM users WHERE email = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setString(1, email);
			rs = pst.executeQuery();
			if(rs.next()) {
				return 1;
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

	public User getById(int id) {
		User user = null;
		String Query = "SELECT u.*, r.* "
				+ "FROM users AS u "
				+ "INNER JOIN role AS r "
				+ "ON u.role_id = r.id "
				+ "WHERE u.id = ? "
				+ "ORDER BY u.id DESC";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if(rs.next()) {
				String fullname = rs.getString("u.fullname");
				String email = rs.getString("u.email");
				String phone_number = rs.getString("u.phone_number");
				String address = rs.getString("u.address");
				String password = rs.getString("u.password");
				Role role = new Role(rs.getInt("r.id"), rs.getString("r.name"));
				user = new User(id, fullname, email, phone_number, address, password, role);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst, rs);
		}
		return user;
	}

	public int edit(User user) {
		String Query = "UPDATE users "
				+ "SET fullname = ?, phone_number = ?, address = ?, password = ?, role_id = ? "
				+ "WHERE id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setString(1, user.getFullname());
			pst.setString(2, user.getPhone_number());
			pst.setString(3, user.getAddress());
			pst.setString(4, user.getPassword());
			pst.setInt(5, user.getRole().getId());
			pst.setInt(6, user.getId());
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

	public int del(int id) {
		String Query = "DELETE FROM users WHERE id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setInt(1, id);
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

	public User getByUsernameAndPassword(String email, String password) {
		String Query = "SELECT * "
				+ "FROM users "
				+ "WHERE email = ? AND password = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setString(1, email);
			pst.setString(2, password);
			rs = pst.executeQuery();
			if(rs.next()) {
				int id = rs.getInt("id");
				String fullname = rs.getString("fullname");
				String phone_number = rs.getString("phone_number");
				String address = rs.getString("address");
				int role_id = rs.getInt("role_id");
				User item = new User(id, fullname, email, phone_number, address, password, new Role(role_id));
				return item;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} finally {
			ConnectDBUlti.close(conn, pst, rs);
		}
		return null;
	}
	
	
	public int register(User user) {
		String Query = "INSERT INTO users(fullname, email, password) VALUES (?, ?, ?)";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setString(1, user.getFullname());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPassword());
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
	
	public int editInfo(User user) {
		String Query = "UPDATE users SET fullname = ?, email = ?, phone_number = ?, address = ? WHERE id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setString(1, user.getFullname());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPhone_number());
			pst.setString(4, user.getAddress());
			pst.setInt(5, user.getId());
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

	public int editPassword(User user) {
		String Query = "UPDATE users SET password = ? WHERE id = ?";
		conn = ConnectDBUlti.getConnection();
		try {
			pst = conn.prepareStatement(Query);
			pst.setString(1, user.getPassword());
			pst.setInt(2, user.getId());
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

	public static void main(String[] args) {
		UserDAO dao = new UserDAO();
		User a = dao.getByUsernameAndPassword("taitranhuu08@gmail.com", "123456");
		System.out.println(a);
	}

}
