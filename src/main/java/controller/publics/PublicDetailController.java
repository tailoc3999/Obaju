package controller.publics;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.GaleryDAO;
import daos.ProductDAO;
import models.Galery;
import models.Product;

public class PublicDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;
	private GaleryDAO galeryDAO;

	public PublicDetailController() {
		super();
		productDAO = new ProductDAO();
		galeryDAO = new GaleryDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/404");
			return;
		}
		
		Product product = productDAO.getbyId(id);
		
		// get image
		List<Galery> images = galeryDAO.getByProductId(id);
		
		// get recently products
		List<Product> recentList = productDAO.getByCatId2(product.getCat().getId(), id);
		
		request.setAttribute("product", product);
		request.setAttribute("recentlist", recentList);
		request.setAttribute("images", images);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/public/detail.jsp");
		rd.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
