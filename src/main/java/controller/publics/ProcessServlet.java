package controller.publics;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Cart;
import models.Item;
import models.User;

@WebServlet("/process")
public class ProcessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProcessServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Cart cart = null;
		Object o = session.getAttribute("cart");

		if (o != null) {
			cart = (Cart) o;
		} else {
			cart = new Cart();
		}
		User user = (User)session.getAttribute("userInfo");
		List<Item> list = cart.getItemsByUser(user);
		
		
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {
			
		}
		for(Item item : list) {
			if(item.getProduct().getId() == id) {
				cart.removeItem(id);
			}
		}
		
		list = cart.getItemsByUser(user);
		session.setAttribute("cart", cart);
		session.setAttribute("size", list.size());
		response.sendRedirect(request.getContextPath() + "/basket");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Cart cart = null;
		Object o = session.getAttribute("cart");

		if (o != null) {
			cart = (Cart) o;
		} else {
			cart = new Cart();
		}
		User user = (User)session.getAttribute("userInfo");
		List<Item> list = cart.getItemsByUser(user);
		
		for(Item item : list) {
			StringBuilder number = new StringBuilder();
			int num = Integer.parseInt(request.getParameter(number.append(item.getProduct().getId()).toString()));
			if(num < 1) {
				cart.removeItem(item.getProduct().getId());
			}
			
			item.setQuantity(num);
		}
		
		list = cart.getItemsByUser(user);
		session.setAttribute("cart", cart);
		session.setAttribute("size", list.size());
		response.sendRedirect(request.getContextPath() + "/basket");
	}

}
