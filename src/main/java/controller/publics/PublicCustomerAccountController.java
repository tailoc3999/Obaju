package controller.publics;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.UserDAO;
import models.User;
import utils.AuthUtil;
import utils.StringUtil;

public class PublicCustomerAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

	public PublicCustomerAccountController() {
		super();
		userDAO = new UserDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (AuthUtil.CheckLogin(request, response) == false) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		// edit info user
		String fix = request.getParameter("fix");
		if("true".equals(fix)) {
			HttpSession session = request.getSession();
			User userLogin = (User) session.getAttribute("userInfo");
			String fullname = request.getParameter("fullname");
			String phoneNumber = request.getParameter("phonenumber");
			String address = request.getParameter("address");
			userLogin.setFullname(fullname);
			userLogin.setPhone_number(phoneNumber);
			userLogin.setAddress(address);
			if(userDAO.editInfo(userLogin) > 0) {
				response.sendRedirect(request.getContextPath() + "/profile?msg=1");
				return;
			} else {
				response.sendRedirect(request.getContextPath() + "/profile?err=1");
				return;
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/public/customer-account.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (AuthUtil.CheckLogin(request, response) == false) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("userInfo");
		
		String old_password = request.getParameter("password_old");
		String new_password = request.getParameter("password_1");
		
		if(user.getPassword().equals(StringUtil.md5(old_password))) {
			user.setPassword(StringUtil.md5(new_password));
			if(userDAO.editPassword(user) > 0) {
				response.sendRedirect(request.getContextPath() + "/profile?msg=1");
				return;
			} else {
				response.sendRedirect(request.getContextPath() + "/profile?err=1");
				return;
			}
		} else {
			response.sendRedirect(request.getContextPath() + "/profile?err=2");
			return;
		}
		
	}

}
