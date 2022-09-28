package controller.admins;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import constants.DefineConstants;
import daos.UserDAO;
import models.User;

public class AdminIndexUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
	
	public AdminIndexUserController() {
		super();
		userDAO = new UserDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		
		int numberOfUsers = userDAO.getNumberOfUsers();
		int numberOfPages = (int)Math.ceil((float)numberOfUsers/DefineConstants.NUMBER_PER_PAGE_USER);
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}
		int offset = (currentPage - 1) * DefineConstants.NUMBER_PER_PAGE_USER;
		
		List<User> users = userDAO.getPagination(offset);
		
		// search
		if(request.getParameter("search") != null) {
			String search = request.getParameter("search");
			List<User> searchList = userDAO.getSearchList(search);
			users = searchList;
		}
		
		request.setAttribute("users", users);
		request.setAttribute("numberOfUsers", numberOfUsers);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
