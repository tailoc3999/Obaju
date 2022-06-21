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

public class AdminEditUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

	public AdminEditUserController() {
		super();
		userDAO = new UserDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/admin/user/index?err=1");
			return;
		}
		User user = userDAO.getById(id);
		if(user == null) {
			response.sendRedirect(request.getContextPath() + "/admin/user/index?err=1");
			return;
		}
		request.setAttribute("user", user);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user/edit.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/admin/user/index?err=1");
			return;
		}
		
		String fullname = request.getParameter("fullname");
		String phone_number = request.getParameter("phonenumber");
		String address = request.getParameter("address");
		String password = request.getParameter("password");
		int role_id = 0;
		try {
			role_id = Integer.parseInt(request.getParameter("role"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		User oldUser = userDAO.getById(id);
		if(oldUser != null) {
			oldUser.setFullname(fullname);
			oldUser.setPhone_number(phone_number);
			oldUser.setAddress(address);
			if(!"".equals(password)) {
				password = StringUtil.md5(password);
				oldUser.setPassword(password);
			}
			oldUser.setRole(new Role(role_id));
		}
		
		if(userDAO.edit(oldUser) == 1) {
			System.out.println("success");
			response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=2");
			return;
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user/edit.jsp?err=2&id=" + id);
			rd.forward(request, response);
			return;
		}
	}

}