package controller.publics;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Cart;
import models.Order;
import models.User;
import utils.AuthUtil;
import utils.StringUtil;

public class PublicCheckout1Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicCheckout1Controller() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/views/public/checkout1.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		if (AuthUtil.CheckLogin(request, response) == false) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		HttpSession session = request.getSession();
		User userLogin = (User) session.getAttribute("userInfo");
		Cart cart = null;
		Object o = session.getAttribute("cart");
		if (o != null) {
			cart = (Cart) o;
		} else {
			cart = new Cart();
		}
		User u = null;
		if ((User) session.getAttribute("userInfo") != null) {
			u = (User) session.getAttribute("userInfo");
		}

		String fullName = request.getParameter("fullname");
		String email = request.getParameter("email");
		String phoneNumber = request.getParameter("phonenumber");
		String note = request.getParameter("note");
		String address = request.getParameter("address");
		SimpleDateFormat sdf = new SimpleDateFormat("ddMMyy");
		String code = sdf.format(new Date()) + StringUtil.OrderCode(8);
		
		int totalMoney = cart.TotalMoney(u);
		
		Order order = new Order(userLogin, fullName, email, phoneNumber, address, note, code, totalMoney);
		session.setAttribute("order", order);
		
		response.sendRedirect(request.getContextPath() + "/checkout2");
		
//		RequestDispatcher rd = request.getRequestDispatcher("/checkout2");
//		rd.forward(request, response);
	}

}
