package controller.admins;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import constants.DefineConstants;
import daos.OrderDAO;
import daos.StatusDAO;
import models.Order;
import models.Status;

public class AdminOrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO;
	private StatusDAO statusDAO;

	public AdminOrderController() {
		super();
		orderDAO = new OrderDAO();
		statusDAO = new StatusDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int numberOfOrders = orderDAO.getNumberOfOrders();
		int numberOfPages = (int) Math.ceil((float)numberOfOrders / DefineConstants.NUMBER_PER_PAGE_ORDER);
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		
		if(currentPage < 0 || currentPage > numberOfPages) {
			currentPage = 1;
		}
		
		int offset = (currentPage - 1) * DefineConstants.NUMBER_PER_PAGE_ORDER;
		
		List<Order> orders = orderDAO.getPagination(offset);
		List<Status> status = statusDAO.getAll();
		
		if(request.getParameter("search") != null) {
			String search = request.getParameter("search");
			List<Order> searchList = orderDAO.getSearchList(search);
			numberOfOrders = 0;
			numberOfPages = 0;
			
			orders = searchList;
		}
		
		request.setAttribute("numberoforders", numberOfOrders);
		request.setAttribute("numberofpages", numberOfPages);
		request.setAttribute("currentpage", currentPage);
		request.setAttribute("status", status);
		request.setAttribute("orders", orders);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/order/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//get sid
		int sid = 0;
		try {
			sid = Integer.parseInt(request.getParameter("sid"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// get order id
		int oid = 0;
		try {
			oid = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// change sid
		if(orderDAO.editStatus(oid, sid) > 0) {
			// success
			response.sendRedirect(request.getContextPath() + "/admin/order/index?msg=1");
			return;
		} else {
			// fail
			response.sendRedirect(request.getContextPath() + "/admin/order/index?err=1");
			return;
		}
	}

}
