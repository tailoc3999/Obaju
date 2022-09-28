package controller.admins;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import constants.DefineConstants;
import daos.ProductDAO;
import models.Product;

public class AdminIndexProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;

	public AdminIndexProductController() {
		super();
		productDAO = new ProductDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int NumberOfProducts = productDAO.getNumberOfProducts();
		int NumberOfPages = (int) Math.ceil((float) NumberOfProducts / DefineConstants.NUMBER_PER_PAGE_PRODUCT);
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		if (currentPage < 1 || currentPage > NumberOfPages) {
			currentPage = 1;
		}
		int offset = (currentPage - 1) * DefineConstants.NUMBER_PER_PAGE_PRODUCT;

		List<Product> products = productDAO.getPagination(offset);
		
		// search
		if(request.getParameter("search") != null) {
			String search = request.getParameter("search");
			List<Product> searchList = productDAO.getSearchList(search);
			products = searchList;
		}

		request.setAttribute("products", products);
		request.setAttribute("numberofproducts", NumberOfProducts);
		request.setAttribute("numberofpages", NumberOfPages);
		request.setAttribute("currentpage", currentPage);

		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/product/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
