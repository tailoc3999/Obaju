package controller.admins;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.OrderDetailDAO;
import models.OrderDetail;

public class AdminOrderDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDetailDAO orderDetailDAO;

	public AdminOrderDetailController() {
		super();
		orderDetailDAO = new OrderDetailDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/admin/order/index?err=1");
			return;
		}
		
		List<OrderDetail> list = orderDetailDAO.getOrderDetailById(id);
		
		request.setAttribute("orderDetailList", list);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/order/detail.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
