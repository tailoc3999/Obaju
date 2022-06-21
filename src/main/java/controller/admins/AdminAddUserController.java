package controller.admins;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.UserDAO;
import models.Role;
import models.User;
import utils.StringUtil;

public class AdminAddUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

	public AdminAddUserController() {
		super();
		userDAO = new UserDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user/add.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String phone_number = request.getParameter("phonenumber");
		String address = request.getParameter("address");
		int role_id = 0;
		try {
			role_id = Integer.parseInt(request.getParameter("role"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user/add.jsp?err=1");
			rd.forward(request, response);
			return;
		}
		
		// validate
		fullname = StringUtil.delSpace(fullname);
		email = StringUtil.delSpace(email);
		password = StringUtil.delSpace(password);
		password = StringUtil.md5(password);
		phone_number = StringUtil.delSpace(phone_number);
		address = StringUtil.delSpace(address);
		if(userDAO.checkDuplicate(email) == 1) {
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user/add.jsp?err=3");
			rd.forward(request, response);
			return;
		}
		
		Role role = new Role(role_id);
		User user = new User(fullname, email, phone_number, address, password, role);
		if(userDAO.add(user) == 1) {
			response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=1");
			return;
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user/add.jsp?err=2");
			rd.forward(request, response);
			return;
		}
	}

}
