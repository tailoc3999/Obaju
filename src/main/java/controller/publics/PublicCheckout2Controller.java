package controller.publics;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.OrderDAO;
import models.Cart;
import models.Item;
import models.Order;
import models.User;
import utils.AuthUtil;

public class PublicCheckout2Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO;

	public PublicCheckout2Controller() {
		super();
		orderDAO = new OrderDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (AuthUtil.CheckLogin(request, response) == false) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/public/checkout4.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (AuthUtil.CheckLogin(request, response) == false) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
			
		HttpSession session = request.getSession();
		Cart cart = null;
    	Object o = session.getAttribute("cart");
		if (o != null) {
			cart = (Cart) o;
		} else {
			cart = new Cart();
		}
    	User u = (User) session.getAttribute("userInfo");
    	List<Item> list = cart.getItemsByUser(u);
    	Order order = (Order) session.getAttribute("order");
    	
    	if(u != null && order != null) {
    		orderDAO.addOrder(order, list);
    		session.removeAttribute("order");
    		cart.removeItem2(list);
    		session.removeAttribute("size");
    		
    		response.sendRedirect(request.getContextPath() + "/purchase");
			return;
    	}
	}
}
