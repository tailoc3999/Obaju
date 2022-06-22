package controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.UserDAO;
import models.User;
import utils.StringUtil;

public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

	public RegisterController() {
		super();
		userDAO = new UserDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		// validate
		fullname = StringUtil.delSpace(fullname);
		email = StringUtil.delSpace(email);
		password = StringUtil.delSpace(password);
		password = StringUtil.md5(password);
		User user = new User(fullname, email, password);
		if(userDAO.register(user) > 0) {
			HttpSession session = request.getSession();
			session.setAttribute("userInfo", user);
			response.sendRedirect(request.getContextPath() + "/purchase");
			return;
		} else {
			response.sendRedirect(request.getContextPath() + "/auth/login?err=1");
			return;
		}
	}

}
