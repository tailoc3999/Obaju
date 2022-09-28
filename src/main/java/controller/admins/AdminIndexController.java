package controller.admins;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.OrderDAO;
import daos.ProductDAO;
import daos.UserDAO;

public class AdminIndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;
	private UserDAO userDAO;
	private OrderDAO orderDAO;

	public AdminIndexController() {
		super();
		productDAO = new ProductDAO();
		userDAO = new UserDAO();
		orderDAO = new OrderDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int numberOfProducts = productDAO.getNumberOfProducts();
		int numberOfUsers = userDAO.getNumberOfUsers();
		int numberOfOrders = orderDAO.getNumberOfOrders();
		
		request.setAttribute("numberofproducts", numberOfProducts);
		request.setAttribute("numberofusers", numberOfUsers);
		request.setAttribute("numberoforders", numberOfOrders);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
