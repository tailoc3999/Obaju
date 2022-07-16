package controller.publics;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.ProductDAO;
import models.Cart;
import models.Item;
import models.Product;
import models.User;
import utils.AuthUtil;

public class BuyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProductDAO productDAO;

	public BuyServlet() {
		super();
		productDAO = new ProductDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

		int id;
		User u = null;
		try {
			id = Integer.parseInt(request.getParameter("id"));
			Product product = productDAO.getbyId(id);
			Item t;
			u = (User) session.getAttribute("userInfo");
			t = new Item(u, product, 1, product.getPrice());

			cart.addItem(t);
		} catch (NumberFormatException e) {
			u = (User) session.getAttribute("userInfo");
		}
		List<Item> list = cart.getItemsByUser(u);
		session.setAttribute("cart", cart);
		session.setAttribute("size", list.size());
		// get old url
		String url = request.getHeader("referer");
		response.sendRedirect(url);
//		request.getRequestDispatcher("/myshop.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
